import UIKit

class TextInput: Item {

    override class func register(_ app: GameViewController) {
        app.client.actions[InAction.createTextInput] = {
            (reader: Reader) in
            TextInput(app)
        }
        app.client.actions[InAction.setTextInputText] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setText(reader.getString())
        }
        app.client.actions[InAction.setTextInputColor] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setColor(reader.getInteger())
        }
        app.client.actions[InAction.setTextInputLineHeight] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setLineHeight(reader.getFloat())
        }
        app.client.actions[InAction.setTextInputMultiLine] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setMultiLine(reader.getBoolean())
        }
        app.client.actions[InAction.setTextInputEchoMode] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setEchoMode(reader.getString())
        }
        app.client.actions[InAction.setTextInputFontFamily] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setFontFamily(reader.getString())
        }
        app.client.actions[InAction.setTextFontInputPixelSize] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setFontPixelSize(reader.getFloat())
        }
        app.client.actions[InAction.setTextFontInputWordSpacing] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setFontWordSpacing(reader.getFloat())
        }
        app.client.actions[InAction.setTextFontInputLetterSpacing] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setFontLetterSpacing(reader.getFloat())
        }
        app.client.actions[InAction.setTextInputAlignmentHorizontal] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setAlignmentHorizontal(reader.getString())
        }
        app.client.actions[InAction.setTextInputAlignmentVertical] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setAlignmentVertical(reader.getString())
        }
    }

    fileprivate let fieldView = UITextField()
    fileprivate let areaView = UITextView()
    fileprivate var view: UIView

    var fontFamily = "Helvetica"
    var fontPixelSize: CGFloat = 14
    var multiLine = false
    var focus = false
    var text = ""
    var invalidateFrames = 0

    override init(_ app: GameViewController) {
        view = fieldView

        super.init(app)

        // default size
        setWidth(100)
        setHeight(50)

        // set default font
        updateFont()

        // views container
        let container = UIView()
        container.frame = app.renderer.screen.rect
        container.addSubview(fieldView)
        container.addSubview(areaView)
        container.alpha = 0
        app.window.addSubview(container)
        areaView.isHidden = true
        fieldView.isUserInteractionEnabled = false
        areaView.isUserInteractionEnabled = false
    }

    fileprivate func detectTextChange() {
        var text = ""
        if multiLine {
            text = areaView.text
        } else if fieldView.text != nil {
            text = fieldView.text!
        }
        if (self.text != text){
            self.text = text
            app.client.pushAction(OutAction.textInputText)
            app.renderer.pushObject(self)
            app.client.pushString(text)
        }
    }

    fileprivate func reloadView() {
        let oldView = view
        if multiLine {
            view = areaView
        } else {
            view = fieldView
        }
        guard oldView != view else { return }

        // visibility
        view.isHidden = false
        oldView.isHidden = true

        // font
        if multiLine {
            areaView.font = fieldView.font
        } else {
            fieldView.font = areaView.font
        }

        // bounds
        view.frame.size = bounds.size

        // position
        view.frame.origin = globalBounds.origin

        // text
        if multiLine {
            areaView.text = fieldView.text
        } else {
            fieldView.text = areaView.text
        }

        // color
        if multiLine {
            areaView.textColor = fieldView.textColor
        } else {
            fieldView.textColor = areaView.textColor
        }

        // horizontal alignment
        if multiLine {
            areaView.textAlignment = fieldView.textAlignment
        } else {
            fieldView.textAlignment = areaView.textAlignment
        }

        // focus
        if focus {
            oldView.isUserInteractionEnabled = false
            oldView.resignFirstResponder()
            view.isUserInteractionEnabled = true
            view.becomeFirstResponder()
        }
    }

    fileprivate func updateFont() {
        let font = UIFont(name: fontFamily, size: fontPixelSize)
        if multiLine {
            areaView.font = font
        } else {
            fieldView.font = font
        }
    }

    override func updateBounds() {
        super.updateBounds()
        view.frame.size = bounds.size
    }

    func setText(_ val: String) {
        self.text = val
        if multiLine {
            areaView.text = val
        } else {
            fieldView.text = val
        }
        invalidate()
    }

    func setColor(_ val: Int) {
        let color = Color.hexColorToUIColor(val)
        if multiLine {
            areaView.textColor = color
        } else {
            fieldView.textColor = color
        }
        invalidate()
    }

    func setLineHeight(_ val: CGFloat) {
        // TODO
    }

    func setMultiLine(_ val: Bool) {
        multiLine = val
        reloadView()
        invalidate()
    }

    // TODO: 'password' echo mode is not supported in multiline textinput
    func setEchoMode(_ val: String) {
        switch val {
        case "password":
            fieldView.isSecureTextEntry = true
        default:
            fieldView.isSecureTextEntry = false
        }
    }

    func setFontFamily(_ val: String) {
        let fontName = Text.fonts[val]
        if fontName != nil {
            self.fontFamily = fontName!
            updateFont()
            invalidate()
        }
    }

    func setFontPixelSize(_ val: CGFloat) {
        self.fontPixelSize = val
        updateFont()
        invalidate()
    }

    func setFontWordSpacing(_ val: CGFloat) {
        // TODO
    }

    func setFontLetterSpacing(_ val: CGFloat) {
        // TODO
    }

    func setAlignmentHorizontal(_ val: String) {
        var alignment: NSTextAlignment?
        switch val {
        case "center":
            alignment = .center
        case "right":
            alignment = .right
        default:
            alignment = .left
        }

        if multiLine {
            areaView.textAlignment = alignment!
        } else {
            fieldView.textAlignment = alignment!
        }
    }

    func setAlignmentVertical(_ val: String) {
        // TODO
        switch val {
        case "center": break
        case "bottom": break
        default: break
        }
    }

    override func setKeysFocus(_ val: Bool) {
        super.setKeysFocus(val)
        focus = val

        view.isUserInteractionEnabled = val
        if val {
            view.becomeFirstResponder()
        } else {
            view.resignFirstResponder()
        }

        invalidate()
        detectTextChange()
        invalidateFrames = 10
    }

    override func measure(_ globalTransform: CGAffineTransform, _ viewRect: CGRect, _ dirtyRects: inout [CGRect], forceUpdateBounds: Bool) {
        let dirtyPosition = forceUpdateBounds || dirtyTransform

        super.measure(globalTransform, viewRect, &dirtyRects, forceUpdateBounds: forceUpdateBounds)

        if dirtyPosition {
            view.frame.origin = globalBounds.origin
        }
        if focus || invalidateFrames > 0 {
            if invalidateFrames > 0 {
                invalidateFrames -= 1
            }
            detectTextChange()
            invalidate()
        }
    }

    override func drawShape(_ context: CGContext, inRect rect: CGRect) {
        view.drawHierarchy(in: bounds, afterScreenUpdates: false)
    }

}
