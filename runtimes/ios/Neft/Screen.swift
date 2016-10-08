import UIKit

class Screen {
    var rect: CGRect
    
    class func register(_ app: GameViewController){
        
    }
    
    init(_ app: GameViewController) {
        // SCREEN_SIZE
        let mainScreen = UIScreen.main
        let size = mainScreen.bounds
        self.rect = size
        app.client.pushAction(OutAction.screen_SIZE)
        app.client.pushFloat(size.width)
        app.client.pushFloat(size.height)
    }
}

