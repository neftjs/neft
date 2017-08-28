import Cocoa

extension Extension.TileImage {
    class TileImageItem: NativeItem {
        override class var name: String { return "TileImage" }

        override class func register() {
            onCreate {
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

        init() {
            super.init(itemView: NSView())
        }

        func setSource(val: String) {
            self.source = val
            Image.getImageFromSource(val) {
                (img: NSImage?) in
                if self.source != val {
                    return
                }
                var imgRect = CGRect(x: 0, y: 0, width: img!.size.width, height: img!.size.height)
                let scaledImg = NSImage(
                    cgImage: img!.cgImage(forProposedRect: &imgRect, context: nil, hints: nil)!,
                    size: NSSize(
                        width: imgRect.width / self.resolution,
                        height: imgRect.height / self.resolution
                    )
                )
                self.layer.backgroundColor = NSColor(patternImage: scaledImg).cgColor
            }
        }

    }
}
