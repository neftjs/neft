import SpriteKit

class GameScene: SKScene {
    var app: GameViewController?
    private var ready = false
    
    private func pushPointerEvent(action: Renderer.OutActions, _ touches: Set<UITouch>) {
        if let touch = touches.first {
            let location = touch.locationInNode(self)
            let renderer = app?.renderer
            renderer!.pushAction(action)
            renderer!.pushFloat(location.x)
            renderer!.pushFloat(-location.y)
            renderer!.sendData()
            renderer!.callAnimationFrame()
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pushPointerEvent(Renderer.OutActions.POINTER_PRESS, touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pushPointerEvent(Renderer.OutActions.POINTER_MOVE, touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        pushPointerEvent(Renderer.OutActions.POINTER_RELEASE, touches)
    }
   
    override func update(currentTime: CFTimeInterval) {
        if !ready {
            app?.renderer?.load()
            ready = true
        }
        app?.renderer!.callAnimationFrame()
    }
}
