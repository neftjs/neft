import UIKit
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}


class Text: Item {
    static var fonts: [String: String] = Dictionary()
    
    override class func register(_ app: GameViewController) {
        app.client.actions[InAction.createText] = {
            (reader: Reader) in
            Text(app)
        }
        app.client.actions[InAction.setText] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setText(reader.getString())
        }
        app.client.actions[InAction.setTextWrap] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setWrap(reader.getBoolean())
        }
        app.client.actions[InAction.updateTextContentSize] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .updateContentSize()
        }
        app.client.actions[InAction.setTextColor] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setColor(reader.getInteger())
        }
        app.client.actions[InAction.setTextLineHeight] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setLineHeight(reader.getFloat())
        }
        app.client.actions[InAction.setTextFontFamily] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setFontFamily(reader.getString())
        }
        app.client.actions[InAction.setTextFontPixelSize] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setFontPixelSize(reader.getFloat())
        }
        app.client.actions[InAction.setTextFontWordSpacing] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setFontWordSpacing(reader.getFloat())
        }
        app.client.actions[InAction.setTextFontLetterSpacing] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setFontLetterSpacing(reader.getFloat())
        }
        app.client.actions[InAction.setTextAlignmentHorizontal] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setAlignmentHorizontal(reader.getString())
        }
        app.client.actions[InAction.setTextAlignmentVertical] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Text)
                .setAlignmentVertical(reader.getString())
        }
        app.client.actions[InAction.loadFont] = {
            (reader: Reader) in
            Text.loadFont(app, name: reader.getString(), source: reader.getString())
        }
    }
    
    static let textTransform = CGAffineTransform(scaleX: 1.0, y: -1.0)
    static var fontAttrs: [String: NSObject] = [NSFontAttributeName: NSObject()]
    static let wordBreaks = CharacterSet(charactersIn: "- ")
    static let defaultColor = UIColor.black.cgColor
    
    class Label {
        var width: CGFloat = 0
        var x: CGFloat = 0
        var y: CGFloat = 0
        var lineY: CGFloat = 0
        var text: NSString = ""
        var point = CGPoint()
        var line: CTLine?
    }
    
    enum Alignment {
        case left, center, right, top, bottom
    }
    
    var labels: [Label] = []
    var labelsLength = 0
    var font: CTFont?
    var attrs: CFDictionary?
    var contentWidth: CGFloat = 0
    var contentHeight: CGFloat = 0
    var text: NSString = ""
    var wrap = false
    var color: CGColor = Text.defaultColor
    var lineHeight: CGFloat = 1
    var fontFamily = "Helvetica"
    var fontPixelSize: CGFloat = 14
    var alignmentHorizontal = Alignment.left
    var alignmentVertical = Alignment.top
    
    override init(_ app: GameViewController) {
        super.init(app)
        updateFont()
    }
    
    override func updateBounds() {
        super.updateBounds()
        updateAlignment()
    }
    
    private func updateFont() {
        font = CTFontCreateWithName(fontFamily as CFString?, fontPixelSize, nil)
        attrs = [
            kCTFontAttributeName as String: font!,
            kCTForegroundColorFromContextAttributeName as String: kCFBooleanTrue
        ] as CFDictionary
    }
    
    private func getLabel(_ index: Int) -> Label {
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
            let newLineIndex = lineNextString.range(of: "\n").location
            if newLineIndex != NSNotFound {
                lineText = lineNextString.substring(to: newLineIndex) as NSString
                lineNextString = lineNextString.substring(from: newLineIndex + 1) as NSString
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
                let spaceIndex = wordsNextString.rangeOfCharacter(from: wordBreaks).location
                if spaceIndex != NSNotFound {
                    wordText = wordsNextString.substring(to: spaceIndex+1) as NSString
                    wordsNextString = wordsNextString.substring(from: spaceIndex + 1) as NSString
                } else {
                    wordText = wordsNextString
                    wordsNextString = ""
                }

                // get size
                let wordWidth = wordText.size(attributes: fontAttrs).width
                let breakLine = wordsNextString != "" && maxWidth != nil && x + wordWidth > maxWidth

                if wordsNextString == "" || !breakLine {
                    x += wordWidth
                    wrapLineLength += wordText.length
                }

                if wordsNextString == "" || breakLine {
                    let label = self.getLabel(labelsLength)
                    label.lineY = height + fontTop
                    label.width = x
                    label.text = lineText.substring(to: wrapLineLength) as NSString
                    let attrString = CFAttributedStringCreate(nil, label.text, attrs)
                    label.line = CTLineCreateWithAttributedString(attrString!)
                    
                    lineText = lineText.substring(from: wrapLineLength) as NSString
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
        case .center:
            shiftY /= 2
        case .bottom:
            break
        default:
            shiftY = 0
        }
        for i in 0..<labelsLength {
            let label = self.labels[i]
            
            // horizontal
            let x = self.width - label.width
            switch self.alignmentHorizontal {
            case .center:
                label.x = x / 2
            case .right:
                label.x = x
            default:
                label.x = 0
            }
            
            // vertical
            label.y = label.lineY + shiftY
        }
        
        invalidate()
    }
    
    static func loadFont(_ app: GameViewController, name: String, source: String) {
        let postScriptName = Config.fonts[source]

        if postScriptName != nil {
            Text.fonts[name] = postScriptName
        }

        app.client.pushAction(OutAction.font_LOAD)
        app.client.pushString(name)
        app.client.pushBoolean(postScriptName != nil)
    }
    
    fileprivate func pushContentSize() {
        app.client.pushAction(OutAction.text_SIZE)
        app.client.pushInteger(self.id)
        app.client.pushFloat(self.contentWidth)
        app.client.pushFloat(self.contentHeight)
    }
    
    func setText(_ val: String) {
        self.text = val as NSString
    }
    
    func setWrap(_ val: Bool) {
        self.wrap = val
    }
    
    func updateContentSize() {
        updateContent()
        pushContentSize()
        invalidate()
    }
    
    func setColor(_ val: Int) {
        let color = Color.hexColorToCGColor(val)
        self.color = color
        invalidate()
    }
    
    func setLineHeight(_ val: CGFloat) {
        self.lineHeight = val
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
        switch val {
        case "center":
            self.alignmentHorizontal = .center
        case "right":
            self.alignmentHorizontal = .right
        default:
            self.alignmentHorizontal = .left
        }
        updateAlignment()
    }
    
    func setAlignmentVertical(_ val: String) {
        switch val {
        case "center":
            self.alignmentVertical = .center
        case "bottom":
            self.alignmentVertical = .bottom
        default:
            self.alignmentVertical = .top
        }
        updateAlignment()
    }
    
    override func drawShape(_ context: CGContext, inRect rect: CGRect) {
        context.textMatrix = Text.textTransform
        context.setFillColor(color)
        for i in 0..<self.labelsLength {
            let label = labels[i]

            context.textPosition.x = label.x
            context.textPosition.y = label.y
            CTLineDraw(label.line!, context)
        }
    }
}

