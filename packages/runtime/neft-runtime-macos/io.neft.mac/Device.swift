import Cocoa

class Device {
    var pixelRatio: CGFloat = 1

    class func register() {
        App.getApp().client.onAction(.deviceLog) {
            (reader: Reader) in
            App.getApp().renderer.device!.log(reader.getString())
        }

        App.getApp().client.onAction(.deviceShowKeyboard) {}
        App.getApp().client.onAction(.deviceHideKeyboard) {}
    }

    init() {
        let app: ViewController = App.getApp()

        // DEVICE_PIXEL_RATIO
        let pixelRatio = NSScreen.main()!.backingScaleFactor
        self.pixelRatio = pixelRatio
        app.client.pushAction(OutAction.devicePixelRatio, pixelRatio)

        // DEVICE_IS_PHONE
        app.client.pushAction(OutAction.deviceIsPhone, false)
    }

    func onEvent(_ event: NSEvent) {
        let app: ViewController = App.getApp()
        var action: OutAction!

        switch event.type {
        case .leftMouseDown, .rightMouseDown, .otherMouseDown:
            action = OutAction.pointerPress
        case .mouseMoved, .leftMouseDragged, .rightMouseDragged, .otherMouseDragged:
            action = OutAction.pointerMove
        case .leftMouseUp, .rightMouseUp, .otherMouseUp:
            action = OutAction.pointerRelease
        default:
            return
        }

        let point = app.view.convert(event.locationInWindow, from: nil)
        app.client.pushAction(action, point.x, point.y)
    }

    func log(_ val: String) {
        NSLog(val)
    }

}
