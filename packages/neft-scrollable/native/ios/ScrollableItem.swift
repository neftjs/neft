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

            onCall("animatedScrollTo") {
                (item: ScrollableItem, args: [Any?]) in
                let x = (args[0] as! Number).float()
                let y = (args[1] as! Number).float()
                item.animatedScrollTo(x, y)
            }
        }

        class NeftUIScrollView: UIScrollView, UIScrollViewDelegate {
            weak var scrollable: ScrollableItem?

            override func didMoveToWindow() {
                super.didMoveToWindow()
                delegate = self
            }

            override func layoutSubviews() {
                super.layoutSubviews()

                guard scrollable?.contentItem != nil else { return }
                scrollable!.scrollView.contentSize = scrollable!.contentItem!.view.layer.bounds.size
            }

            internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
                guard scrollable != nil else { return }
                let offset = scrollView.contentOffset
                scrollable!.pushEvent(event: "contentXChange", args: [offset.x])
                scrollable!.pushEvent(event: "contentYChange", args: [offset.y])
            }
        }

        let scrollView = NeftUIScrollView()

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
            scrollView.scrollable = self
            view.addSubview(scrollView)
        }

        func animatedScrollTo(_ x: CGFloat, _ y: CGFloat) {
            scrollView.setContentOffset(CGPoint(x: x, y: y), animated: true)
        }
    }
}
