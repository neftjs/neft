import UIKit

extension Extension.TextInput {
    class TextInputItem: NativeItem {
        override class var name: String { return "TextInput" }

        override class func register() {
            onCreate() {
                return TextInputItem()
            }

            onSet("text") {
                (item: TextInputItem, val: String) in
                item.fieldView.text = val
            }

            onSet("textColor") {
                (item: TextInputItem, val: UIColor?) in
                item.fieldView.textColor = val
            }
        }

        var fieldView: UITextField {
            return itemView as! UITextField
        }

        init() {
            super.init(itemView: UITextField())
            fieldView.addTarget(self, action: #selector(onTextChange(textField:)), for: UIControlEvents.editingChanged)
            fieldView.borderStyle = .roundedRect
            fieldView.frame.size.width = 250
            fieldView.frame.size.height = 30
            fieldView.frame = fieldView.frame
        }

        @objc
        private func onTextChange(textField: UITextField) {
            pushEvent(event: "textChange", args: [textField.text ?? ""])
        }
    }
}
