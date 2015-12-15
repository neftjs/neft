import SpriteKit

extension Renderer {
    class Screen: Renderer.BaseType {
        override init(app: GameViewController){
            super.init(app: app)
            
            // SCREEN_SIZE
            let mainScreen = UIScreen.mainScreen()
            let size = mainScreen.bounds
            renderer.pushAction(OutActions.SCREEN_SIZE)
            renderer.pushFloat(size.width)
            renderer.pushFloat(size.height)
        }
    }
}
