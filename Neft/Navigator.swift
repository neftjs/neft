import SpriteKit

extension Renderer {
    class Navigator: Renderer.BaseType {
        override init(app: GameViewController){
            super.init(app: app)
            
            // NAVIGATOR_LANGUAGE
            renderer.pushAction(OutActions.NAVIGATOR_LANGUAGE)
            renderer.pushString(NSLocale.preferredLanguages()[0])
            
            // NAVIGATOR_ONLINE
            // TODO
        }
    }
}
