import UIKit

extension Array where Element: Renderer.Object {
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

class Item: Renderer.Object {
    class func register(_ app: GameViewController) {
        app.client.actions[InAction.createItem] = {
            (reader: Reader) in
            Item(app)
        }
        app.client.actions[InAction.setItemParent] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setParent(app.renderer.getObjectFromReader(reader) as? Item)
        }
        app.client.actions[InAction.insertItemBefore] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .insertBefore(app.renderer.getObjectFromReader(reader) as! Item)
        }
        app.client.actions[InAction.setItemVisible] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setVisible(reader.getBoolean())
        }
        app.client.actions[InAction.setItemClip] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setClip(reader.getBoolean())
        }
        app.client.actions[InAction.setItemWidth] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setWidth(reader.getFloat())
        }
        app.client.actions[InAction.setItemHeight] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setHeight(reader.getFloat())
        }
        app.client.actions[InAction.setItemX] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setX(reader.getFloat())
        }
        app.client.actions[InAction.setItemY] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setY(reader.getFloat())
        }
        app.client.actions[InAction.setItemScale] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setScale(reader.getFloat())
        }
        app.client.actions[InAction.setItemRotation] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setRotation(reader.getFloat())
        }
        app.client.actions[InAction.setItemOpacity] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setOpacity(reader.getInteger())
        }
        app.client.actions[InAction.setItemBackground] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setBackground(app.renderer.getObjectFromReader(reader) as? Item)
        }
        app.client.actions[InAction.setItemKeysFocus] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setKeysFocus(reader.getBoolean())
        }
    }

    var x: CGFloat = 0
    var y: CGFloat = 0
    var width: CGFloat = 0
    var height: CGFloat = 0
    var scale: CGFloat = 1
    var rotation: CGFloat = 0
    var opacity: CGFloat = 1
    var visible: Bool = true
    var clip: Bool = false
    var parent: Item?
    var background: Item?
    var children = [Item]()

    var transform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)

    internal fileprivate(set) var dirty = false
    internal var dirtyChildren = false
    internal var dirtyTransform = false
    var bounds = CGRect()
    var globalBounds = CGRect()

    internal func invalidate() {
        if dirty {
           return
        }
        dirty = true
        var parent = self.parent
        while parent != nil && !parent!.dirtyChildren {
            parent!.dirtyChildren = true
            parent = parent!.parent
        }
    }

    fileprivate func updateTransform() {
        var a: CGFloat = 1
        var b: CGFloat = 0
        var c: CGFloat = 0
        var d: CGFloat = 1
        var tx: CGFloat = 0
        var ty: CGFloat = 0

        let originX = width / 2
        let originY = height / 2

        // translate to the origin
        tx = x + originX
        ty = y + originY

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
        self.transform = CGAffineTransform(a: a, b: b, c: c, d: d, tx: tx, ty: ty)
    }

    internal func updateBounds() {
        bounds.size.width = width
        bounds.size.height = height
    }

    func setParent(_ val: Item?) {
        if parent != nil {
            parent!.children.removeObject(self)
            parent!.invalidate()
        }

        if val != nil {
            val!.children.append(self)
            val!.invalidate()
        }

        self.parent = val
        invalidate()
    }

    func insertBefore(_ val: Item) {
        if parent != nil {
            parent!.children.removeObject(self)
            parent!.invalidate()
        }

        let newParent = val.parent!
        let index = newParent.children.indexOfObject(val)!
        newParent.children.insert(self, at: index)
        self.parent = newParent
        newParent.invalidate()
        invalidate()
    }

    func setVisible(_ val: Bool) {
        self.visible = val
        invalidate()
    }

    func setClip(_ val: Bool) {
        self.clip = val
        invalidate()
    }

    func setWidth(_ val: CGFloat) {
        self.width = val
        invalidate()
        dirtyTransform = true
        updateBounds()
    }

    func setHeight(_ val: CGFloat) {
        self.height = val
        invalidate()
        dirtyTransform = true
        updateBounds()
    }

    func setX(_ val: CGFloat) {
        self.x = val
        invalidate()
        dirtyTransform = true
    }

    func setY(_ val: CGFloat) {
        self.y = val
        invalidate()
        dirtyTransform = true
    }

    func setScale(_ val: CGFloat) {
        self.scale = val
        invalidate()
        dirtyTransform = true
    }

    func setRotation(_ val: CGFloat) {
        self.rotation = val
        invalidate()
        dirtyTransform = true
    }

    func setOpacity(_ val: Int) {
        self.opacity = CGFloat(val) / 255
        invalidate()
    }

    func setBackground(_ val: Item?) {
        self.background = val
        invalidate()
    }

    func setKeysFocus(_ val: Bool) {

    }

    func measure(_ globalTransform: CGAffineTransform, _ viewRect: CGRect, _ dirtyRects: inout [CGRect], forceUpdateBounds: Bool = false) {
        let isDirty = forceUpdateBounds || dirty || dirtyTransform

        // break on no changes
        if !dirtyChildren && !isDirty {
            return
        }

        // update transform
        if dirtyTransform {
            updateTransform()
        }

        // include local transform
        let innerGlobalTransform = transform.concatenating(globalTransform)

        // update bounds
        if isDirty {
            let oldGlobalBounds = globalBounds
            globalBounds = bounds.applying(innerGlobalTransform)

            // add rectangle to redraw
            if dirty || dirtyTransform || !globalBounds.equalTo(oldGlobalBounds) {
                var redrawRect = oldGlobalBounds.union(globalBounds)
                redrawRect = redrawRect.intersection(viewRect)
                if !redrawRect.isEmpty {
                    var i = 0
                    let length = dirtyRects.count
                    while i < length {
                        if dirtyRects[i].intersects(redrawRect) {
                            dirtyRects[i] = dirtyRects[i].union(redrawRect)
                            break
                        }
                        i += 1
                    }
                    if i == length {
                        dirtyRects.append(redrawRect)
                    }
                }

                dirty = false
            }
        }

        // clip
        let childrenViewRect = clip ? globalBounds : viewRect;

        let forceChildrenUpdate = forceUpdateBounds || dirtyTransform
        if forceChildrenUpdate || dirtyChildren {
            // clear
            dirtyChildren = false
            dirtyTransform = false

            // measure background
            background?.measure(innerGlobalTransform, childrenViewRect, &dirtyRects, forceUpdateBounds: forceChildrenUpdate)

            // measure children
            var i = 0
            let children = self.children
            let length = children.count
            while i < length {
                children[i].measure(innerGlobalTransform, childrenViewRect, &dirtyRects, forceUpdateBounds: forceChildrenUpdate)
                i += 1
            }
        }
    }

    func drawShape(_ context: CGContext, inRect rect: CGRect) {

    }

    func draw(_ context: CGContext, inRect rect: CGRect) {
        context.saveGState()

        // set opacity
        context.setAlpha(opacity)

        // transform
        context.concatenate(transform)

        // clip
        if clip {
            context.clip(to: bounds)
        }

        // background
        background?.draw(context, inRect: rect)

        // shape
        if rect.intersects(globalBounds) {
            drawShape(context, inRect: rect)
        }

        // render children
        for child in children {
            if child.visible {
                child.draw(context, inRect: rect)
            }
        }

        context.restoreGState()
    }
}
