import UIKit

extension Extension.Input {
    class TextInputItem: NativeItem {
        override static func main() {
            NativeItemBinding()
                .onCreate("TextInput") { TextInputItem() }
                .onSet("text") { (item, val: String) in item.setText(val) }
                .onSet("textColor") { (item, val: UIColor?) in item.setTextColor(val) }
                .onSet("placeholder") { (item, val: String) in item.setPlaceholder(val) }
                .onSet("placeholderColor") { (item, val: UIColor?) in item.setPlaceholderColor(val) }
                .onSet("keyboardType") { (item, val: String) in item.setKeyboardType(val) }
                .onSet("multiline") { (item, val: Bool) in item.setMultiline(val) }
                .onSet("returnKeyType") { (item, val: String) in item.setReturnKeyType(val) }
                .onSet("secureTextEntry") { (item, val: Bool) in item.setSecureTextEntry(val) }
                .onCall("focus") { item in item.focus() }
                .finalize()
        }

        private static let keyboardTypes: [String: UIKeyboardType] = [
            "text": .default,
            "numeric": .decimalPad,
            "email": .emailAddress,
            "tel": .phonePad
        ]

        private static let returnKeyTypes: [String: UIReturnKeyType] = [
            "done": UIReturnKeyType.done,
            "go": UIReturnKeyType.go,
            "next": UIReturnKeyType.next,
            "search": UIReturnKeyType.search,
            "send": UIReturnKeyType.send
        ]

        private var fieldView = UITextField()

        private var placeholder: String = "" {
            didSet {
                updatePlaceholder()
            }
        }

        private var placeholderColor: UIColor? {
            didSet {
                updatePlaceholder()
            }
        }

        init() {
            super.init(itemView: fieldView)
            fieldView.addTarget(self, action: #selector(onTextChange(textField:)), for: UIControl.Event.editingChanged)
            fieldView.addTarget(self, action: #selector(onExit(textField:)), for: UIControl.Event.editingDidEndOnExit)
            fieldView.borderStyle = .none
            fieldView.frame.size.width = 250
            fieldView.frame.size.height = 30
            fieldView.frame = fieldView.frame
            setTextColor(UIColor.black)

            NotificationCenter.default.addObserver(self, selector: #selector(didBeginEditing(_:)), name: UITextField.textDidBeginEditingNotification, object: fieldView)

            NotificationCenter.default.addObserver(self, selector: #selector(didEndEditing(_:)), name: UITextField.textDidEndEditingNotification, object: fieldView)
        }

        func setText(_ val: String) {
            fieldView.text = val
        }

        func setTextColor(_ val: UIColor?) {
            fieldView.textColor = val
        }

        func setPlaceholder(_ val: String) {
            placeholder = val
        }

        func setPlaceholderColor(_ val: UIColor?) {
            placeholderColor = val
        }

        func setKeyboardType(_ val: String) {
            fieldView.keyboardType = TextInputItem.keyboardTypes[val] ?? UIKeyboardType.default
        }

        func setMultiline(_ val: Bool) {
            // TODO
        }

        func setReturnKeyType(_ val: String) {
            fieldView.returnKeyType = TextInputItem.returnKeyTypes[val] ?? UIReturnKeyType.default
        }

        func setSecureTextEntry(_ val: Bool) {
            fieldView.isSecureTextEntry = val
        }

        func focus() {
            fieldView.becomeFirstResponder()
        }

        private func updatePlaceholder() {
            if placeholderColor == nil {
                fieldView.placeholder = placeholder
            } else {
                let attrs = NSAttributedString(string: placeholder,
                                               attributes: [NSAttributedString.Key.foregroundColor: placeholderColor!])
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
