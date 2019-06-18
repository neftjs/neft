import Foundation

class Navigator {
    class func register(){

    }

    init() {
        // NAVIGATOR_LANGUAGE
        App.getApp().client.pushAction(.navigatorLanguage, Locale.preferredLanguages[0])

        // NAVIGATOR_ONLINE
        // TODO
    }
}
