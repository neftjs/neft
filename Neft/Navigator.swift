import Foundation

class Navigator {
    class func register(app: GameViewController){
        
    }
    
    init(_ app: GameViewController) {
        // NAVIGATOR_LANGUAGE
        app.client.pushAction(OutAction.NAVIGATOR_LANGUAGE)
        app.client.pushString(NSLocale.preferredLanguages()[0])
        
        // NAVIGATOR_ONLINE
        // TODO
    }
}
