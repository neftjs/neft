import UIKit

extension Extension.Button {
    class ButtonItem: NativeItem {
        override class func main() {
            NativeItemBinding()
                .onCreate("Button") { ButtonItem() }
                .onSet("text") { (item, val: String) in item.setText(val) }
                .onSet("textColor") { (item, val: UIColor?) in item.setTextColor(val) }
                .finalize()
        }

        var buttonView = UIButton()

        init() {
            super.init(itemView: buttonView)
            setTextColor(UIColor.black)
        }

        func setText(_ val: String) {
            buttonView.setTitle(val, for: .normal)
            buttonView.sizeToFit()
            updateSize()
        }

        func setTextColor(_ val: UIColor?) {
            buttonView.setTitleColor(val, for: .normal)
        }
    }
}
