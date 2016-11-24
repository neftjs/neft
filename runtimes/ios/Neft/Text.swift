import UIKit

class Text: Item {
    static var fonts: [String: String] = Dictionary()
    static var defaultFont = "Helvetica"

    override class func register() {
        onAction(.createText) {
            save(item: Text())
        }

        onAction(.setText) {
            (item: Text, val: String) in
            item.labelView.text = val
        }

        onAction(.setTextWrap) {
            (item: Text, val: Bool) in
            item.wrap = val
        }

        onAction(.updateTextContentSize) {
            (item: Text) in
            item.pushContentSize()
        }

        onAction(.setTextColor) {
            (item: Text, val: UIColor) in
            item.labelView.textColor = val
        }

        onAction(.setTextLineHeight) {
            (item: Text, val: CGFloat) in
            item.lineHeight = val
        }

        onAction(.setTextFontFamily) {
            (item: Text, val: String) in
            item.fontFamily = fonts[val] ?? defaultFont
        }

        onAction(.setTextFontPixelSize) {
            (item: Text, val: CGFloat) in
            item.fontPixelSize = val
        }

        onAction(.setTextFontWordSpacing) {
            (item: Text, val: CGFloat) in ()
        }

        onAction(.setTextFontLetterSpacing) {
            (item: Text, val: CGFloat) in ()
        }

        onAction(.setTextAlignmentHorizontal) {
            (item: Text, val: String) in
            switch val {
            case "center":
                item.labelView.textAlignment = .center
            case "right":
                item.labelView.textAlignment = .right
            default:
                item.labelView.textAlignment = .left
            }
        }

        onAction(.setTextAlignmentVertical) {
            (item: Text, val: String) in ()
        }

        onAction(.loadFont) {
            (reader: Reader) in
            Text.loadFont(name: reader.getString(), source: reader.getString())
        }
    }

    var wrap = false;

    var lineHeight: CGFloat = 1 {
        didSet {
            updateFont()
        }
    }

    var fontFamily = defaultFont {
        didSet {
            updateFont()
        }
    }

    var fontPixelSize: CGFloat = 14 {
        didSet {
            updateFont()
        }
    }

    var labelView: UILabel {
        return view as! UILabel
    }

    override init(view: UIView = UILabel()) {
        super.init(view: view)
        labelView.lineBreakMode = .byWordWrapping
        labelView.numberOfLines = 0
        updateFont()
    }

    private func updateFont() {
        labelView.font = UIFont(name: fontFamily, size: fontPixelSize)
    }

    static func loadFont(name: String, source: String) {
        let postScriptName = Config.fonts[source]

        if postScriptName != nil {
            Text.fonts[name] = postScriptName
        }

        App.getApp().client.pushAction(.fontLoad, name, postScriptName != nil)
    }

    private func pushContentSize() {
        let text = labelView.text
        var size: CGSize
        if text == nil || text!.isEmpty {
            size = CGSize(width: 0, height: 0)
        } else {
            let attributes: [String : Any] = [
                NSFontAttributeName: labelView.font,
                "lineBreakMode": labelView.lineBreakMode
            ]
            if wrap {
                size = (text! as NSString).boundingRect(
                    with: CGSize(width: width, height: CGFloat.greatestFiniteMagnitude),
                    options: NSStringDrawingOptions.usesLineFragmentOrigin,
                    attributes: attributes,
                    context: nil
                ).size
            } else {
                size = (text! as NSString).size(attributes: attributes)
            }
        }
        pushAction(.textSize, size.width, size.height)
    }
}
