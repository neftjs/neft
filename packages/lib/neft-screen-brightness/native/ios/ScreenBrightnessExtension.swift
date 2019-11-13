import UIKit

fileprivate class NoificationsHandler : NSObject {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "brightness" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                Extension.ScreenBrightness.pushBrightness()
            }
        }
    }
}

fileprivate let app = App.getApp()
fileprivate let binding = NativeBinding("ScreenBrightness")
fileprivate let notificationsHandler = NoificationsHandler()

extension Extension.ScreenBrightness {
    static func register() {
        binding
            .onCall("getBrightness") { (args: [Any?]) in
                pushBrightness()
            }
            .onCall("setBrightness") { (args: [Any?]) in
                setBrightness((args[0] as! Number).float())
            }
            .finalize()

        UIScreen.main.addObserver(notificationsHandler, forKeyPath: "brightness", options: .new, context: nil)
    }

    fileprivate static func pushBrightness() {
        binding.pushEvent("brightness", args: [UIScreen.main.brightness])
    }

    private static func setBrightness(_ val: CGFloat) {
        UIScreen.main.brightness = val
    }
}
