import UIKit

class Text: Item {
    static var fonts: [String: String] = Dictionary()
    static var defaultFont = "Helvetica"

    fileprivate class UITextView: UIView {
        override public class var layerClass: Swift.AnyClass {
            get {
                return CATextLayer.self
            }
        }
    }

    override class func register() {
        onAction(.createText) {
            save(item: Text())
        }

        onAction(.setText) {
            (item: Text, val: String) in
            item.textLayer.string = val
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
            (item: Text, val: CGColor) in
            item.textLayer.foregroundColor = val
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
                item.textLayer.alignmentMode = "center"
            case "right":
                item.textLayer.alignmentMode = "right"
            default:
                item.textLayer.alignmentMode = "left"
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

    var textLayer: CATextLayer {
        return view.layer as! CATextLayer
    }

    override init(view: UIView = UITextView()) {
        super.init(view: view)
        view.isOpaque = false
        textLayer.isWrapped = true
        textLayer.allowsFontSubpixelQuantization = true
        textLayer.contentsScale = UIScreen.main.scale
        updateFont()
    }

    private func updateFont() {
        textLayer.font = fontFamily as CFTypeRef
        textLayer.fontSize = fontPixelSize
    }

    static func loadFont(name: String, source: String) {
        let postScriptName = Config.fonts[source]

        if postScriptName != nil {
            Text.fonts[name] = postScriptName
        }

        App.getApp().client.pushAction(.fontLoad, name, postScriptName != nil)
    }

    private func pushContentSize() {
        let text = textLayer.string as? String
        var size: CGSize
        if text == nil || text!.isEmpty {
            size = CGSize(width: 0, height: 0)
        } else {
            var font = UIFont(name: fontFamily, size: fontPixelSize)
            if font == nil {
                font = UIFont(name: Text.defaultFont, size: fontPixelSize)
            }
            let attributes: [String : Any] = [
                NSFontAttributeName: font as Any
            ]
            if font == nil {
                size = CGSize(width: 0, height: 0)
            } else if wrap {
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
