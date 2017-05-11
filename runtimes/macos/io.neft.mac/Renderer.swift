import Cocoa

class Renderer {
    var app: ViewController!

    var items: [Item] = []

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
        NativeItem.register()
        Rectangle.register()
    }

    func pxToDp(_ px: CGFloat) -> CGFloat {
        return px / device.pixelRatio
    }

    func dpToPx(_ dp: CGFloat) -> CGFloat {
        return dp * device.pixelRatio
    }

}
