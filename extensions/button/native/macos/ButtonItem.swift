import Cocoa

extension Extension.Button {
    class ButtonItem: NativeItem {
        override class var name: String { return "Button" }

        override class func register() {
            onCreate {
                return ButtonItem()
            }

            onSet("text") {
                (item: ButtonItem, val: String) in
                item.buttonView.title = val
                item.buttonView.sizeToFit()
                item.updateSize()
            }

            onSet("textColor") {
                (item: ButtonItem, val: NSColor?) in
            }
        }

        var buttonView: NSButton {
            return itemView as! NSButton
        }

        init() {
            super.init(itemView: NSButton())
        }
    }
}
