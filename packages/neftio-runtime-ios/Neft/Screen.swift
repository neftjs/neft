import UIKit

class Screen {
    var rect: CGRect

    class func register(){
        App.getApp().client.onAction(.setScreenStatusBarColor) {
            (reader: Reader) in
            let val = reader.getString()
            if val == "Light" {
                UIApplication.shared.statusBarStyle = .lightContent
            } else {
                UIApplication.shared.statusBarStyle = .default
            }
        }
    }

    init() {
        let app = App.getApp()

        // SCREEN_SIZE
        let mainScreen = UIScreen.main
        let size = mainScreen.bounds
        self.rect = size
        app.client.pushAction(.screenSize, size.width, size.height)

        // SCREEN_STATUSBAR_HEIGHT
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        app.client.pushAction(.screenStatusBarHeight, statusBarHeight)

        // SCREEN_NAVIGATIONBAR_HEIGHT
        if #available(iOS 11.0, *) {
            let navigationBarHeight = UIApplication.shared.delegate?.window??.safeAreaInsets.bottom ?? 0
            app.client.pushAction(.screenNavigationBarHeight, navigationBarHeight)
        }
    }
}

