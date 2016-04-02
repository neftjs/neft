import UIKit

class NativeItem: Item {
    static var types: Dictionary<String, (app: GameViewController) -> NativeItem> = [:]

    class var name: String {
        return "Unknown"
    }

    override class func register(app: GameViewController){
        app.client.actions[InAction.CREATE_NATIVE_ITEM] = {
            (reader: Reader) in
            let ctorName = reader.getString()
            let ctor = types[ctorName]
            if ctor == nil {
                print("Native item '\(ctorName)' type not found")
                NativeItem(app)
            } else {
                ctor!(app: app)
            }
        }
        app.client.actions[InAction.ON_NATIVE_ITEM_POINTER_PRESS] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! NativeItem)
                .onPointerPress(reader.getFloat(), reader.getFloat())
        }
        app.client.actions[InAction.ON_NATIVE_ITEM_POINTER_RELEASE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! NativeItem)
                .onPointerRelease(reader.getFloat(), reader.getFloat())
        }
        app.client.actions[InAction.ON_NATIVE_ITEM_POINTER_MOVE] = {
            (reader: Reader) in
            (app.renderer.getObjectFromReader(reader) as! NativeItem)
                .onPointerMove(reader.getFloat(), reader.getFloat())
        }
    }

    static func addClientAction(app: GameViewController, type: String, name: String, handler: ((NativeItem, [Any?]) -> Void)) {
        let funcName = "renderer\(type)\(self.name.uppercaseFirst)\(name.uppercaseFirst)"
        let clientHandler = {
            (inputArgs: [Any?]) in
            var args = inputArgs
            let index = Int(round(args[0] as! CGFloat))
            let item = app.renderer.objects[index] as! NativeItem
            args.removeFirst()
            handler(item, args)
        }
        app.client.addCustomFunction(funcName, function: clientHandler)
    }

    class func addClientProperty(app: GameViewController, name: String, handler: ((NativeItem, [Any?]) -> Void)) {
        addClientAction(app, type: "Set", name: name, handler: handler)
    }

    class func addClientFunction(app: GameViewController, name: String, handler: ((NativeItem, [Any?]) -> Void)) {
        addClientAction(app, type: "Call", name: name, handler: handler)

    }

    var autoWidth = true
    var autoHeight = true
    var pressed = false
    internal var view: UIView?
    internal var invalidateDuration: Double = 0
    internal var onPointerPressInvalidateDuration: Double = 0
    internal var onPointerReleaseInvalidateDuration: Double = 0
    internal var onPointerMoveInvalidateDuration: Double = 0

    init(_ app: GameViewController, view: UIView? = nil) {
        super.init(app)
        self.view = view
        if view != nil {
            app.shadowWindow.addSubview(view!)
            updateSize()
        }
        app.renderer.device.onTouchEnded.connect {
            (arg: Any?) in
            self.pressed = false
        }
    }

    internal func pushEvent(name: String, args: [Any?]?) {
        let eventName = "rendererOn\(self.dynamicType.name.uppercaseFirst)\(name.uppercaseFirst)"
        var clientArgs: [Any?] = [CGFloat(self.id)]
        if args != nil {
            clientArgs.appendContentsOf(args!)
        }
        app.client.pushEvent(eventName, args: clientArgs)
    }

    override func setWidth(val: CGFloat) {
        super.setWidth(val)
        autoWidth = val == 0
        updateSize()
    }

    override func setHeight(val: CGFloat) {
        super.setHeight(val)
        autoHeight = val == 0
        updateSize()
    }

    internal func updateSize() {
        guard view != nil else { return; }

        let width = autoWidth ? view!.bounds.width : self.width
        let height = autoHeight ? view!.bounds.height : self.height
        view!.bounds.size.width = width
        view!.bounds.size.height = height
        pushWidth(width)
        pushHeight(height)
    }

    internal func pushWidth(val: CGFloat) {
        if autoWidth && width != val {
            super.setWidth(val)
            app.client.pushAction(OutAction.NATIVE_ITEM_WIDTH)
            app.client.pushInteger(id)
            app.client.pushFloat(val)
        }
    }

    internal func pushHeight(val: CGFloat) {
        if autoHeight && height != val {
            super.setHeight(val)
            app.client.pushAction(OutAction.NATIVE_ITEM_HEIGHT)
            app.client.pushInteger(id)
            app.client.pushFloat(val)
        }
    }

    func onPointerPress(x: CGFloat, _ y: CGFloat) {
        pressed = true

        guard view != nil else { return; }

        if onPointerPressInvalidateDuration > 0 {
            self.invalidateDuration = onPointerPressInvalidateDuration
            invalidate()
        }
    }

    func onPointerRelease(x: CGFloat, _ y: CGFloat) {
        guard view != nil else { return; }

        if onPointerReleaseInvalidateDuration > 0 {
            self.invalidateDuration = onPointerReleaseInvalidateDuration
            invalidate()
        }
    }

    func onPointerMove(x: CGFloat, _ y: CGFloat) {
        guard view != nil else { return; }

        if onPointerMoveInvalidateDuration > 0 {
            self.invalidateDuration = onPointerMoveInvalidateDuration
            invalidate()
        }
    }

    override func measure(globalTransform: CGAffineTransform, _ viewRect: CGRect, inout _ dirtyRects: [CGRect], forceUpdateBounds: Bool) {
        super.measure(globalTransform, viewRect, &dirtyRects, forceUpdateBounds: forceUpdateBounds)
        if invalidateDuration > 0 {
            invalidateDuration -= app.frameDelay
            invalidate()
        }
        if view != nil {
            view!.frame = globalBounds
        }
    }

    override func drawShape(context: CGContextRef, inRect rect: CGRect) {
        if view != nil {
            view!.drawViewHierarchyInRect(bounds, afterScreenUpdates: false)
        }
    }
}

