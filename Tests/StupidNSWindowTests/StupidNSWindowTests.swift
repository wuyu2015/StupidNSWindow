import XCTest
@testable import StupidNSWindow

final class StupidNSWindowTests: XCTestCase {
    
    func testWithoutTitlebarWithoutButtons() {
        let styles: [NSWindow.StyleMask] = [
            [],
            [.borderless],
            [.closable],
            [.miniaturizable],
            [.resizable],
            [.unifiedTitleAndToolbar],
            [.fullSizeContentView],
            [.utilityWindow],
            [.docModalWindow],
            [.nonactivatingPanel],
            [.hudWindow],
        ]
        for style in styles {
            let window = StupidNSWindow(contentRect: NSRect(), styleMask: style, backing: .buffered, defer: false)
            XCTAssertNil(window.closeButton)
            XCTAssertNil(window.miniaturizeButton)
            XCTAssertNil(window.zoomButton)
            XCTAssertNil(window.titlebarView)
            XCTAssertNil(window.titlebarContainerView)
            XCTAssertNotNil(window.themeFrame)
            XCTAssertEqual(window.isFullScreen, style.contains(.fullScreen))
            XCTAssertFalse(window.isTabWindow)
        }
    }
    
    func testWithTitlebarWithoutButtons() {
        let styles: [NSWindow.StyleMask] = [
            [.titled],
            [.titled, .borderless],
        ]
        for style in styles {
            let window = StupidNSWindow(contentRect: NSRect(), styleMask: style, backing: .buffered, defer: false)
            XCTAssertNil(window.closeButton)
            XCTAssertNil(window.miniaturizeButton)
            XCTAssertNil(window.zoomButton)
            XCTAssertNotNil(window.titlebarView)
            XCTAssertNotNil(window.titlebarContainerView)
            XCTAssertNotNil(window.themeFrame)
            XCTAssertEqual(window.isFullScreen, style.contains(.fullScreen))
            XCTAssertFalse(window.isTabWindow)
        }
    }
    
    func testWithTitlebarHeight0WithoutButtons() {
        let styles: [NSWindow.StyleMask] = [
            [.titled, .docModalWindow],
            [.titled, .closable, .docModalWindow],
        ]
        for style in styles {
            let window = StupidNSWindow(contentRect: NSRect(), styleMask: style, backing: .buffered, defer: false)
            XCTAssertNil(window.closeButton)
            XCTAssertNil(window.miniaturizeButton)
            XCTAssertNil(window.zoomButton)
            XCTAssertNotNil(window.titlebarView)
            XCTAssertNotNil(window.titlebarContainerView)
            XCTAssertNotNil(window.themeFrame)
            XCTAssertEqual(window.titlebarView?.frame.size.height, 0)
            XCTAssertEqual(window.titlebarContainerView?.frame.size.height, 0)
            XCTAssertEqual(window.isFullScreen, style.contains(.fullScreen))
            XCTAssertFalse(window.isTabWindow)
        }
    }
    
    func testWithTitlebarWithButtons() {
        let styles: [NSWindow.StyleMask] = [
            [.titled, .closable],
            [.titled, .miniaturizable],
            [.titled, .resizable],
            [.titled, .closable, .unifiedTitleAndToolbar],
            [.titled, .closable, .fullSizeContentView],
            [.titled, .closable, .utilityWindow],
            [.titled, .closable, .nonactivatingPanel],
            [.titled, .closable, .hudWindow],
            [.titled, .fullScreen],
            [.fullScreen],
        ]
        for style in styles {
            let window = StupidNSWindow(contentRect: NSRect(), styleMask: style, backing: .buffered, defer: false)
            XCTAssertNotNil(window.closeButton)
            XCTAssertNotNil(window.miniaturizeButton)
            XCTAssertNotNil(window.zoomButton)
            XCTAssertNotNil(window.titlebarView)
            XCTAssertNotNil(window.titlebarContainerView)
            XCTAssertNotNil(window.themeFrame)
            XCTAssertEqual(window.titlebarView?.frame.size.height, 22)
            XCTAssertEqual(window.titlebarContainerView?.frame.size.height, 22)
            XCTAssertEqual(window.isFullScreen, style.contains(.fullScreen))
            XCTAssertFalse(window.isTabWindow)
        }
    }

    static var allTests = [
        ("testWithoutTitlebarWithoutButtons", testWithoutTitlebarWithoutButtons),
        ("testWithTitlebarWithoutButtons", testWithTitlebarWithoutButtons),
        ("testWithTitlebarHeight0WithoutButtons", testWithTitlebarHeight0WithoutButtons),
        ("testWithTitlebarWithButtons", testWithTitlebarWithButtons),
    ]
}
