import UIKit

class Image: Item {
    static var cache: [String: CGImageRef] = Dictionary()
    static var loadingHandlers: [String: [(result: CGImageRef?) -> Void]] = Dictionary()
//    static let svgToImageJs = Js(name: "svgToImage")
    
    override class func register(app: GameViewController) {
        app.client.actions[InAction.CREATE_IMAGE] = {
            (reader: Reader) in
            Image(app)
        }
        app.client.actions[InAction.SET_IMAGE_SOURCE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setSource(reader.getString())
        }
        app.client.actions[InAction.SET_IMAGE_SOURCE_WIDTH] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setSourceWidth(reader.getFloat())
        }
        app.client.actions[InAction.SET_IMAGE_SOURCE_HEIGHT] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setSourceHeight(reader.getFloat())
        }
        app.client.actions[InAction.SET_IMAGE_FILL_MODE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setFillMode(reader.getString())
        }
        app.client.actions[InAction.SET_IMAGE_OFFSET_X] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setOffsetX(reader.getFloat())
        }
        app.client.actions[InAction.SET_IMAGE_OFFSET_Y] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setOffsetY(reader.getFloat())
        }
        
//        Image.svgToImageJs.runScript("svgToImage")
    }
    
    var modelImage: CGImageRef?
    var image: CGImageRef?
    
    override internal func updateBounds() {
        super.updateBounds()
        updateImage()
    }
    
    private func updateImage() {
        if modelImage == nil || width < 1 || height < 1 {
            image = nil
        } else {
            let imageWidth = Int(round(app.renderer.dpToPx(width)))
            let imageHeight = Int(round(app.renderer.dpToPx(height)))
            
            UIGraphicsBeginImageContext(CGSize(width: imageWidth, height: imageHeight))
            let context = UIGraphicsGetCurrentContext()
            CGContextDrawImage(context, CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight), modelImage)
            image = CGBitmapContextCreateImage(context)
            UIGraphicsEndImageContext()
        }
    }
    
    private func loadSvgData(svg: NSString, completion: (data: NSData?) -> Void) {
        let width = 0
        let height = 0

        let plainData = svg.dataUsingEncoding(NSUTF8StringEncoding)
        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        
//        dispatch_async(dispatch_get_main_queue()) {
//            Image.svgToImageJs.callFunction("svgToImage", argv: "\"\(base64String)\", \(width), \(height)") {
//                (message: AnyObject) in
//                let dataUri = message as! String
//                if dataUri.isEmpty { return completion(data: nil) }
//                completion(data: self.loadDataUriSource(dataUri))
//            }
//        }
    }
    
    private func getTextureFromData(data: NSData, source: String, completion: (texture: CGImageRef?) -> Void) {
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
            completion(texture: image!.CGImage)
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
    
    private func setTexture(tex: CGImageRef?) {
        self.modelImage = tex
        invalidate()
        updateImage()
    }
    
    func setSource(val: String) {
        // remove texture if needed
        if val == "" {
            setTexture(nil)
            return
        }
        
        // get texture from cache
        let tex = Image.cache[val]
        if tex != nil {
            setTexture(tex)
            return
        }
        
        // completion handler
        let onCompletion = {
            (tex: CGImageRef?) in
            self.setTexture(tex)
            
            self.app.client.pushAction(OutAction.IMAGE_SIZE)
            self.app.renderer.pushObject(self)
            self.app.client.pushString(val)
            self.app.client.pushBoolean(tex != nil)
            self.app.client.pushFloat(tex != nil ? CGFloat(CGImageGetWidth(tex)) : 0)
            self.app.client.pushFloat(tex != nil ? CGFloat(CGImageGetHeight(tex)) : 0)
        }
        
        // wait for load if loading exist
        var loading = Image.loadingHandlers[val]
        if (loading != nil){
            loading!.append(onCompletion)
            return
        }
        
        // get loading method
        var loadFunc: (source: String) -> NSData?
        if (val.hasPrefix("/static")) {
            loadFunc = self.loadResourceSource
        } else if (val.hasPrefix("data:")) {
            loadFunc = self.loadDataUriSource
        } else {
            loadFunc = self.loadUrlSource
        }
        
        // save in loading
        Image.loadingHandlers[val] = [onCompletion]
        
        // load texture
        thread({
            (completion: (result: CGImageRef?) -> Void) in
            let data = loadFunc(source: val)
            if data == nil { return completion(result: nil) }
            self.getTextureFromData(data!, source: val) {
                (texture: CGImageRef?) in
                completion(result: texture)
            }
        }) {
            (tex: CGImageRef?) in
            if tex != nil && !val.hasPrefix("data:") {
                Image.cache[val] = tex
            }
            
            let loading = Image.loadingHandlers[val]
            for handler in loading! {
                handler(result: tex)
            }
            Image.loadingHandlers.removeValueForKey(val)
        }
    }
    
    func setSourceWidth(val: CGFloat) {
        // TODO
    }
    
    func setSourceHeight(val: CGFloat) {
        // TODO
    }
    
    func setFillMode(val: String) {
        // TODO
    }
    
    func setOffsetX(val: CGFloat) {
        // TODO
    }
    
    func setOffsetY(val: CGFloat) {
        // TODO
    }
    
    override func drawShape(context: CGContextRef, inRect rect: CGRect) {
        CGContextDrawImage(context, bounds, image)
    }
}

