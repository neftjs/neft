import UIKit
import AVKit
import AVFoundation

extension Extension.TileImage {
    class TileImageItem: NativeItem {
        override class var name: String { return "TileImage" }

        override class func register() {
            onCreate() {
                return TileImageItem()
            }

            onSet("source") {
                (item: TileImageItem, val: String) in
                item.setSource(val: val)
            }

            onSet("resolution") {
                (item: TileImageItem, val: CGFloat) in
                item.resolution = val
            }
        }

        var source: String?
        var resolution: CGFloat = 1

        override init(view: UIView = UIView()) {
            super.init(view: view)
        }

        func setSource(val: String) {
            self.source = val
            Image.getImageFromSource(val) {
                (img: UIImage?) in
                if self.source != val {
                    return
                }
                let scaledImg = UIImage(
                    cgImage: img!.cgImage!,
                    scale: self.resolution,
                    orientation: UIImageOrientation.up
                )
                self.view.backgroundColor = UIColor(patternImage: scaledImg)
            }
        }
    }
}
