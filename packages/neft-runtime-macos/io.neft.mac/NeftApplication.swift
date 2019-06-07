import Cocoa

@objc(NeftApplication)
class NeftApplication: NSApplication {
    var renderer: Renderer?

    override func sendEvent(_ event: NSEvent) {
        super.sendEvent(event)
        renderer?.device.onEvent(event)
    }

}
