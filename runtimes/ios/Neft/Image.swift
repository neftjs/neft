import UIKit

class Image: Item {
    static var cache: [String: CGImage] = Dictionary()
    static var loadingHandlers: [String: [(_ result: CGImage?) -> Void]] = Dictionary()
//    static let svgToImageJs = Js(name: "svgToImage")

    override class func register(_ app: GameViewController) {
        app.client.actions[InAction.createImage] = {
            (reader: Reader) in
            Image(app)
        }
        app.client.actions[InAction.setImageSource] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setSource(reader.getString())
        }
        app.client.actions[InAction.setImageSourceWidth] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setSourceWidth(reader.getFloat())
        }
        app.client.actions[InAction.setImageSourceHeight] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setSourceHeight(reader.getFloat())
        }
        app.client.actions[InAction.setImageFillMode] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setFillMode(reader.getString())
        }
        app.client.actions[InAction.setImageOffsetX] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setOffsetX(reader.getFloat())
        }
        app.client.actions[InAction.setImageOffsetY] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Image)
                .setOffsetY(reader.getFloat())
        }

//        Image.svgToImageJs.runScript("svgToImage")
    }

    var modelImage: CGImage?
    var image: CGImage?

    override internal func updateBounds() {
        super.updateBounds()
        updateImage()
    }

    fileprivate func updateImage() {
        if modelImage == nil || width < 1 || height < 1 {
            image = nil
        } else {
            let imageWidth = Int(round(app.renderer.dpToPx(width)))
            let imageHeight = Int(round(app.renderer.dpToPx(height)))

            UIGraphicsBeginImageContext(CGSize(width: imageWidth, height: imageHeight))
            let context = UIGraphicsGetCurrentContext()
            context?.draw(modelImage!, in: CGRect(x: 0, y: 0, width: imageWidth, height: imageHeight))
            image = context?.makeImage()
            UIGraphicsEndImageContext()
        }
    }

    fileprivate func loadSvgData(_ svg: NSString, completion: (_ data: Data?) -> Void) {
        // TODO
        completion(nil)
//        let width = 0
//        let height = 0
//
//        let plainData = svg.dataUsingEncoding(NSUTF8StringEncoding)
//        let base64String = plainData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))

//        dispatch_async(dispatch_get_main_queue()) {
//            Image.svgToImageJs.callFunction("svgToImage", argv: "\"\(base64String)\", \(width), \(height)") {
//                (message: AnyObject) in
//                let dataUri = message as! String
//                if dataUri.isEmpty { return completion(data: nil) }
//                completion(data: self.loadDataUriSource(dataUri))
//            }
//        }
    }

    fileprivate func getTextureFromData(_ data: Data, source: String, completion: (_ texture: CGImage?) -> Void) {
        if source.hasSuffix(".svg") {
            let dataUri = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            if dataUri == nil { return completion(nil) }
            self.loadSvgData(dataUri!) {
                (data: Data?) in
                if data == nil { return completion(nil) }
                self.getTextureFromData(data!, source: "", completion: completion)
            }
        } else {
            let image = UIImage(data: data)
            if image == nil { return completion(nil) }
            completion(image!.cgImage)
        }
    }

    fileprivate func loadResourceSource(_ source: String) -> Data? {
        let path = Bundle.main.path(forResource: source, ofType: nil)
        if path == nil { return nil }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        return data
    }

    fileprivate func loadDataUriSource(_ source: String) -> Data? {
        let svgPrefix = "data:image/svg+xml;utf8,"
        if source.hasPrefix(svgPrefix) {
            return (try? Data(contentsOf: URL(fileURLWithPath: source.substring(from: source.characters.index(source.startIndex, offsetBy: svgPrefix.characters.count)))))
        }
        return self.loadUrlSource(source)
    }

    fileprivate func loadUrlSource(_ source: String) -> Data? {
        let url = URL(string: source)
        if url == nil { return nil }
        let data = try? Data(contentsOf: url!)
        return data
    }

    fileprivate func setTexture(_ tex: CGImage?) {
        self.modelImage = tex
        invalidate()
        updateImage()
    }

    func setSource(_ val: String) {
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
            (tex: CGImage?) in
            self.setTexture(tex)

            self.app.client.pushAction(OutAction.image_SIZE)
            self.app.renderer.pushObject(self)
            self.app.client.pushString(val)
            self.app.client.pushBoolean(tex != nil)
            
            self.app.client.pushFloat(tex != nil ? CGFloat(tex!.width) : 0)
            self.app.client.pushFloat(tex != nil ? CGFloat(tex!.height) : 0)
        }

        // wait for load if loading exist
        var loading = Image.loadingHandlers[val]
        if (loading != nil){
            loading!.append(onCompletion)
            return
        }

        // get loading method
        var loadFunc: (_ source: String) -> Data?
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
            (completion: (_ result: CGImage?) -> Void) -> Void in
            let data = loadFunc(val)
            if data == nil { return completion(nil) }
            self.getTextureFromData(data!, source: val) {
                (texture: CGImage?) in
                completion(texture)
            }
        }) {
            (tex: CGImage?) in
            if tex != nil && !val.hasPrefix("data:") {
                Image.cache[val] = tex
            }

            let loading = Image.loadingHandlers[val]
            for handler in loading! {
                handler(tex)
            }
            Image.loadingHandlers.removeValue(forKey: val)
        }
    }

    func setSourceWidth(_ val: CGFloat) {
        // TODO
    }

    func setSourceHeight(_ val: CGFloat) {
        // TODO
    }

    func setFillMode(_ val: String) {
        // TODO
    }

    func setOffsetX(_ val: CGFloat) {
        // TODO
    }

    func setOffsetY(_ val: CGFloat) {
        // TODO
    }

    override func drawShape(_ context: CGContext, inRect rect: CGRect) {
        context.draw(image!, in: bounds)
    }
}

