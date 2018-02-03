import UIKit

extension Extension.Scrollable {
    class ScrollableItem: NativeItem {
        override class var name: String { return "Scrollable" }

        override class func register() {
            onCreate() {
                return ScrollableItem()
            }

            onSet("contentItem") {
                (item: ScrollableItem, val: Item?) in
                item.contentItem = val
            }

            onSet("contentX") {
                (item: ScrollableItem, val: CGFloat) in
                item.scrollView.contentOffset.x = val
            }

            onSet("contentY") {
                (item: ScrollableItem, val: CGFloat) in
                item.scrollView.contentOffset.y = val
            }
        }

        class Delegate: UIViewController, UIScrollViewDelegate {
            weak var scrollable: ScrollableItem?

            func scrollViewDidScroll(_ scrollView: UIScrollView) {
                guard scrollable != nil else { return }
                let offset = scrollView.contentOffset
                scrollable!.pushEvent(event: "contentXChange", args: [offset.x])
                scrollable!.pushEvent(event: "contentYChange", args: [offset.y])
            }
        }

        let delegate = Delegate()
        let scrollView = UIScrollView()

        var contentItem: Item? {
            didSet {
                if oldValue != nil {
                    oldValue!.view.removeFromSuperview()
                }
                if contentItem != nil {
                    contentItem!.view.removeFromSuperview()
                    scrollView.insertSubview(contentItem!.view, at: 0)
                }
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
            super.init(itemView: UIView())
            view.addSubview(scrollView)
            delegate.scrollable = self
        }

        override func onPointerPress(_ x: CGFloat, _ y: CGFloat) {
            super.onPointerPress(x, y)
            guard contentItem != nil else { return }
            scrollView.contentSize = contentItem!.view.layer.bounds.size
            scrollView.delegate = delegate
        }
    }
}
