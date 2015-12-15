import SpriteKit

extension Renderer {
    class Text: Renderer.BaseType {
        class Node: Item.Node {
            static var fontAttrs: [String: NSObject] = [NSFontAttributeName: NSObject()]
            static let wordBreaks = NSCharacterSet(charactersInString: "- ")
            
            class Label: SKLabelNode {
                var width: CGFloat = 0
                var y: CGFloat = 0
            }
            
            let content = SKNode()
            var labels: [Node.Label] = []
            var labelsLength = 0
            var font: UIFont = UIFont(name: "Helvetica", size: 14)!
            var contentWidth: CGFloat = 0
            var contentHeight: CGFloat = 0
            var text: NSString = ""
            var wrap = false
            var color: UIColor = UIColor.blackColor()
            var lineHeight: CGFloat = 1
            var fontFamily = "Helvetica"
            var fontPixelSize: CGFloat = 14
            var alignmentHorizontal = "left"
            var alignmentVertical = "top"
            
            override init(_ renderer: Renderer) {
                super.init(renderer)
                self.childrenNode.addChild(self.content)
            }

            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
            
            private func getLabel(index: Int) -> Label {
                var label: Label? = nil
                if self.labelsLength > index {
                    label = self.labels[index]
                } else {
                    label = Label()
                    labels.append(label!)
                    label!.horizontalAlignmentMode = .Left
                    label!.verticalAlignmentMode = .Top
                }
                return label!
            }
            
            private func updateLabelFont(label: Label) {
                label.fontColor = color
                label.fontName = fontFamily
                label.fontSize = fontPixelSize
            }
            
            func updateContent() {
                if (self.text.length == 0){
                    self.contentWidth = 0
                    self.contentHeight = 0
                    self.labelsLength = 0
                    self.content.removeAllChildren()
                    return
                }
                
                Node.fontAttrs[NSFontAttributeName] = self.font
                
                let fontAttrs = Node.fontAttrs
                let wordBreaks = Node.wordBreaks
                var labelsLength = 0
                var width: CGFloat = 0
                let lineHeight = fontPixelSize * self.lineHeight
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
                            wordText = wordsNextString.substringToIndex(spaceIndex)
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
                            label.y = height - lineHeight
                            label.width = x
                            label.text = lineText.substringToIndex(wrapLineLength)
                            lineText = lineText.substringFromIndex(wrapLineLength)
                            if label.parent == nil {
                                self.content.addChild(label)
                            }
                            self.updateLabelFont(label)
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
                        
                        wrapLineLength += 1
                    }
                }
                
                // align labels
                var shiftY = self.height - height
                switch self.alignmentVertical {
                case "center":
                    shiftY /= 2
                case "bottom":
                    break
                default:
                    shiftY = 0
                }
                for i in 0..<labelsLength {
                    let label = self.labels[i]
                    
                    // horizontal
                    let x = self.width - label.width
                    switch self.alignmentHorizontal {
                    case "center":
                        label.position.x = x / 2
                    case "right":
                        label.position.x = x
                    default:
                        label.position.x = 0
                    }
                    
                    // vertical
                    label.position.y = -label.y - shiftY
                }
                
                // remove unused labels
                if self.labelsLength > labelsLength {
                    for i in labelsLength..<self.labelsLength {
                        let label = self.labels[i]
                        label.removeFromParent()
                    }
                }
                
                self.labelsLength = labelsLength
                self.contentWidth = width
                self.contentHeight = height
            }
        }
        
        override init(app: GameViewController) {
            super.init(app: app)
            Renderer.actions[InActions.CREATE_TEXT] = self.create
            Renderer.actions[InActions.SET_TEXT] = self.setText
            Renderer.actions[InActions.SET_TEXT_WRAP] = self.setWrap
            Renderer.actions[InActions.UPDATE_TEXT_CONTENT_SIZE] = self.updateContentSize
            Renderer.actions[InActions.SET_TEXT_COLOR] = self.setColor
            Renderer.actions[InActions.SET_TEXT_LINE_HEIGHT] = self.setLineHeight
            Renderer.actions[InActions.SET_TEXT_FONT_FAMILY] = self.setFontFamily
            Renderer.actions[InActions.SET_TEXT_FONT_PIXEL_SIZE] = self.setFontPixelSize
            Renderer.actions[InActions.SET_TEXT_FONT_WORD_SPACING] = self.setFontWordSpacing
            Renderer.actions[InActions.SET_TEXT_FONT_LETTER_SPACING] = self.setFontLetterSpacing
            Renderer.actions[InActions.SET_TEXT_ALIGNMENT_HORIZONTAL] = self.setAlignmentHorizontal
            Renderer.actions[InActions.SET_TEXT_ALIGNMENT_VERTICAL] = self.setAlignmentVertical
            Renderer.actions[InActions.LOAD_FONT] = self.loadFont
        }
        
        private func pushContentSize(item: Node) {
            renderer.pushAction(OutActions.TEXT_SIZE)
            renderer.pushInteger(item.id)
            renderer.pushFloat(item.contentWidth)
            renderer.pushFloat(item.contentHeight)
        }
        
        func create(reader: Reader) {
            Node(renderer)
        }
        
        func setText(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getString()
            item.text = val
            item.updateContent()
            pushContentSize(item)
        }
        
        func setWrap(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getBoolean()
            item.wrap = val
            item.updateContent()
            pushContentSize(item)
        }
        
        func updateContentSize(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            item.updateContent()
            pushContentSize(item)
        }
        
        func setColor(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getInteger()
            let color = hexColorToUIColor(val)
            item.color = color
            
            for i in 0..<item.labelsLength {
                let label = item.labels[i]
                label.fontColor = color
            }
        }
        
        func setLineHeight(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            item.lineHeight = val
            item.updateContent()
            pushContentSize(item)
        }
        
        func setFontFamily(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getString()
//            item.fontFamily = val
//            item.font = UIFont(name: val, size: item.fontPixelSize)!
            item.updateContent()
            pushContentSize(item)
        }
        
        func setFontPixelSize(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            item.fontPixelSize = val
            item.font = UIFont(name: item.fontFamily, size: val)!
            item.updateContent()
            pushContentSize(item)
        }
        
        func setFontWordSpacing(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            // TODO
        }
        
        func setFontLetterSpacing(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
            // TODO
        }
        
        func setAlignmentHorizontal(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getString()
            item.alignmentHorizontal = val
            item.updateContent()
        }
        
        func setAlignmentVertical(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getString()
            item.alignmentVertical = val
            item.updateContent()
        }
        
        func loadFont(reader: Reader) {
            let name = reader.getString()
            let source = reader.getString()
            // TODO
        }
    }
}
