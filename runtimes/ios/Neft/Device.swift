import UIKit

class Device {
    private class DeviceView: UIView, UIKeyInput {
        var app: GameViewController!

        @objc func hasText() -> Bool {
            return true
        }

        @objc func insertText(text: String) {
            app.client.pushAction(OutAction.KEY_INPUT)
            app.client.pushString(text)
        }

        @objc func deleteBackward() {

        }

        override func canBecomeFirstResponder() -> Bool {
            return true
        }
    }

    var pixelRatio: CGFloat = 1
    var lastEvent: UIEvent!
    let app: GameViewController
    let onTouchEnded = Signal()
    private var view: DeviceView!

    class func register(app: GameViewController){
        app.client.actions[InAction.DEVICE_LOG] = {
            (reader: Reader) in
            app.renderer.device!.log(reader.getString())
        }
        app.client.actions[InAction.DEVICE_SHOW_KEYBOARD] = {
            (reader: Reader) in
            app.renderer.device!.showKeyboard()
        }
        app.client.actions[InAction.DEVICE_HIDE_KEYBOARD] = {
            (reader: Reader) in
            app.renderer.device!.hideKeyboard()
        }
    }

    init(_ app: GameViewController) {
        self.app = app

        self.view = DeviceView(frame: app.view.frame)
        view.app = app
        view.hidden = true
        app.view.addSubview(view)

        // DEVICE_PIXEL_RATIO
        let pixelRatio = UIScreen.mainScreen().scale
        self.pixelRatio = pixelRatio
        app.client.pushAction(OutAction.DEVICE_PIXEL_RATIO)
        app.client.pushFloat(pixelRatio)

        // DEVICE_IS_PHONE
        let isPhone = UIDevice.currentDevice().userInterfaceIdiom == .Phone
        app.client.pushAction(OutAction.DEVICE_IS_PHONE)
        app.client.pushBoolean(isPhone)
    }

    func onEvent(event: UIEvent) {
        let touches = event.allTouches()
        guard touches != nil else { return }

        let touch = touches!.first
        guard touch != nil else { return }

        self.lastEvent = event

        switch touch!.phase {
        case .Began:
            app.client.pushAction(OutAction.POINTER_PRESS)
        case .Moved:
            app.client.pushAction(OutAction.POINTER_MOVE)
        case .Ended, .Cancelled:
            onTouchEnded.emit()
            app.client.pushAction(OutAction.POINTER_RELEASE)
        default: break
        }

        let location = touch!.locationInView(self.view)
        app.client.pushFloat(location.x)
        app.client.pushFloat(location.y)
        app.client.sendData()
    }

    func log(val: String) {
        NSLog(val)
    }

    func showKeyboard() {
        view.becomeFirstResponder()
        app.client.pushAction(OutAction.DEVICE_KEYBOARD_SHOW)
    }

    func hideKeyboard() {
        app.view.endEditing(true)
        app.client.pushAction(OutAction.DEVICE_KEYBOARD_HIDE)
    }
}
