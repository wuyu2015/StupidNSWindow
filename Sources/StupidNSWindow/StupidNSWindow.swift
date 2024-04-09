import Cocoa

open class StupidNSWindow: NSWindow  {
    // MARK: Magic Numbers
    private static let TITLEBAR_HEIGHT_NORMAL: CGFloat = 22.0
    private static let TABBAR_HEIGHT: CGFloat = 25.0
    private static let WINDOW_BUTTON_WIDTH: CGFloat = 14.0
    private static let WINDOW_BUTTON_HEIGHT: CGFloat = 16.0
    private static let WINDOW_BUTTON_CLOSE_MARGIN_LEFT_NORMAL: CGFloat = 7.0
    private static let WINDOW_BUTTON_CLOSE_MARGIN_LEFT_LARGE: CGFloat = 10.0
    private static let WINDOW_BUTTON_MINIATURIZE_OFFSET: CGFloat = 20.0
    private static let WINDOW_BUTTON_ZOOM_OFFSET: CGFloat = 40.0
    
    private var windowButtonMarginTop: CGFloat = 0
    
    // MARK: Window Buttons Properties
    // The red button
    public lazy var closeButton: NSButton? = {
        return standardWindowButton(.closeButton)
    }()
    
     // The yellow button
    public lazy var miniaturizeButton: NSButton? = {
        return standardWindowButton(.miniaturizeButton)
    }()
    
     // The green button
    public lazy var zoomButton: NSButton? = {
        return standardWindowButton(.zoomButton)
    }()
    
    // MARK: Window Structure
    public lazy var titleTextField: NSTextField? = {
        if let titlebarView = titlebarView {
            for subView in titlebarView.subviews.reversed() {
                if (subView is NSTextField) {
                    return subView as? NSTextField
                }
            }
        }
        return nil
    }()
    
    public lazy var titlebarView: NSView? = {
        if let closeButton = closeButton {
            return closeButton.superview!
        }
        
        if let contentView = contentView {
            for subView1 in contentView.superview!.subviews.reversed() {
                for subView2 in subView1.subviews {
                    for subView3 in subView2.subviews.reversed() {
                        if (subView3 is NSTextField) {
                            titleTextField = subView3 as? NSTextField
                            titlebarContainerView = subView1 // NSTitlebarContainerView
                            return subView2 // NSTitlebarView
                        }
                    }
                }
            }
        }
        return nil
    }()
    
    public lazy var titlebarDecorationView: NSView? = {
        if let view = titlebarContainerView?.subviews.last, view != titlebarView {
            return view
        }
        return nil
    }()
    
    public lazy var titlebarBackgroundView: NSView? = {
        if let titlebarView = titlebarView {
            let view = StupidNSWindowBarBackgroundView(frame: NSRect(x: 0, y: 0, width: titlebarView.frame.size.width, height: titlebarView.frame.size.height))
            titlebarView.addSubview(view, positioned: .below, relativeTo: nil)
            if let titleTextField = titleTextField {
                // Move titleTextField to bottom
                titleTextField.removeFromSuperview()
                titlebarView.addSubview(titleTextField, positioned: .below, relativeTo: nil)
            }
            return view
        }
        return nil
    }()
    
    public lazy var titlebarContainerView: NSView? = {
        return titlebarView?.superview // NSTitlebarContainerView
    }()
    
    public lazy var themeFrame: NSView = {
        if let titlebarContainerView = titlebarContainerView {
            return titlebarContainerView.superview! // NSThemeFrame
        }
        if let contentView = contentView {
            return contentView.superview! // NSNextStepFrame
        }
        fatalError("NSThemeFrame or NSNextStepFrame not found")
    }()
    
    public var isFullScreen: Bool {
        return styleMask.contains(.fullScreen)
    }
    
    public var isTabWindow: Bool {
        guard let titlebarView = titlebarView else {
            return false
        }
        if titlebarView.subviews.count < 5 {
            return false
        }
        for subView in titlebarView.subviews {
            if subView.subviews.count == 0 {
                continue
            }
            for subSubView in subView.subviews {
                if subSubView.subviews.count == 0 {
                    continue
                }
                // meet NSTitlebarAccessoryClipView
                return true
            }
        }
        return false
    }
    
    public var titlebarHeight: CGFloat = StupidNSWindow.TITLEBAR_HEIGHT_NORMAL {
        didSet {
            if titlebarHeight != oldValue && titlebarHeight > 0 {
                windowButtonMarginTop = (titlebarHeight - Self.WINDOW_BUTTON_HEIGHT) / 2
                minSize = NSSize(width: minSize.width, height: titlebarHeight)
            }
        }
    }
    
    public var minHeight: CGFloat = 0 {
        didSet {
            if minHeight != oldValue && minHeight > 0 {
                minSize = NSSize(width: minSize.width, height: minHeight)
            }
        }
    }
    
    override public func layoutIfNeeded() {
        super.layoutIfNeeded();
        // Fight with macOS
        if let titlebarView = titlebarView, let titlebarContainerView = titlebarContainerView, !isFullScreen && titlebarHeight != Self.TITLEBAR_HEIGHT_NORMAL {
            titlebarContainerView.frame.size.height = titlebarHeight
            titlebarContainerView.frame.origin.y = themeFrame.frame.size.height - titlebarHeight
            
            if let titlebarBackgroundView = titlebarBackgroundView {
                titlebarBackgroundView.frame.size = titlebarView.frame.size
            }
            
            if let closeButton = closeButton {
                let marginLeft = titlebarHeight > Self.TITLEBAR_HEIGHT_NORMAL ? Self.WINDOW_BUTTON_CLOSE_MARGIN_LEFT_LARGE : Self.WINDOW_BUTTON_CLOSE_MARGIN_LEFT_NORMAL
                closeButton.frame.origin.x = marginLeft
                closeButton.frame.origin.y = windowButtonMarginTop
                miniaturizeButton!.frame.origin.x = marginLeft + Self.WINDOW_BUTTON_MINIATURIZE_OFFSET
                miniaturizeButton!.frame.origin.y = windowButtonMarginTop
                zoomButton!.frame.origin.x = marginLeft + Self.WINDOW_BUTTON_ZOOM_OFFSET
                zoomButton!.frame.origin.y = windowButtonMarginTop
            }
            
            if titleTextField != nil && titleVisibility != .hidden {
                // if macOS delete the old titleTextField
                if titleTextField!.superview == nil {
                    titleTextField = nil
                    for subView in titlebarView.subviews.reversed() {
                        if (subView is NSTextField) {
                            // Move titleTextField to bottom
                            subView.removeFromSuperview()
                            titlebarView.addSubview(subView, positioned: .below, relativeTo: nil)
                            titleTextField = subView as? NSTextField
                            break
                        }
                    }
                }
                if let titleTextField = titleTextField {
                    titleTextField.frame.origin.x = (titlebarView.frame.size.width - titleTextField.frame.size.width) / 2
                    titleTextField.frame.origin.y = (titlebarHeight - titleTextField.frame.size.height) / 2
                }
            }
            
            if let contentView = contentView {
                contentView.frame.size.height = frame.size.height - titlebarHeight
            }
            
            if let titlebarDecorationView = titlebarDecorationView {
                titlebarDecorationView.frame.size.height = titlebarHeight
            }
        }
    }
}
