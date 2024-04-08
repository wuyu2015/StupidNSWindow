import Cocoa

class StupidNSWindowBarBackgroundView: NSView {
    override func mouseDown(with event: NSEvent) {
        if let window = event.window, event.clickCount == 1 {
            window.performDrag(with: event)
        }
    }
}
