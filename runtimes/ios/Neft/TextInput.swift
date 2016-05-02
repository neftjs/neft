import UIKit

class TextInput: Item {

    override class func register(app: GameViewController) {
        app.client.actions[InAction.CREATE_TEXT_INPUT] = {
            (reader: Reader) in
            TextInput(app)
        }
        app.client.actions[InAction.SET_TEXT_INPUT_TEXT] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setText(reader.getString())
        }
        app.client.actions[InAction.SET_TEXT_INPUT_COLOR] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setColor(reader.getInteger())
        }
        app.client.actions[InAction.SET_TEXT_INPUT_LINE_HEIGHT] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setLineHeight(reader.getFloat())
        }
        app.client.actions[InAction.SET_TEXT_INPUT_MULTI_LINE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setMultiLine(reader.getBoolean())
        }
        app.client.actions[InAction.SET_TEXT_INPUT_ECHO_MODE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setEchoMode(reader.getString())
        }
        app.client.actions[InAction.SET_TEXT_INPUT_FONT_FAMILY] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setFontFamily(reader.getString())
        }
        app.client.actions[InAction.SET_TEXT_FONT_INPUT_PIXEL_SIZE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setFontPixelSize(reader.getFloat())
        }
        app.client.actions[InAction.SET_TEXT_FONT_INPUT_WORD_SPACING] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setFontWordSpacing(reader.getFloat())
        }
        app.client.actions[InAction.SET_TEXT_FONT_INPUT_LETTER_SPACING] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setFontLetterSpacing(reader.getFloat())
        }
        app.client.actions[InAction.SET_TEXT_INPUT_ALIGNMENT_HORIZONTAL] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setAlignmentHorizontal(reader.getString())
        }
        app.client.actions[InAction.SET_TEXT_INPUT_ALIGNMENT_VERTICAL] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! TextInput)
                .setAlignmentVertical(reader.getString())
        }
    }

    private let fieldView = UITextField()
    private let areaView = UITextView()
    private var view: UIView

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
        areaView.hidden = true
        fieldView.userInteractionEnabled = false
        areaView.userInteractionEnabled = false
    }

    private func detectTextChange() {
        var text = ""
        if multiLine {
            text = areaView.text
        } else if fieldView.text != nil {
            text = fieldView.text!
        }
        if (self.text != text){
            self.text = text
            app.client.pushAction(OutAction.TEXT_INPUT_TEXT)
            app.renderer.pushObject(self)
            app.client.pushString(text)
        }
    }

    private func reloadView() {
        let oldView = view
        if multiLine {
            view = areaView
        } else {
            view = fieldView
        }
        guard oldView != view else { return }

        // visibility
        view.hidden = false
        oldView.hidden = true

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
            oldView.userInteractionEnabled = false
            oldView.resignFirstResponder()
            view.userInteractionEnabled = true
            view.becomeFirstResponder()
        }
    }

    private func updateFont() {
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

    func setText(val: String) {
        self.text = val
        if multiLine {
            areaView.text = val
        } else {
            fieldView.text = val
        }
        invalidate()
    }

    func setColor(val: Int) {
        let color = Color.hexColorToUIColor(val)
        if multiLine {
            areaView.textColor = color
        } else {
            fieldView.textColor = color
        }
        invalidate()
    }

    func setLineHeight(val: CGFloat) {
        // TODO
    }

    func setMultiLine(val: Bool) {
        multiLine = val
        reloadView()
        invalidate()
    }

    // TODO: 'password' echo mode is not supported in multiline textinput
    func setEchoMode(val: String) {
        switch val {
        case "password":
            fieldView.secureTextEntry = true
        default:
            fieldView.secureTextEntry = false
        }
    }

    func setFontFamily(val: String) {
        let fontName = Text.fonts[val]
        if fontName != nil {
            self.fontFamily = fontName!
            updateFont()
            invalidate()
        }
    }

    func setFontPixelSize(val: CGFloat) {
        self.fontPixelSize = val
        updateFont()
        invalidate()
    }

    func setFontWordSpacing(val: CGFloat) {
        // TODO
    }

    func setFontLetterSpacing(val: CGFloat) {
        // TODO
    }

    func setAlignmentHorizontal(val: String) {
        var alignment: NSTextAlignment?
        switch val {
        case "center":
            alignment = .Center
        case "right":
            alignment = .Right
        default:
            alignment = .Left
        }

        if multiLine {
            areaView.textAlignment = alignment!
        } else {
            fieldView.textAlignment = alignment!
        }
    }

    func setAlignmentVertical(val: String) {
        // TODO
        switch val {
        case "center": break
        case "bottom": break
        default: break
        }
    }

    override func setKeysFocus(val: Bool) {
        super.setKeysFocus(val)
        focus = val

        view.userInteractionEnabled = val
        if val {
            view.becomeFirstResponder()
        } else {
            view.resignFirstResponder()
        }

        invalidate()
        detectTextChange()
        invalidateFrames = 10
    }

    override func measure(globalTransform: CGAffineTransform, _ viewRect: CGRect, inout _ dirtyRects: [CGRect], forceUpdateBounds: Bool) {
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

    override func drawShape(context: CGContextRef, inRect rect: CGRect) {
        view.drawViewHierarchyInRect(bounds, afterScreenUpdates: false)
    }

}
