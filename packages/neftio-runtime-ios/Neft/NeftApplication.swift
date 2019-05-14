import UIKit

class NeftApplication: UIApplication {

    var renderer: Renderer?

    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)
        renderer?.device.onEvent(event)
    }

}

