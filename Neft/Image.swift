import SpriteKit

extension Renderer {
    class Image: Renderer.BaseType {
        class Node: Item.Node {
            let spriteNode = SKSpriteNode()
            override var width: CGFloat {
                didSet {
                    self.spriteNode.size.width = self.width
                }
            }
            override var height: CGFloat {
                didSet {
                    self.spriteNode.size.height = self.height
                }
            }
            
            override init(_ renderer: Renderer) {
                super.init(renderer)
                self.spriteNode.anchorPoint.x = 0
                self.spriteNode.anchorPoint.y = 1
                self.childrenNode.addChild(self.spriteNode)
            }

            required init?(coder aDecoder: NSCoder) {
                fatalError("init(coder:) has not been implemented")
            }
        }
        
        static var cache: [String: SKTexture] = Dictionary()
        
        let svgToImageJs = Js(name: "svgToImage")
        
        override init(app: GameViewController) {
            super.init(app: app)
            
            Renderer.actions[InActions.CREATE_IMAGE] = self.create
            Renderer.actions[InActions.SET_IMAGE_SOURCE] = self.setSource
            Renderer.actions[InActions.SET_IMAGE_SOURCE_WIDTH] = self.setSourceWidth
            Renderer.actions[InActions.SET_IMAGE_SOURCE_HEIGHT] = self.setSourceHeight
            Renderer.actions[InActions.SET_IMAGE_FILL_MODE] = self.setFillMode
            Renderer.actions[InActions.SET_IMAGE_OFFSET_X] = self.setOffsetX
            Renderer.actions[InActions.SET_IMAGE_OFFSET_Y] = self.setOffsetY
            
            svgToImageJs.runScript("svgToImage")
        }
        
        func create(reader: Reader) {
            Node(renderer)
        }
        
        private func loadSvgData(svg: NSString, completion: (data: NSData?) -> Void) {
            let width = 0
            let height = 0

            let plainData = svg.dataUsingEncoding(NSUTF8StringEncoding)
            let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
            
            svgToImageJs.callFunction("svgToImage", argv: "\"\(base64String)\", \(width), \(height)") {
                (message: AnyObject) in
                let dataUri = message as! String
                if dataUri.isEmpty { return completion(data: nil) }
                completion(data: self.loadDataUriSource(dataUri))
            }
        }
        
        private func getTextureFromData(data: NSData, source: String, completion: (texture: SKTexture?) -> Void) {
            if source.hasSuffix(".svg") {
                let dataUri = NSString(data: data, encoding: NSUTF8StringEncoding)
                if dataUri == nil { return completion(texture: nil) }
                self.loadSvgData(dataUri!) {
                    (data: NSData?) in
                    if data == nil { return completion(texture: nil) }
                    self.getTextureFromData(data!, source: "", completion: completion)
                }
            } else {
                let image = UIImage(data: data)
                if image == nil { return completion(texture: nil) }
                completion(texture: SKTexture(image: image!))
            }
        }
        
        private func loadResourceSource(source: String) -> NSData? {
            let path = NSBundle.mainBundle().pathForResource(source, ofType: nil)
            if path == nil { return nil }
            let data = NSData(contentsOfFile: path!)
            return data
        }
        
        private func loadDataUriSource(source: String) -> NSData? {
            let svgPrefix = "data:image/svg+xml;utf8,"
            if source.hasPrefix(svgPrefix) {
                return NSData(contentsOfFile: source.substringFromIndex(source.startIndex.advancedBy(svgPrefix.characters.count)))
            }
            return self.loadUrlSource(source)
        }
        
        private func loadUrlSource(source: String) -> NSData? {
            let url = NSURL(string: source)
            if url == nil { return nil }
            let data = NSData(contentsOfURL: url!)
            return data
        }
        
        private func loadTexture(item: Node, _ texture: SKTexture) {
            item.spriteNode.texture = texture
        }
        
        func setSource(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getString()
            
            if val == "" {
                item.spriteNode.texture = nil
                return
            }
            
            var tex = Image.cache[val]
            if tex != nil {
                loadTexture(item, tex!)
                return
            }
            
            var loadFunc: (source: String) -> NSData?
            if (val.hasPrefix("/static")) {
                loadFunc = self.loadResourceSource
            } else if (val.hasPrefix("data:")) {
                loadFunc = self.loadDataUriSource
            } else {
                loadFunc = self.loadUrlSource
            }
            
            thread({
                (completion: (result: SKTexture?) -> Void) in
                let data = loadFunc(source: val)
                if data == nil { return completion(result: nil) }
                self.getTextureFromData(data!, source: val) {
                    (texture: SKTexture?) in
                    completion(result: texture)
                }
            }) {
                (tex: SKTexture?) in
                if tex != nil && !val.hasPrefix("data:") {
                    Image.cache[val] = tex
                    self.loadTexture(item, tex!)
                }

                self.renderer.pushAction(OutActions.IMAGE_SIZE)
                self.renderer.pushInteger(item.id)
                self.renderer.pushString(val)
                self.renderer.pushBoolean(tex != nil)
                self.renderer.pushFloat(tex != nil ? tex!.size().width : 0)
                self.renderer.pushFloat(tex != nil ? tex!.size().height : 0)
            }
        }
        
        func setSourceWidth(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
        }
        
        func setSourceHeight(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
        }
        
        func setFillMode(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getString()
        }
        
        func setOffsetX(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
        }
        
        func setOffsetY(reader: Reader) {
            let item = renderer.getItem(reader) as! Node
            let val = reader.getFloat()
        }
    }
}
