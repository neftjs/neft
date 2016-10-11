import Foundation

class Navigator {
    class func register(_ app: GameViewController){
        
    }
    
    init(_ app: GameViewController) {
        // NAVIGATOR_LANGUAGE
        app.client.pushAction(OutAction.navigatorLanguage)
        app.client.pushString(Locale.preferredLanguages[0])
        
        // NAVIGATOR_ONLINE
        // TODO
    }
}
