import Cocoa

class Screen {
    var rect: CGRect

    class func register() {
    }

    init() {
        // SCREEN_SIZE
        let size = NSScreen.main()!.visibleFrame
        self.rect = size
        App.getApp().client.pushAction(.screenSize, size.width, size.height)
    }

}
