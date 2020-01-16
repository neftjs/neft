import UIKit

fileprivate let app = App.getApp()
fileprivate let binding = NativeBinding("ScreenBrightness")

fileprivate class BrightnessHandler {
    var timer: Timer?
    let screen = UIScreen.main

    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleBrightnessDidChange(notfication:)), name: UIScreen.brightnessDidChangeNotification, object: nil)
    }

    @objc func handleBrightnessDidChange(notfication: NSNotification) {
        pushBrightness()
    }

    func pushBrightness() {
        binding.pushEvent("brightness", args: [screen.brightness])
    }

    func setBrightness(_ val: CGFloat) {
        screen.brightness = val
    }
}

extension Extension.ScreenBrightness {
    fileprivate static let handler = BrightnessHandler()

    static func register() {
        binding
            .onCall("getBrightness") { (args: [Any?]) in
                handler.pushBrightness()
            }
            .onCall("setBrightness") { (args: [Any?]) in
                handler.setBrightness((args[0] as! Number).float())
            }
            .finalize()
    }
}
