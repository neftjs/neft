import Cocoa

extension Extension.Scrollable {
    class ScrollableItem: NativeItem {
        override class var name: String { return "Scrollable" }

        override class func register() {
            onCreate {
                return ScrollableItem()
            }

            onSet("contentItem") {
                (item: ScrollableItem, val: Item?) in
                item.contentItem = val
            }

            onSet("contentX") {
                (item: ScrollableItem, val: CGFloat) in
                item.contentX = val
            }

            onSet("contentY") {
                (item: ScrollableItem, val: CGFloat) in
                item.contentY = val
            }
        }

        class Delegate: NSViewController {
            weak var scrollable: ScrollableItem?

            func scrollViewDidScroll(_ scrollView: NSScrollView) {
                guard scrollable != nil else { return }
                let point = scrollView.documentVisibleRect.origin
                scrollable!.pushEvent(event: "contentXChange", args: [point.x])
                scrollable!.pushEvent(event: "contentYChange", args: [point.y])
            }

        }

        let delegate = Delegate()
        let scrollView = NSScrollView()

        var contentItem: Item? {
            didSet {
                if oldValue != nil {
                    oldValue!.view.removeFromSuperview()
                }
                if contentItem != nil {
                    scrollView.addSubview(contentItem!.view, positioned: .above, relativeTo: nil)
                }
            }
        }

        var contentX: CGFloat = 0 {
            didSet {
                updateScroll()
            }
        }

        var contentY: CGFloat = 0 {
            didSet {
                updateScroll()
            }
        }

        override var width: CGFloat {
            didSet {
                super.width = width
                scrollView.frame.size.width = width
                scrollView.frame = scrollView.frame
            }
        }

        override var height: CGFloat {
            didSet {
                super.height = height
                scrollView.frame.size.height = height
                scrollView.frame = scrollView.frame
            }
        }

        init() {
            super.init(itemView: NSView())
            view.addSubview(scrollView)
            //delegate.scrollable = self
        }

        func updateScroll() {
            scrollView.documentView?.scroll(NSPoint(x: contentX, y: contentY))
        }

        override func onPointerPress(_ x: CGFloat, _ y: CGFloat) {
            super.onPointerPress(x, y)
            guard contentItem != nil else { return }
//            scrollView.contentSize = contentItem!.view.layer.bounds.size
//            scrollView.delegate = delegate
        }

    }
}
