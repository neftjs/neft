import UIKit

class Screen {
    var rect: CGRect
    
    class func register(){
        
    }
    
    init() {
        // SCREEN_SIZE
        let mainScreen = UIScreen.main
        let size = mainScreen.bounds
        self.rect = size
        App.getApp().client.pushAction(.screenSize, size.width + 1, size.height + 1)
    }
}

