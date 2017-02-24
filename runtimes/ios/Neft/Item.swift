import UIKit

extension Array where Element: Item {
    func indexOfObject(_ object: Element) -> Int? {
        let length = self.count
        var index = 0
        while index < length {
            if self[index] === object {
                return index
            }
            index += 1
        }
        return nil
    }

    mutating func removeObject(_ object: Element) -> Bool {
        if let index = self.indexOfObject(object) {
            self.remove(at: index)
            return true;
        }
        return false;
    }
}

class Item {
    class var renderer: Renderer {
        get {
            return App.getApp().renderer
        }
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

    class func onAction<T: Item>(_ action: InAction, _ handler: @escaping (T, UIColor) -> Void) {
        onAction(action) {
            (item: T, reader: Reader) in
            handler(item, Color.hexColorToUIColor(reader.getInteger()))
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
        }

        onAction(.insertItemBefore) {
            (item: Item, sibling: Item?) in
            item.view.removeFromSuperview()
            if sibling != nil {
                sibling!.view.superview?.insertSubview(item.view, belowSubview: sibling!.view)
            }
        }

        onAction(.setItemVisible) {
            (item: Item, val: Bool) in
            item.view.isHidden = !val
        }

        onAction(.setItemClip) {
            (item: Item, val: Bool) in
            item.view.clipsToBounds = val
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
            item.view.alpha = CGFloat(val) / 255
        }

        onAction(.setItemBackground) {
            (item: Item, val: Item?) in
            item.background = val
        }

        onAction(.setItemKeysFocus) {
            (item: Item, val: Bool) in
            item.keysFocus = val
        }
    }

    var id: Int!
    let view: UIView

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

    var background: Item? {
        didSet {
            oldValue?.view.removeFromSuperview()
            if background != nil {
                view.insertSubview(background!.view, at: 0)
            }
        }
    }

    var keysFocus = false

    class func save(item: Item) {
        assert(item.id == nil)
        item.id = renderer.items.count
        renderer.items.append(item)
        item.didSave()
    }

    init() {
        self.view = UIView()
    }

    func didSave() {}

    private func updateFrame() {
        view.frame = CGRect(x: x, y: y, width: width, height: height)
    }

    private func updateTransform() {
        var a: CGFloat = 1
        var b: CGFloat = 0
        var c: CGFloat = 0
        var d: CGFloat = 1

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

        // save
        view.transform = CGAffineTransform(a: a, b: b, c: c, d: d, tx: 0, ty: 0)
    }

    func pushAction(_ action: OutAction, _ args: Any...) {
        var localArgs = args
        localArgs.insert(self.id, at: 0)
        App.getApp().client.pushAction(action, localArgs)
    }
}
