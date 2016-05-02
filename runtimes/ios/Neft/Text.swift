import UIKit

class Text: Item {
    static var fonts: [String: String] = Dictionary()
    
    override class func register(app: GameViewController) {
        app.client.actions[InAction.CREATE_TEXT] = {
            (reader: Reader) in
            Text(app)
        }
        app.client.actions[InAction.SET_TEXT] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setText(reader.getString())
        }
        app.client.actions[InAction.SET_TEXT_WRAP] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setWrap(reader.getBoolean())
        }
        app.client.actions[InAction.UPDATE_TEXT_CONTENT_SIZE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .updateContentSize()
        }
        app.client.actions[InAction.SET_TEXT_COLOR] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setColor(reader.getInteger())
        }
        app.client.actions[InAction.SET_TEXT_LINE_HEIGHT] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setLineHeight(reader.getFloat())
        }
        app.client.actions[InAction.SET_TEXT_FONT_FAMILY] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setFontFamily(reader.getString())
        }
        app.client.actions[InAction.SET_TEXT_FONT_PIXEL_SIZE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setFontPixelSize(reader.getFloat())
        }
        app.client.actions[InAction.SET_TEXT_FONT_WORD_SPACING] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setFontWordSpacing(reader.getFloat())
        }
        app.client.actions[InAction.SET_TEXT_FONT_LETTER_SPACING] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setFontLetterSpacing(reader.getFloat())
        }
        app.client.actions[InAction.SET_TEXT_ALIGNMENT_HORIZONTAL] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setAlignmentHorizontal(reader.getString())
        }
        app.client.actions[InAction.SET_TEXT_ALIGNMENT_VERTICAL] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setAlignmentVertical(reader.getString())
        }
        app.client.actions[InAction.LOAD_FONT] = {
            (reader: Reader) in
            Text.loadFont(app, name: reader.getString(), source: reader.getString())
        }
    }
    
    static let textTransform = CGAffineTransformMakeScale(1.0, -1.0)
    static var fontAttrs: [String: NSObject] = [NSFontAttributeName: NSObject()]
    static let wordBreaks = NSCharacterSet(charactersInString: "- ")
    static let defaultColor = UIColor.blackColor().CGColor
    
    class Label {
        var width: CGFloat = 0
        var x: CGFloat = 0
        var y: CGFloat = 0
        var lineY: CGFloat = 0
        var text: NSString = ""
        var point = CGPoint()
        var line: CTLineRef?
    }
    
    enum Alignment {
        case Left, Center, Right, Top, Bottom
    }
    
    var labels: [Label] = []
    var labelsLength = 0
    var font: CTFontRef?
    var attrs: CFDictionary?
    var contentWidth: CGFloat = 0
    var contentHeight: CGFloat = 0
    var text: NSString = ""
    var wrap = false
    var color: CGColorRef = Text.defaultColor
    var lineHeight: CGFloat = 1
    var fontFamily = "Helvetica"
    var fontPixelSize: CGFloat = 14
    var alignmentHorizontal = Alignment.Left
    var alignmentVertical = Alignment.Top
    
    override init(_ app: GameViewController) {
        super.init(app)
        updateFont()
    }
    
    override func updateBounds() {
        super.updateBounds()
        updateAlignment()
    }
    
    private func updateFont() {
        font = CTFontCreateWithName(fontFamily, fontPixelSize, nil)
        attrs = [
            "\(kCTFontAttributeName)": CTFontCreateWithName(fontFamily, fontPixelSize, nil),
            "\(kCTForegroundColorFromContextAttributeName)": kCFBooleanTrue
        ]
    }
    
    private func getLabel(index: Int) -> Label {
        if self.labelsLength > index {
            return self.labels[index]
        } else {
            let label = Label()
            labels.append(label)
            return label
        }
    }
    
    func updateContent() {
        if (self.text.length == 0){
            self.contentWidth = 0
            self.contentHeight = 0
            self.labelsLength = 0
            return
        }

        Text.fontAttrs[NSFontAttributeName] = self.font
        let fontAscent = CTFontGetAscent(font!)
        let fontDescent = CTFontGetDescent(font!)

        let fontAttrs = Text.fontAttrs
        let wordBreaks = Text.wordBreaks
        var labelsLength = 0
        var width: CGFloat = 0
        let lineHeight = fontPixelSize * self.lineHeight
        let fontTop: CGFloat = (fontDescent - fontAscent) / 3 + lineHeight
        var height: CGFloat = 0
        let maxWidth: CGFloat? = self.wrap ? self.width : nil
        let text = self.text

        // by new lines
        var lineNextString = text
        while lineNextString.length > 0 {
            var lineText: NSString = ""
            let newLineIndex = lineNextString.rangeOfString("\n").location
            if newLineIndex != NSNotFound {
                lineText = lineNextString.substringToIndex(newLineIndex)
                lineNextString = lineNextString.substringFromIndex(newLineIndex + 1)
            } else {
                lineText = lineNextString
                lineNextString = ""
            }

            // by words
            var x: CGFloat = 0
            var wrapLineLength = 0
            var wordsNextString = lineText
            while wordsNextString.length > 0 {
                var wordText: NSString = ""
                let spaceIndex = wordsNextString.rangeOfCharacterFromSet(wordBreaks).location
                if spaceIndex != NSNotFound {
                    wordText = wordsNextString.substringToIndex(spaceIndex+1)
                    wordsNextString = wordsNextString.substringFromIndex(spaceIndex + 1)
                } else {
                    wordText = wordsNextString
                    wordsNextString = ""
                }

                // get size
                let wordWidth = wordText.sizeWithAttributes(fontAttrs).width
                let breakLine = wordsNextString != "" && maxWidth != nil && x + wordWidth > maxWidth

                if wordsNextString == "" || !breakLine {
                    x += wordWidth
                    wrapLineLength += wordText.length
                }

                if wordsNextString == "" || breakLine {
                    let label = self.getLabel(labelsLength)
                    label.lineY = height + fontTop
                    label.width = x
                    label.text = lineText.substringToIndex(wrapLineLength)
                    let attrString = CFAttributedStringCreate(nil, label.text, attrs)
                    label.line = CTLineCreateWithAttributedString(attrString)
                    
                    lineText = lineText.substringFromIndex(wrapLineLength)
                    labelsLength += 1
                    height += lineHeight

                    if breakLine {
                        x = wordWidth
                        wrapLineLength = wordText.length
                    }
                }

                if x > width {
                    width = x
                }
            }
        }

        self.labelsLength = labelsLength
        self.contentWidth = width
        self.contentHeight = height
        
        self.updateAlignment()
    }
    
    func updateAlignment() {
        // align labels
        var shiftY = self.height - self.contentHeight
        switch self.alignmentVertical {
        case .Center:
            shiftY /= 2
        case .Bottom:
            break
        default:
            shiftY = 0
        }
        for i in 0..<labelsLength {
            let label = self.labels[i]
            
            // horizontal
            let x = self.width - label.width
            switch self.alignmentHorizontal {
            case .Center:
                label.x = x / 2
            case .Right:
                label.x = x
            default:
                label.x = 0
            }
            
            // vertical
            label.y = label.lineY + shiftY
        }
        
        invalidate()
    }
    
    static func loadFont(app: GameViewController, name: String, source: String) {
        let postScriptName = Config.fonts[source]

        if postScriptName != nil {
            Text.fonts[name] = postScriptName
        }

        app.client.pushAction(OutAction.FONT_LOAD)
        app.client.pushString(name)
        app.client.pushBoolean(postScriptName != nil)
    }
    
    private func pushContentSize() {
        app.client.pushAction(OutAction.TEXT_SIZE)
        app.client.pushInteger(self.id)
        app.client.pushFloat(self.contentWidth)
        app.client.pushFloat(self.contentHeight)
    }
    
    func setText(val: String) {
        self.text = val
    }
    
    func setWrap(val: Bool) {
        self.wrap = val
    }
    
    func updateContentSize() {
        updateContent()
        pushContentSize()
        invalidate()
    }
    
    func setColor(val: Int) {
        let color = Color.hexColorToCGColor(val)
        self.color = color
        invalidate()
    }
    
    func setLineHeight(val: CGFloat) {
        self.lineHeight = val
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
        switch val {
        case "center":
            self.alignmentHorizontal = .Center
        case "right":
            self.alignmentHorizontal = .Right
        default:
            self.alignmentHorizontal = .Left
        }
        updateAlignment()
    }
    
    func setAlignmentVertical(val: String) {
        switch val {
        case "center":
            self.alignmentVertical = .Center
        case "bottom":
            self.alignmentVertical = .Bottom
        default:
            self.alignmentVertical = .Top
        }
        updateAlignment()
    }
    
    override func drawShape(context: CGContextRef, inRect rect: CGRect) {
        CGContextSetTextMatrix(context, Text.textTransform)
        CGContextSetFillColorWithColor(context, color)
        for i in 0..<self.labelsLength {
            let label = labels[i]
            CGContextSetTextPosition(context, label.x, label.y)
            CTLineDraw(label.line!, context)
        }
    }
}

