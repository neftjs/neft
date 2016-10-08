import UIKit

class Scrollable: Item {
    override class func register(_ app: GameViewController){
        app.client.actions[InAction.createScrollable] = {
            (reader: Reader) in
            Scrollable(app)
        }
        app.client.actions[InAction.setScrollableContentItem] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Scrollable)
                .setContentItem(app.renderer.getObjectFromReader(reader) as? Item)
        }
        app.client.actions[InAction.setScrollableContentX] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Scrollable)
                .setContentX(reader.getFloat(), sendEvent: false)
        }
        app.client.actions[InAction.setScrollableContentY] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Scrollable)
                .setContentY(reader.getFloat(), sendEvent: false)
        }
        app.client.actions[InAction.activateScrollable] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Scrollable)
                .activate()
        }

        // create main uiscrollview
        app.window.addSubview(mainView)
        mainView.defaultBounds = app.renderer.screen.rect
        mainView.showsHorizontalScrollIndicator = false
        mainView.showsVerticalScrollIndicator = false
        mainView.setScrollableItem(nil)
    }

    fileprivate class MainView: UIScrollView, UIScrollViewDelegate {
        let defaultFrame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let defaultContentSize = CGSize(width: 9999, height: 9999)
        var defaultBounds = CGRect()
        var scrollableItem: Scrollable?

        override func didMoveToSuperview() {
            super.didMoveToSuperview()
            self.delegate = self
        }

        func setScrollableItem(_ item: Scrollable?) {
            self.scrollableItem = item
            frame = item != nil ? item!.bounds : defaultFrame
            bounds = defaultBounds
            frame.origin.x = 0
            frame.origin.y = 0
            contentSize = item?.contentItem != nil ? item!.contentItem!.bounds.size : defaultContentSize
            contentOffset.x = item != nil ? item!.contentX : defaultContentSize.width / 2
            contentOffset.y = item != nil ? item!.contentY : defaultContentSize.height / 2
        }

        func scrollViewDidEndDecelerating() {
            scrollableItem = nil
        }

        @objc func scrollViewDidScroll(_ scrollView: UIScrollView) {
            guard scrollableItem != nil else { return }
            scrollableItem!.setContentX(contentOffset.x)
            scrollableItem!.setContentY(contentOffset.y)
        }
    }

    fileprivate class ScrollableView: UIScrollView {
        var scrollable: Scrollable!

        override func draw(_ rect: CGRect) {
            if scrollable.contentItem != nil {
                let context = UIGraphicsGetCurrentContext()!
                scrollable.contentItem!.draw(context, inRect: rect.offsetBy(dx: scrollable.contentX, dy: scrollable.contentY))
            }

            super.draw(rect)
        }
    }

    static fileprivate let mainView = MainView()

    fileprivate var view: ScrollableView!
    var contentItem: Item?
    var contentX: CGFloat = 0
    var contentY: CGFloat = 0
    var viewRect = CGRect()

    fileprivate var dirtyRects = [CGRect]()

    override init(_ app: GameViewController) {
        super.init(app)
        self.view = ScrollableView()
        view.scrollable = self
    }

    override func updateBounds() {
        super.updateBounds()
        view.frame = bounds
    }

    func setContentItem(_ val: Item?){
        if contentItem != nil && contentItem?.parent === self {
            contentItem!.parent = nil
        }
        contentItem = val
        invalidate()
        if val != nil {
            val!.parent = self
        }
    }

    func setContentX(_ val: CGFloat, sendEvent: Bool = true){
        contentX = val
        view.contentOffset.x = -val
        invalidate()

        if sendEvent {
            app.client.pushAction(OutAction.scrollable_CONTENT_X)
            app.renderer.pushObject(self)
            app.client.pushFloat(val)
        }
    }

    func setContentY(_ val: CGFloat, sendEvent: Bool = true){
        contentY = val
        view.contentOffset.y = -val
        invalidate()

        if sendEvent {
            app.client.pushAction(OutAction.scrollable_CONTENT_Y)
            app.renderer.pushObject(self)
            app.client.pushFloat(val)
        }
    }

    func activate(){
        Scrollable.mainView.setScrollableItem(self)
    }

    override func measure(_ globalTransform: CGAffineTransform, _ viewRect: CGRect, _ dirtyRects: inout [CGRect], forceUpdateBounds: Bool = false) {
        let letDirtyTransform = dirtyTransform
        let letDirtyChildren = dirtyChildren

        super.measure(globalTransform, viewRect, &dirtyRects, forceUpdateBounds: forceUpdateBounds)

        // measure content item
        if contentItem != nil {
            // include local transform
            let innerGlobalTransform = transform.concatenating(globalTransform)

            // layout content view
            view!.contentSize = contentItem!.bounds.size

            // detect content dirty rectangle
            let forceChildrenUpdate = forceUpdateBounds || letDirtyTransform
            if forceChildrenUpdate || letDirtyChildren {
                self.viewRect = globalBounds.offsetBy(dx: contentX, dy: contentY)

                contentItem!.measure(innerGlobalTransform, self.viewRect, &self.dirtyRects, forceUpdateBounds: forceChildrenUpdate)

                if self.dirtyRects.count > 0 {
                    for rect in self.dirtyRects {
                        view!.setNeedsDisplay(rect)
                        dirtyRects.append(rect.offsetBy(dx: -contentX, dy: -contentY))
                    }

                    self.dirtyRects.removeAll()
                }
            }
        }
    }

    override func drawShape(_ context: CGContext, inRect rect: CGRect) {
        context.translateBy(x: -contentX, y: -contentY)
        view.draw(rect.offsetBy(dx: -globalBounds.origin.x, dy: -globalBounds.origin.y))
        context.translateBy(x: contentX, y: contentY)
    }
}
