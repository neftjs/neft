import UIKit

class TextInput: Item {

    override class func register() {
        onAction(.createTextInput) {
            save(item: TextInput())
        }

        onAction(.setTextInputText) {
            (item: TextInput, val: String) in ()
        }

        onAction(.setTextInputColor) {
            (item: TextInput, val: CGColor) in ()
        }

        onAction(.setTextInputLineHeight) {
            (item: TextInput, val: CGFloat) in ()
        }

        onAction(.setTextInputMultiLine) {
            (item: TextInput, val: Bool) in ()
        }

        onAction(.setTextInputEchoMode) {
            (item: TextInput, val: String) in ()
        }

        onAction(.setTextInputFontFamily) {
            (item: TextInput, val: String) in ()
        }

        onAction(.setTextFontInputPixelSize) {
            (item: TextInput, val: CGFloat) in ()
        }

        onAction(.setTextFontInputWordSpacing) {
            (item: TextInput, val: CGFloat) in ()
        }

        onAction(.setTextFontInputLetterSpacing) {
            (item: TextInput, val: CGFloat) in ()
        }

        onAction(.setTextInputAlignmentHorizontal) {
            (item: TextInput, val: String) in ()
        }

        onAction(.setTextInputAlignmentVertical) {
            (item: TextInput, val: String) in ()
        }
    }

    fileprivate let fieldView = UITextField()
    fileprivate let areaView = UITextView()

    var fontFamily = "Helvetica"
    var fontPixelSize: CGFloat = 14
    var multiLine = false
    var focus = false
    var text = ""
    var invalidateFrames = 0

    override init(view: UIView = UIView()) {
        super.init(view: view)
    }
}
