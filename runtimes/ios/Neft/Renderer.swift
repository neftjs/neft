import UIKit

class Renderer {
    var app: GameViewController!

    var items: [Item] = []

    private let measureTransform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
    private var dirtyRects = [CGRect]()

    var navigator: Navigator!
    var device: Device!
    var screen: Screen!

    func getItemFromReader(_ reader: Reader) -> Item? {
        let id = reader.getInteger()
        return id == -1 ? nil : self.items[id]
    }

    func load() {
        self.navigator = Navigator()
        self.device = Device()
        self.screen = Screen()

        Device.register()
        Screen.register()
        Navigator.register()
        Item.register()
        Image.register()
        Text.register()
        TextInput.register()
        NativeItem.register()
        Rectangle.register()
        Scrollable.register()
    }

    func pxToDp(_ px: CGFloat) -> CGFloat {
        return px / device.pixelRatio
    }

    func dpToPx(_ dp: CGFloat) -> CGFloat {
        return dp * device.pixelRatio
    }

    func pushItem(_ val: Item) {
        app.client.pushInteger(val.id)
    }
}
