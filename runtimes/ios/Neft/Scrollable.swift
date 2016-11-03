import UIKit

class Scrollable: Item {
    override class func register(){
        onAction(.createScrollable) {
            save(item: Scrollable())
        }

        onAction(.setScrollableContentItem) {
            (item: Scrollable, val: Item?) in
            item.contentItem = val
        }

        onAction(.setScrollableContentX) {
            (item: Scrollable, val: CGFloat) in
            item.scrollView.contentOffset.x = val
        }

        onAction(.setScrollableContentY) {
            (item: Scrollable, val: CGFloat) in
            item.scrollView.contentOffset.y = val
        }

        onAction(.activateScrollable) {
            (item: Scrollable) in
            guard item.contentItem != nil else { return }
            item.scrollView.contentSize = item.contentItem!.view.layer.bounds.size
            item.scrollView.delegate = item.delegate
        }
    }

    class Delegate: UIViewController, UIScrollViewDelegate {
        weak var scrollable: Scrollable?

        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard scrollable != nil else { return }
            let offset = scrollView.contentOffset
            scrollable!.pushAction(.scrollableContentX, offset.x)
            scrollable!.pushAction(.scrollableContentY, offset.y)
        }
    }

    let delegate = Delegate()
    var scrollView: UIScrollView {
        return view as! UIScrollView
    }

    var contentItem: Item? {
        didSet {
            if oldValue != nil {
                oldValue!.view.removeFromSuperview()
            }
            if contentItem != nil {
                let index = background == nil ? 0 : 1
                view.insertSubview(contentItem!.view, at: index)
            }
        }
    }

    override init(view: UIView = UIScrollView()) {
        super.init(view: view)
        delegate.scrollable = self
    }
}
