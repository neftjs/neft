import UIKit

class NativeItem: Item {
    class NativeUIView: UIView {}

    static var types: Dictionary<String, () -> NativeItem> = [:]
    class var name: String { return "Unknown" }

    override class func register(){
        onAction(.createNativeItem) {
            (reader: Reader) in
            let ctorName = reader.getString()
            let ctor = types[ctorName]
            if ctor == nil {
                print("Native item '\(ctorName)' type not found")
                save(item: NativeItem())
            } else {
                save(item: ctor!())
            }
        }

        onAction(.onNativeItemPointerPress) {
            (item: NativeItem, reader: Reader) in
            item.onPointerPress(reader.getFloat(), reader.getFloat())
        }

        onAction(.onNativeItemPointerMove) {
            (item: NativeItem, reader: Reader) in
            item.onPointerMove(reader.getFloat(), reader.getFloat())
        }

        onAction(.onNativeItemPointerRelease) {
            (item: NativeItem, reader: Reader) in
            item.onPointerRelease(reader.getFloat(), reader.getFloat())
        }
    }

    private static func on<T: NativeItem>(
        _ type: String,
        _ name: String,
        _ handler: @escaping (T, [Any?]) -> Void
        ) {
        let funcName = "renderer\(type)\(self.name.uppercaseFirst)\(name.uppercaseFirst)"
        App.getApp().client.addCustomFunction(funcName) {
            (inputArgs: [Any?]) in
            var args = inputArgs
            let index = Int(round(args[0] as! CGFloat))
            let item = App.getApp().renderer.items[index] as! T
            args.removeFirst()
            handler(item, args)
        }
    }

    internal static func onSet<T: NativeItem>(
        _ propertyName: String,
        _ handler: @escaping (T, [Any?]) -> Void
        ) {
        on("Set", propertyName, handler)
    }

    internal static func onSet<T: NativeItem>(
        _ propertyName: String,
        _ handler: @escaping (T, Bool) -> Void
        ) {
        onSet(propertyName) {
            (item: T, args: [Any?]) in
            handler(item, args[0] as! Bool)
        }
    }

    internal static func onSet<T: NativeItem>(
        _ propertyName: String,
        _ handler: @escaping (T, CGFloat) -> Void
        ) {
        onSet(propertyName) {
            (item: T, args: [Any?]) in
            handler(item, args[0] as! CGFloat)
        }
    }

    internal static func onSet<T: NativeItem>(
        _ propertyName: String,
        _ handler: @escaping (T, Int) -> Void
        ) {
        onSet(propertyName) {
            (item: T, args: [Any?]) in
            handler(item, Int(args[0] as! CGFloat))
        }
    }

    internal static func onSet<T: NativeItem>(
        _ propertyName: String,
        _ handler: @escaping (T, UIColor?) -> Void
        ) {
        onSet(propertyName) {
            (item: T, val: Int?) in
            handler(item, val != nil ? Color.hexColorToUIColor(val!) : nil)
        }
    }

    internal static func onSet<T: NativeItem>(
        _ propertyName: String,
        _ handler: @escaping (T, Item?) -> Void
        ) {
        onSet(propertyName) {
            (item: T, val: Int?) in
            handler(item, val != nil && val! >= 0 ? renderer.items[val!] : nil)
        }
    }

    internal static func onSet<T: NativeItem>(
        _ propertyName: String,
        _ handler: @escaping (T, String) -> Void
        ) {
        onSet(propertyName) {
            (item: T, args: [Any?]) in
            handler(item, args[0] as! String)
        }
    }

    internal static func onCall<T: NativeItem>(
        _ funcName: String,
        _ handler: @escaping (T, [Any?]) -> Void
        ) {
        on("Call", funcName, handler)
    }

    internal static func onCreate<T: NativeItem>(
        handler: @escaping () -> T
        ) {
        let typeName = self.name
        assert(NativeItem.types[typeName] == nil, "NativeItem \(typeName) onCreate already called")
        NativeItem.types[typeName] = handler
    }

    var autoWidth = true
    var autoHeight = true
    override var keysFocus: Bool {
        didSet {
            if keysFocus {
                view.becomeFirstResponder()
            } else {
                view.resignFirstResponder()
            }
        }
    }

    override var width: CGFloat {
        didSet {
            autoWidth = width == 0
            updateSize()
        }
    }

    override var height: CGFloat {
        didSet {
            autoHeight = height == 0
            updateSize()
        }
    }

    override init(view: UIView = UIView()) {
        super.init(view: view)
    }

    override func didSave() {
        super.didSave()
        updateSize()
    }

    internal func updateSize() {
        let width = autoWidth ? view.frame.width : self.width
        let height = autoHeight ? view.frame.height : self.height
        pushWidth(width)
        pushHeight(height)
    }

    private func pushWidth(_ val: CGFloat) {
        if autoWidth && width != val {
            self.width = val
            pushAction(.nativeItemWidth, val)
        }
    }

    private func pushHeight(_ val: CGFloat) {
        if autoHeight && height != val {
            self.height = val
            pushAction(.nativeItemHeight, val)
        }
    }

    internal func onPointerPress(_ x: CGFloat, _ y: CGFloat) {
    }

    internal func onPointerRelease(_ x: CGFloat, _ y: CGFloat) {
    }

    internal func onPointerMove(_ x: CGFloat, _ y: CGFloat) {
    }

    internal func pushEvent(event: String, args: [Any?]?) {
        let eventName = "rendererOn\(type(of: self).name.uppercaseFirst)\(event.uppercaseFirst)"
        var clientArgs: [Any?] = [CGFloat(id)]
        if args != nil {
            clientArgs.append(contentsOf: args!)
        }
        App.getApp().client.pushEvent(eventName, args: clientArgs)
    }
}
