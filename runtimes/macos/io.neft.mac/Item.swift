import Cocoa

class ItemView: NSView {
    override var isFlipped: Bool {
        return true
    }
}

class Item {
    class var renderer: Renderer {
        return App.getApp().renderer
    }

    class func onAction(_ action: InAction, _ handler: @escaping (Reader) -> Void) {
        App.getApp().client.onAction(action, handler)
    }

    class func onAction(_ action: InAction, _ handler: @escaping () -> Void) {
        App.getApp().client.onAction(action, handler)
    }

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T) -> Void) {
        onAction(action) {
            (reader: Reader) in
            handler(renderer.getItemFromReader(reader)! as! T)
        }
    }

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T, Reader) -> Void) {
        onAction(action) {
            (reader: Reader) in
            handler(renderer.getItemFromReader(reader)! as! T, reader)
        }
    }

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T, Item?) -> Void) {
        onAction(action) {
            (item: T, reader: Reader) in
            handler(item, renderer.getItemFromReader(reader))
        }
    }

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T, Bool) -> Void) {
        onAction(action) {
            (item: T, reader: Reader) in
            handler(item, reader.getBoolean())
        }
    }

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T, CGFloat) -> Void) {
        onAction(action) {
            (item: T, reader: Reader) in
            handler(item, reader.getFloat())
        }
    }

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T, Int) -> Void) {
        onAction(action) {
            (item: T, reader: Reader) in
            handler(item, reader.getInteger())
        }
    }

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T, CGColor) -> Void) {
        onAction(action) {
            (item: T, reader: Reader) in
            handler(item, Color.hexColorToCGColor(reader.getInteger()))
        }
    }

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T, NSColor) -> Void) {
        onAction(action) {
            (item: T, reader: Reader) in
            handler(item, Color.hexColorToNSColor(reader.getInteger()))
        }
    }

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T, String) -> Void) {
        onAction(action) {
            (item: T, reader: Reader) in
            handler(item, reader.getString())
        }
    }

    class func register() {
        onAction(.createItem) {
            save(item: Item())
        }

        onAction(.setItemParent) {
            (item: Item, parent: Item?) in
            item.view.removeFromSuperview()
            parent?.view.addSubview(item.view)
            item.updateTransform()
        }

        onAction(.insertItemBefore) {
            (item: Item, sibling: Item?) in
            item.view.removeFromSuperview()
            if sibling != nil {
                sibling!.view.superview?.addSubview(item.view, positioned: .below, relativeTo: sibling!.view)
            }
            item.updateTransform()
        }

        onAction(.setItemVisible) {
            (item: Item, val: Bool) in
            item.view.isHidden = !val
            item.updateTransform()
        }

        onAction(.setItemClip) {
            (item: Item, val: Bool) in
            item.layer.masksToBounds = val
        }

        onAction(.setItemWidth) {
            (item: Item, val: CGFloat) in
            item.width = val
        }

        onAction(.setItemHeight) {
            (item: Item, val: CGFloat) in
            item.height = val
        }

        onAction(.setItemX) {
            (item: Item, val: CGFloat) in
            item.x = val
        }

        onAction(.setItemY) {
            (item: Item, val: CGFloat) in
            item.y = val
        }

        onAction(.setItemScale) {
            (item: Item, val: CGFloat) in
            item.scale = val
        }

        onAction(.setItemRotation) {
            (item: Item, val: CGFloat) in
            item.rotation = val
        }

        onAction(.setItemOpacity) {
            (item: Item, val: Int) in
            item.layer.opacity = Float(CGFloat(val) / 255)
        }

        onAction(.setItemKeysFocus) {
            (item: Item, val: Bool) in
            item.keysFocus = val
        }
    }

    var id: Int!
    let view: ItemView
    let layer: CALayer

    var x: CGFloat = 0 {
        didSet {
            updateFrame()
        }
    }

    var y: CGFloat = 0 {
        didSet {
            updateFrame()
        }
    }

    var width: CGFloat = 0 {
        didSet {
            updateFrame()
        }
    }

    var height: CGFloat = 0 {
        didSet {
            updateFrame()
        }
    }

    var scale: CGFloat = 1 {
        didSet {
            updateTransform()
        }
    }

    var rotation: CGFloat = 0 {
        didSet {
            updateTransform()
        }
    }

    var keysFocus = false

    class func save(item: Item) {
        assert(item.id == nil)
        item.id = renderer.items.count
        renderer.items.append(item)
        item.didSave()
    }

    init(layer: CALayer = CALayer()) {
        self.view = ItemView()
        self.layer = layer
        view.wantsLayer = true
        view.layer = layer
    }

    func didSave() {}

    private func updateFrame() {
        view.frame = CGRect(x: x, y: y, width: width, height: height)
        updateTransform()
    }

    private func updateTransform() {
        guard view.superview != nil else { return }

        var a: CGFloat = 1
        var b: CGFloat = 0
        var c: CGFloat = 0
        var d: CGFloat = 1
        var tx: CGFloat = 0
        var ty: CGFloat = 0

        let originX = width / 2
        let originY = height / 2

        // translate to the origin
        tx = originX
        ty = originY

        // scale
        a = scale
        d = scale

        // rotate
        if rotation != 0 {
            let sr = sin(rotation)
            let cr = cos(rotation)

            let ac = a
            let dc = d

            a = ac * cr
            b = dc * sr
            c = ac * -sr
            d = dc * cr
        }

        // translate to the position
        tx += a * -originX + c * -originY
        ty += b * -originX + d * -originY

        // save
        let transform = CGAffineTransform(a: a, b: b, c: c, d: d, tx: tx, ty: ty)
        layer.setAffineTransform(transform)
    }

    func pushAction(_ action: OutAction, _ args: Any...) {
        var localArgs = args
        localArgs.insert(self.id, at: 0)
        App.getApp().client.pushAction(action, localArgs)
    }

}
