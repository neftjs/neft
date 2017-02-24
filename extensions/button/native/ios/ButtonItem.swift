import UIKit

extension Extension.Button {
    class ButtonItem: NativeItem {
        override class var name: String { return "Button" }

        override class func register() {
            onCreate() {
                return ButtonItem()
            }

            onSet("text") {
                (item: ButtonItem, val: String) in
                item.buttonView.setTitle(val, for: .normal)
                item.buttonView.sizeToFit()
                item.updateSize()
            }

            onSet("textColor") {
                (item: ButtonItem, val: UIColor?) in
               item.buttonView.setTitleColor(val, for: .normal)
            }
        }

        var buttonView: UIButton {
            return itemView as! UIButton
        }

        init() {
            super.init(itemView: UIButton())
            buttonView.setTitleColor(UIColor.black, for: .normal)
        }
    }
}
