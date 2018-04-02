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
    var keyboardVisible = false {
        didSet {
            let app = App.getApp()
            if (keyboardVisible) {
                app.client.pushAction(OutAction.deviceKeyboardShow)
            } else {
                app.client.pushAction(OutAction.deviceKeyboardHide)
            }
        }
    }
    var keyboardHeight: CGFloat = 0 {
        didSet {
            let app = App.getApp()
            app.client.pushAction(OutAction.deviceKeyboardHeight, keyboardHeight)
        }
    }
    let onTouchEnded = Signal()
    fileprivate var view: DeviceView!

    class func register(){
        App.getApp().client.onAction(.deviceLog) {
            (reader: Reader) in
            App.getApp().renderer.device!.log(reader.getString())
        }

        App.getApp().client.onAction(.deviceShowKeyboard) {
            App.getApp().renderer.device!.showKeyboard()
        }

        App.getApp().client.onAction(.deviceHideKeyboard) {
            App.getApp().renderer.device!.hideKeyboard()
        }
    }

    init() {
        let app: GameViewController = App.getApp()
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

        // notifications
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    func onEvent(_ event: UIEvent) {
        let app: GameViewController = App.getApp()

        let touches = event.allTouches
        guard touches != nil else { return }

        let touch = touches!.first
        guard touch != nil else { return }

        let location = touch!.location(in: view)
        if keyboardVisible && location.y >= view.frame.height - keyboardHeight { return }

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

        app.client.pushFloat(location.x)
        app.client.pushFloat(location.y)
        app.client.sendData()
    }

    func log(_ val: String) {
        NSLog(val)
    }

    func showKeyboard() {
        view.becomeFirstResponder()
    }

    func hideKeyboard() {
        let app = App.getApp()
        app.view.endEditing(true)
    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            if let size = userInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect {
                keyboardHeight = size.height
            }
        }
        keyboardVisible = true
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        keyboardVisible = false
    }
}
