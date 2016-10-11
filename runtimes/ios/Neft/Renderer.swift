import UIKit

class Renderer {
    class Object {
        let app: GameViewController
        let id: Int

        init(_ app: GameViewController) {
            self.app = app
            self.id = app.renderer.objects.count
            app.renderer.objects.append(self)
        }
    }

    var app: GameViewController!

    var objects: [Object] = []

    private let measureTransform = CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0)
    private var dirtyRects = [CGRect]()

    var navigator: Navigator!
    var device: Device!
    var screen: Screen!

    func getObjectFromReader(_ reader: Reader) -> Object? {
        let id = reader.getInteger()
        return id == -1 ? nil : self.objects[id]
    }

    func load() {
        self.navigator = Navigator(app)
        self.device = Device(app)
        self.screen = Screen(app)

        Device.register(app)
        Screen.register(app)
        Navigator.register(app)
        Item.register(app)
        Image.register(app)
        Text.register(app)
        TextInput.register(app)
        NativeItem.register(app)
        Rectangle.register(app)
        Scrollable.register(app)
    }

    func pxToDp(_ px: CGFloat) -> CGFloat {
        return px / device.pixelRatio
    }

    func dpToPx(_ dp: CGFloat) -> CGFloat {
        return dp * device.pixelRatio
    }

    func pushObject(_ val: Object) {
        app.client.pushInteger(val.id)
    }

    func draw() {
        // measure window item
        app.window.windowItem?.measure(measureTransform, screen.rect, &dirtyRects)

        intersectRects: while true {
            var i = 1
            let length = dirtyRects.count
            while i < length {
                if dirtyRects[i-1].intersects(dirtyRects[i]) {
                    dirtyRects[i-1] = dirtyRects[i-1].union(dirtyRects[i])
                    dirtyRects.remove(at: i)
                    continue intersectRects
                }
                i += 1
            }
            break
        }

        for rect in dirtyRects {
            app.window.setNeedsDisplay(rect)
        }

        dirtyRects.removeAll()
    }
}
