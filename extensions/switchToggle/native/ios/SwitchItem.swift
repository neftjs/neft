import UIKit

extension Extension.SwitchToggle {
    class SwitchItem: NativeItem {
        override class var name: String { return "Switch" }

        override class func register() {
            onCreate() {
                return SwitchItem()
            }

            onSet("selected") {
                (item: SwitchItem, val: Bool) in
                item.switchView.isOn = val
            }

            onSet("borderColor") {
                (item: SwitchItem, val: UIColor?) in
                item.switchView.tintColor = val
            }

            onSet("selectedColor") {
                (item: SwitchItem, val: UIColor?) in
                item.switchView.onTintColor = val ?? App.getApp().view.tintColor
            }

            onSet("thumbColor") {
                (item: SwitchItem, val: UIColor?) in
                item.switchView.thumbTintColor = val
            }

            onCall("setSelectedAnimated") {
                (item: SwitchItem, args: [Any?]) in
                let val = args[0] as! Bool
                item.switchView.setOn(val, animated: true)
            }
        }

        var switchView: UISwitch {
            return view as! UISwitch
        }

        override init(view: UIView = UISwitch()) {
            super.init(view: view)

            switchView.addTarget(
                self,
                action: #selector(onValueChange(switchState:)),
                for: .valueChanged
            )
        }

        @objc
        private func onValueChange(switchState: UISwitch) {
            pushEvent(event: "selectedChange", args: [switchState.isOn])
        }
    }
}
