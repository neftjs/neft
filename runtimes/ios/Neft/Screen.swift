import UIKit

class Screen {
    var rect: CGRect
    
    class func register(app: GameViewController){
        
    }
    
    init(_ app: GameViewController) {
        // SCREEN_SIZE
        let mainScreen = UIScreen.mainScreen()
        let size = mainScreen.bounds
        self.rect = size
        app.client.pushAction(OutAction.SCREEN_SIZE)
        app.client.pushFloat(size.width)
        app.client.pushFloat(size.height)
    }
}

