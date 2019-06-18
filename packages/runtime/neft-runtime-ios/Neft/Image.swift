import UIKit

class Image: Item {
    static var cache: NSMapTable<NSString, UIImage> = NSMapTable()
    static var loadingHandlers: [String: [(_ result: UIImage?) -> Void]] = Dictionary()

    override class func register() {
        onAction(.createImage) {
            save(item: Image())
        }

        onAction(.setImageSource) {
            (item: Image, val: String) in
            item.setSource(val)
        }
    }

    private var image: UIImage? {
        didSet {
            view.layer.contents = image?.cgImage
        }
    }

    var source: String?

    static private func loadSvgData(_ svg: NSString, completion: (_ data: Data?) -> Void) {
        // TODO
        completion(nil)
    }

    static private func getImageFromData(_ data: Data, source: String, completion: (_ img: UIImage?) -> Void) {
        if source.hasSuffix(".svg") {
            let dataUri = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
            guard dataUri != nil else { return completion(nil) }
            self.loadSvgData(dataUri!) {
                (data: Data?) in
                guard data != nil else { return completion(nil) }
                self.getImageFromData(data!, source: "", completion: completion)
            }
        } else {
            let image = UIImage(data: data)
            completion(image)
        }
    }

    static private func loadResourceSource(_ source: String) -> Data? {
        let path = Bundle.main.path(forResource: source, ofType: nil)
        if path == nil { return nil }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        return data
    }

    static private func loadDataUriSource(_ source: String) -> Data? {
        let svgPrefix = "data:image/svg+xml;utf8,"
        if source.hasPrefix(svgPrefix) {
            let sourceWithoutPrefix = String(source.dropFirst(svgPrefix.count))
            return (try? Data(contentsOf: URL(fileURLWithPath: sourceWithoutPrefix)))
        }
        return self.loadUrlSource(source)
    }

    static private func loadUrlSource(_ source: String) -> Data? {
        let url = URL(string: source)
        if url == nil { return nil }
        let data = try? Data(contentsOf: url!)
        return data
    }

    static func getImageFromSource(_ val: String, _ onCompletion: @escaping (UIImage?) -> Void) {
        // remove image
        if val == "" {
            onCompletion(nil)
            return
        }

        // get image from cache
        let img = Image.cache.object(forKey: val as NSString)
        if img != nil {
            onCompletion(img)
            return
        }

        // wait for load if loading exist
        var loading = Image.loadingHandlers[val]
        if loading != nil {
            loading!.append(onCompletion)
            Image.loadingHandlers[val] = loading!
            return
        }

        // get loading method
        var loadFunc: (_ source: String) -> Data?
        if val.hasPrefix("/static") {
            loadFunc = self.loadResourceSource
        } else if val.hasPrefix("data:") {
            loadFunc = self.loadDataUriSource
        } else {
            loadFunc = self.loadUrlSource
        }

        // save in loading
        Image.loadingHandlers[val] = [onCompletion]

        // load image
        thread({
            (completion: (_ result: UIImage?) -> Void) -> Void in
            let data = loadFunc(val)
            if data == nil {
                return completion(nil)
            }
            self.getImageFromData(data!, source: val, completion: completion)
        }) {
            (img: UIImage?) in
            if img != nil && !val.hasPrefix("data:") {
                Image.cache.setObject(img, forKey: val as NSString)
            }

            let loading = Image.loadingHandlers[val]
            Image.loadingHandlers.removeValue(forKey: val)
            for handler in loading! {
                handler(img)
            }
        }
    }

    private func setSource(_ val: String) {
        self.source = val

        if val.isEmpty {
            self.image = nil
            self.pushAction(.imageSize, val, true, CGFloat(0), CGFloat(0))
            return
        }

        Image.getImageFromSource(val) {
            (img: UIImage?) in
            if self.source != val {
                return
            }

            self.image = img

            let width = img == nil ? 0 : CGFloat(img!.size.width)
            let height = img == nil ? 0 : CGFloat(img!.size.height)
            self.pushAction(.imageSize, val, img != nil, width, height)
        }
    }
}
