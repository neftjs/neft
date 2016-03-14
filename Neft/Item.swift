import UIKit

extension Array where Element: Renderer.Object {
    func indexOfObject(object: Element) -> Int? {
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

    mutating func removeObject(object: Element) -> Bool {
        if let index = self.indexOfObject(object) {
            self.removeAtIndex(index)
            return true;
        }
        return false;
    }
}

class Item: Renderer.Object {
    class func register(app: GameViewController) {
        app.client.actions[InAction.CREATE_ITEM] = {
            (reader: Reader) in
            Item(app)
        }
        app.client.actions[InAction.SET_ITEM_PARENT] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setParent(app.renderer.getObjectFromReader(reader) as? Item)
        }
        app.client.actions[InAction.INSERT_ITEM_BEFORE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .insertBefore(app.renderer.getObjectFromReader(reader) as! Item)
        }
        app.client.actions[InAction.SET_ITEM_VISIBLE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setVisible(reader.getBoolean())
        }
        app.client.actions[InAction.SET_ITEM_CLIP] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setClip(reader.getBoolean())
        }
        app.client.actions[InAction.SET_ITEM_WIDTH] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setWidth(reader.getFloat())
        }
        app.client.actions[InAction.SET_ITEM_HEIGHT] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setHeight(reader.getFloat())
        }
        app.client.actions[InAction.SET_ITEM_X] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setX(reader.getFloat())
        }
        app.client.actions[InAction.SET_ITEM_Y] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setY(reader.getFloat())
        }
        app.client.actions[InAction.SET_ITEM_SCALE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setScale(reader.getFloat())
        }
        app.client.actions[InAction.SET_ITEM_ROTATION] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setRotation(reader.getFloat())
        }
        app.client.actions[InAction.SET_ITEM_OPACITY] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setOpacity(reader.getInteger())
        }
        app.client.actions[InAction.SET_ITEM_BACKGROUND] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! Item)
                .setBackground(app.renderer.getObjectFromReader(reader) as? Item)
        }
        app.client.actions[InAction.SET_ITEM_KEYS_FOCUS] = {
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

    internal private(set) var dirty = false
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

    private func updateTransform() {
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
        self.transform = CGAffineTransformMake(a, b, c, d, tx, ty)
    }

    internal func updateBounds() {
        bounds.size.width = width
        bounds.size.height = height
    }

    func setParent(val: Item?) {
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

    func insertBefore(val: Item) {
        if parent != nil {
            parent!.children.removeObject(self)
            parent!.invalidate()
        }

        let newParent = val.parent!
        let index = newParent.children.indexOfObject(val)!
        newParent.children.insert(self, atIndex: index)
        self.parent = newParent
        newParent.invalidate()
        invalidate()
    }

    func setVisible(val: Bool) {
        self.visible = val
        invalidate()
    }

    func setClip(val: Bool) {
        self.clip = val
        invalidate()
    }

    func setWidth(val: CGFloat) {
        self.width = val
        invalidate()
        dirtyTransform = true
        updateBounds()
    }

    func setHeight(val: CGFloat) {
        self.height = val
        invalidate()
        dirtyTransform = true
        updateBounds()
    }

    func setX(val: CGFloat) {
        self.x = val
        invalidate()
        dirtyTransform = true
    }

    func setY(val: CGFloat) {
        self.y = val
        invalidate()
        dirtyTransform = true
    }

    func setScale(val: CGFloat) {
        self.scale = val
        invalidate()
        dirtyTransform = true
    }

    func setRotation(val: CGFloat) {
        self.rotation = val
        invalidate()
        dirtyTransform = true
    }

    func setOpacity(val: Int) {
        self.opacity = CGFloat(val) / 255
        invalidate()
    }

    func setBackground(val: Item?) {
        self.background = val
        invalidate()
    }

    func setKeysFocus(val: Bool) {

    }

    func measure(var globalTransform: CGAffineTransform, var _ viewRect: CGRect, inout _ dirtyRects: [CGRect], forceUpdateBounds: Bool = false) {
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
        globalTransform = CGAffineTransformConcat(transform, globalTransform)

        // update bounds
        if isDirty {
            let oldGlobalBounds = globalBounds
            globalBounds = CGRectApplyAffineTransform(bounds, globalTransform)

            // add rectangle to redraw
            if dirty || dirtyTransform || !CGRectEqualToRect(globalBounds, oldGlobalBounds) {
                var redrawRect = CGRectUnion(oldGlobalBounds, globalBounds)
                redrawRect = CGRectIntersection(redrawRect, viewRect)
                if !CGRectIsEmpty(redrawRect) {
                    var i = 0
                    let length = dirtyRects.count
                    while i < length {
                        if CGRectIntersectsRect(dirtyRects[i], redrawRect) {
                            dirtyRects[i] = CGRectUnion(dirtyRects[i], redrawRect)
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
        if clip {
            viewRect = globalBounds
        }

        let forceChildrenUpdate = forceUpdateBounds || dirtyTransform
        if forceChildrenUpdate || dirtyChildren {
            // clear
            dirtyChildren = false
            dirtyTransform = false
            
            // measure background
            background?.measure(globalTransform, viewRect, &dirtyRects, forceUpdateBounds: forceChildrenUpdate)

            // measure children
            var i = 0
            let children = self.children
            let length = children.count
            while i < length {
                children[i].measure(globalTransform, viewRect, &dirtyRects, forceUpdateBounds: forceChildrenUpdate)
                i += 1
            }
        }
    }

    func drawShape(context: CGContextRef, inRect rect: CGRect) {

    }

    func draw(context: CGContextRef, inRect rect: CGRect) {
        CGContextSaveGState(context)

        // set opacity
        CGContextSetAlpha(context, opacity)

        // transform
        CGContextConcatCTM(context, transform)

        // clip
        if clip {
            CGContextClipToRect(context, bounds)
        }

        // background
        background?.draw(context, inRect: rect)

        // shape
        if CGRectIntersectsRect(rect, globalBounds) {
            drawShape(context, inRect: rect)
        }

        // render children
        for child in children {
            if child.visible {
                child.draw(context, inRect: rect)
            }
        }

        CGContextRestoreGState(context)
    }
}
