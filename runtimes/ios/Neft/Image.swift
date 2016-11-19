import UIKit

class Image: Item {
    static var cache: [String: UIImage] = Dictionary()
    static var loadingHandlers: [String: [(_ result: UIImage?) -> Void]] = Dictionary()
    // static let svgToImageJs = Js(name: "svgToImage")

    override class func register() {
        onAction(.createImage) {
            save(item: Image())
        }

        onAction(.setImageSource) {
            (item: Image, val: String) in
            item.setSource(val)
        }

        // Image.svgToImageJs.runScript("svgToImage")
    }

    // var modelImage: CGImage?
    // var image: CGImage?
    private var image: UIImage? {
        didSet {
            imageView.image = image
        }
    }

    var imageView: UIImageView {
        return view as! UIImageView
    }

    override init(view: UIView = UIImageView()) {
        super.init(view: view)
    }

    private func loadSvgData(_ svg: NSString, completion: (_ data: Data?) -> Void) {
        // TODO
        completion(nil)
    }

    private func getImageFromData(_ data: Data, source: String, completion: (_ img: UIImage?) -> Void) {
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

    private func loadResourceSource(_ source: String) -> Data? {
        let path = Bundle.main.path(forResource: source, ofType: nil)
        if path == nil { return nil }
        let data = try? Data(contentsOf: URL(fileURLWithPath: path!))
        return data
    }

    private func loadDataUriSource(_ source: String) -> Data? {
        let svgPrefix = "data:image/svg+xml;utf8,"
        if source.hasPrefix(svgPrefix) {
            return (try? Data(contentsOf: URL(fileURLWithPath: source.substring(from: source.characters.index(source.startIndex, offsetBy: svgPrefix.characters.count)))))
        }
        return self.loadUrlSource(source)
    }

    private func loadUrlSource(_ source: String) -> Data? {
        let url = URL(string: source)
        if url == nil { return nil }
        let data = try? Data(contentsOf: url!)
        return data
    }

    private func setSource(_ val: String) {
        // remove image
        if val == "" {
            image = nil
            return
        }

        // get image from cache
        let img = Image.cache[val]
        if img != nil {
            image = img
            return
        }

        // completion handler
        let onCompletion = {
            (img: UIImage?) in
            self.image = img

            let width = img == nil ? 0 : CGFloat(img!.size.width)
            let height = img == nil ? 0 : CGFloat(img!.size.height)
            self.pushAction(.imageSize, val, img != nil, width, height)
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
                Image.cache[val] = img
            }

            let loading = Image.loadingHandlers[val]
            for handler in loading! {
                handler(img)
            }
            Image.loadingHandlers.removeValue(forKey: val)
        }
    }
}

