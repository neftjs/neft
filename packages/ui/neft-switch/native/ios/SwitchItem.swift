import UIKit

extension Extension.Switch {
    class SwitchItem: NativeItem {
        override class func main() {
            NativeItemBinding()
                .onCreate("Switch") { SwitchItem() }
                .onSet("selected") { (item, val: Bool) in item.setSelected(val) }
                .onSet("borderColor") { (item, val: UIColor?) in item.setBorderColor(val) }
                .onSet("selectedColor") { (item, val: UIColor?) in item.setSelectedColor(val) }
                .onSet("thumbColor") { (item, val: UIColor?) in item.setThumbColor(val) }
                .onCall("setSelectedAnimated") {
                    (item, args: [Any?]) in
                    let val = args[0] as! Bool
                    item.setSelectedAnimated(val)
                }
                .finalize()
        }

        var switchView: UISwitch {
            return itemView as! UISwitch
        }

        required init() {
            super.init(itemView: UISwitch())

            switchView.addTarget(
                self,
                action: #selector(onValueChange(switchState:)),
                for: .valueChanged
            )
        }

        func setSelected(_ val: Bool) {
            switchView.isOn = val
        }

        func setBorderColor(_ val: UIColor?) {
            switchView.tintColor = val
        }

        func setSelectedColor(_ val: UIColor?) {
            switchView.onTintColor = val ?? App.getApp().view.tintColor
        }

        func setThumbColor(_ val: UIColor?) {
            switchView.thumbTintColor = val
        }

        func setSelectedAnimated(_ val: Bool) {
            switchView.setOn(val, animated: true)
        }

        @objc
        private func onValueChange(switchState: UISwitch) {
            pushEvent(event: "selectedChange", args: [switchState.isOn])
        }
    }
}
