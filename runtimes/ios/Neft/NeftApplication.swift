import UIKit

class NeftApplication: UIApplication {
    
    var renderer: Renderer?
    
    func sendFakeEvent(_ event: UIEvent) {
        super.sendEvent(event)
    }
    
    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        renderer?.device.onEvent(event)
    }
    
}

