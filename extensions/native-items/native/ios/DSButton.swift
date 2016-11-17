import UIKit

extension Extension.DefaultStyles {
    class ButtonItem: NativeItem {
        override class var name: String { return "DSButtonItem" }

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
            return view as! UIButton
        }

        override init(view: UIView = UIButton()) {
            super.init(view: view)
            buttonView.setTitleColor(UIColor.black, for: .normal)
        }
    }
}
