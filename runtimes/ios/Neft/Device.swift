import UIKit

class Device {
    fileprivate class DeviceView: UIView, UIKeyInput {
        var app: GameViewController!

        @objc var hasText : Bool {
            return true
        }

        @objc func insertText(_ text: String) {
            app.client.pushAction(OutAction.keyInput)
            app.client.pushString(text)
        }

        @objc func deleteBackward() {

        }

        override var canBecomeFirstResponder : Bool {
            return true
        }
    }

    var pixelRatio: CGFloat = 1
    var lastEvent: UIEvent!
    let app: GameViewController
    let onTouchEnded = Signal()
    fileprivate var view: DeviceView!

    class func register(_ app: GameViewController){
        app.client.actions[InAction.deviceLog] = {
            (reader: Reader) in
            app.renderer.device!.log(reader.getString())
        }
        app.client.actions[InAction.deviceShowKeyboard] = {
            (reader: Reader) in
            app.renderer.device!.showKeyboard()
        }
        app.client.actions[InAction.deviceHideKeyboard] = {
            (reader: Reader) in
            app.renderer.device!.hideKeyboard()
        }
    }

    init(_ app: GameViewController) {
        self.app = app

        self.view = DeviceView(frame: app.view.frame)
        view.app = app
        view.isHidden = true
        app.view.addSubview(view)

        // DEVICE_PIXEL_RATIO
        let pixelRatio = UIScreen.main.scale
        self.pixelRatio = pixelRatio
        app.client.pushAction(OutAction.devicePixelRatio)
        app.client.pushFloat(pixelRatio)

        // DEVICE_IS_PHONE
        let isPhone = UIDevice.current.userInterfaceIdiom == .phone
        app.client.pushAction(OutAction.deviceIsPhone)
        app.client.pushBoolean(isPhone)
    }

    func onEvent(_ event: UIEvent) {
        let touches = event.allTouches
        guard touches != nil else { return }

        let touch = touches!.first
        guard touch != nil else { return }

        self.lastEvent = event

        switch touch!.phase {
        case .began:
            app.client.pushAction(OutAction.pointerPress)
        case .moved:
            app.client.pushAction(OutAction.pointerMove)
        case .ended, .cancelled:
            onTouchEnded.emit()
            app.client.pushAction(OutAction.pointerRelease)
        default: break
        }

        let location = touch!.location(in: self.view)
        app.client.pushFloat(location.x)
        app.client.pushFloat(location.y)
        app.client.sendData()
    }

    func log(_ val: String) {
        NSLog(val)
    }

    func showKeyboard() {
        view.becomeFirstResponder()
        app.client.pushAction(OutAction.deviceKeyboardShow)
    }

    func hideKeyboard() {
        app.view.endEditing(true)
        app.client.pushAction(OutAction.deviceKeyboardHide)
    }
}
