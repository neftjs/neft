import SpriteKit

extension Renderer {
    class Device: Renderer.BaseType {
        override init(app: GameViewController){
            super.init(app: app)
            
            // DEVICE_PIXEL_RATIO
            let pixelRatio = UIScreen.mainScreen().scale
            renderer.pushAction(OutActions.DEVICE_PIXEL_RATIO)
            renderer.pushFloat(pixelRatio)
            
            // DEVICE_IS_PHONE
            let isPhone = UIDevice.currentDevice().userInterfaceIdiom == .Phone
            renderer.pushAction(OutActions.DEVICE_IS_PHONE)
            renderer.pushBoolean(isPhone)
        }
    }
}
