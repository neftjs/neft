import UIKit
import AVKit
import AVFoundation

extension Extension.TileImage {
    class TileImageItem: NativeItem {
        override class func main() {
            NativeItemBinding()
                .onCreate("TileImage") { TileImageItem() }
                .onSet("source") { (item, val: String) in item.setSource(val) }
                .onSet("resolution") { (item, val: CGFloat) in item.setResolution(val) }
                .finalize()
        }

        var source: String?
        var resolution: CGFloat = 1

        required init() {
            super.init(itemView: UIView())
        }

        func setSource(_ val: String) {
            self.source = val
            Image.getImageFromSource(val) { (img: UIImage?) in
                guard self.source == val else { return }
                if img == nil {
                    self.itemView.backgroundColor = nil
                    return
                }
                let scaledImg = UIImage(
                    cgImage: img!.cgImage!,
                    scale: self.resolution,
                    orientation: UIImage.Orientation.up
                )
                self.itemView.backgroundColor = UIColor(patternImage: scaledImg)
            }
        }

        func setResolution(_ val: CGFloat) {
            resolution = val
        }
    }
}
