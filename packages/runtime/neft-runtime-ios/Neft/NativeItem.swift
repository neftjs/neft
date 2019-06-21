import UIKit

fileprivate var types: Dictionary<String, () -> NativeItem> = [:]
fileprivate var names: Dictionary<String, String> = [:]

class NativeItemBinding<T: NativeItem> {
    private var name: String!

    private func on(
        _ type: String,
        _ name: String,
        _ handler: @escaping (T, [Any?]) -> Void
        ) {
        let funcName = "renderer\(type)\(self.name.uppercaseFirst)\(name.uppercaseFirst)"
        App.getApp().client.addCustomFunction(funcName) {
            (inputArgs: [Any?]) in
            var args = inputArgs
            let index = (args[0] as! Number).int()
            let item = App.getApp().renderer.items[index] as! T
            args.removeFirst()
            handler(item, args)
        }
    }

    internal func onSet(
        _ propertyName: String,
        _ handler: @escaping (T, [Any?]) -> Void
        ) -> NativeItemBinding<T> {
        on("Set", propertyName, handler)
        return self
    }

    internal func onSet(
        _ propertyName: String,
        _ handler: @escaping (T, Bool) -> Void
        ) -> NativeItemBinding<T> {
        return onSet(propertyName) {
            (item: T, args: [Any?]) in
            handler(item, args[0] as! Bool)
        }
    }

    internal func onSet(
        _ propertyName: String,
        _ handler: @escaping (T, CGFloat) -> Void
        ) -> NativeItemBinding<T> {
        return onSet(propertyName) {
            (item: T, args: [Any?]) in
            handler(item, (args[0] as! Number).float())
        }
    }

    internal func onSet(
        _ propertyName: String,
        _ handler: @escaping (T, Int) -> Void
        ) -> NativeItemBinding<T> {
        return onSet(propertyName) {
            (item: T, args: [Any?]) in
            handler(item, (args[0] as! Number).int())
        }
    }

    internal func onSet(
        _ propertyName: String,
        _ handler: @escaping (T, UIColor?) -> Void
        ) -> NativeItemBinding<T> {
        return onSet(propertyName) {
            (item: T, val: Int?) in
            handler(item, val != nil ? Color.hexColorToUIColor(val!) : nil)
        }
    }

    internal func onSet(
        _ propertyName: String,
        _ handler: @escaping (T, Item?) -> Void
        ) -> NativeItemBinding<T> {
        return onSet(propertyName) {
            (item: T, val: Int?) in
            handler(item, val != nil && val! >= 0 ? Item.renderer.items[val!] : nil)
        }
    }

    internal func onSet(
        _ propertyName: String,
        _ handler: @escaping (T, String) -> Void
        ) -> NativeItemBinding<T> {
        return onSet(propertyName) {
            (item: T, args: [Any?]) in
            handler(item, args[0] as! String)
        }
    }

    internal func onCall(
        _ funcName: String,
        _ handler: @escaping (T, [Any?]) -> Void
        ) -> NativeItemBinding<T> {
        on("Call", funcName, handler)
        return self
    }

    internal func onCall(
        _ funcName: String,
        _ handler: @escaping (T) -> Void
        ) -> NativeItemBinding<T> {
        return onCall(funcName) {
            (item: T, args: [Any?]) in
            handler(item)
        }
    }

    internal func onCreate(
        _ name: String,
        _ handler: @escaping () -> T
        ) -> NativeItemBinding<T> {
        self.name = name
        let handlerStr = String(describing: type(of: handler))
        let className = handlerStr.components(separatedBy: "->")[1].trimmingCharacters(in: .whitespaces)
        names[className] = name
        types[name] = handler
        return self
    }

    internal func finalize() {}
}

class NativeItem: Item {
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

    class func main() {
        print("Override main function for \(type(of: self))")
    }

    static func registerItem(_ type: NativeItem.Type) {
        type.main()
    }

    var autoWidth = true
    var autoHeight = true
    var focused = false {
        didSet {
            if (focused) {
                pushAction(.itemKeysFocus)
            }
        }
    }
    override var keysFocus: Bool {
        didSet {
            if keysFocus {
                itemView.becomeFirstResponder()
            } else {
                itemView.resignFirstResponder()
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

    let itemView: UIView

    init(itemView: UIView = UIView()) {
        self.itemView = itemView
        super.init(view: UIView())
        view.addSubview(itemView)
    }

    override func didSave() {
        super.didSave()
        updateSize()
    }

    internal func updateSize() {
        let width = autoWidth ? itemView.frame.width : self.width
        let height = autoHeight ? itemView.frame.height : self.height
        itemView.frame = CGRect(x: 0, y: 0, width: width, height: height)
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
        let className = String(describing: type(of: self))
        let eventName = "rendererOn\(names[className]!.uppercaseFirst)\(event.uppercaseFirst)"
        var clientArgs: [Any?] = [id]
        if args != nil {
            clientArgs.append(contentsOf: args!)
        }
        App.getApp().client.pushEvent(eventName, args: clientArgs)
    }
}
