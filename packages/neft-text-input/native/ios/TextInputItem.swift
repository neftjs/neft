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

            onSet("placeholder") {
                (item: TextInputItem, val: String) in
                item.placeholder = val
            }

            onSet("placeholderColor") {
                (item: TextInputItem, val: UIColor?) in
                item.placeholderColor = val
            }

            onSet("keyboardType") {
                (item: TextInputItem, val: String) in
                item.fieldView.keyboardType = keyboardTypes[val] ?? UIKeyboardType.default
            }

            onSet("multiline") {
                (item: TextInputItem, val: Bool) in
                // TODO
            }

            onSet("returnKeyType") {
                (item: TextInputItem, val: String) in
                item.fieldView.returnKeyType = returnKeyTypes[val] ?? UIReturnKeyType.default
            }

            onSet("secureTextEntry") {
                (item: TextInputItem, val: Bool) in
                item.fieldView.isSecureTextEntry = val
            }

            onCall("focus") {
                (item: TextInputItem, args: [Any?]) in
                item.fieldView.becomeFirstResponder()
            }
        }

        static let keyboardTypes: [String: UIKeyboardType] = [
            "text": .default,
            "numeric": .decimalPad,
            "email": .emailAddress,
            "tel": .phonePad
        ]

        static let returnKeyTypes: [String: UIReturnKeyType] = [
            "done": UIReturnKeyType.done,
            "go": UIReturnKeyType.go,
            "next": UIReturnKeyType.next,
            "search": UIReturnKeyType.search,
            "send": UIReturnKeyType.send
        ]

        var fieldView: UITextField {
            return itemView as! UITextField
        }

        var placeholder: String = "" {
            didSet {
                updatePlaceholder()
            }
        }

        var placeholderColor: UIColor? {
            didSet {
                updatePlaceholder()
            }
        }

        init() {
            super.init(itemView: UITextField())
            fieldView.addTarget(self, action: #selector(onTextChange(textField:)), for: UIControlEvents.editingChanged)
            fieldView.addTarget(self, action: #selector(onExit(textField:)), for: UIControlEvents.editingDidEndOnExit)
            fieldView.borderStyle = .none
            fieldView.frame.size.width = 250
            fieldView.frame.size.height = 30
            fieldView.frame = fieldView.frame

            NotificationCenter.default.addObserver(self, selector: #selector(didBeginEditing(_:)), name: Notification.Name.UITextFieldTextDidBeginEditing, object: fieldView)

            NotificationCenter.default.addObserver(self, selector: #selector(didEndEditing(_:)), name: Notification.Name.UITextFieldTextDidEndEditing, object: fieldView)
        }

        private func updatePlaceholder() {
            if placeholderColor == nil {
                fieldView.placeholder = placeholder
            } else {
                let attrs = NSAttributedString(string: placeholder,
                                               attributes: [NSForegroundColorAttributeName: placeholderColor!])
                fieldView.attributedPlaceholder = attrs
            }
        }

        @objc
        private func onTextChange(textField: UITextField) {
            pushEvent(event: "textChange", args: [textField.text ?? ""])
        }

        @objc
        private func onExit(textField: UITextField) {
            App.app.client.pushAction(OutAction.keyRelease, "Enter")
        }

        @objc
        private func didBeginEditing(_ notification: Notification) {
            focused = true
        }

        @objc
        private func didEndEditing(_ notification: Notification) {
            focused = false
        }
    }
}
