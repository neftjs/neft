import UIKit

class NeftApplication: UIApplication {
    
    var renderer: Renderer?
    
    func sendFakeEvent(event: UIEvent) {
        super.sendEvent(event)
    }
    
    override func sendEvent(event: UIEvent) {
        super.sendEvent(event)
        renderer?.device.onEvent(event)
    }
    
}

