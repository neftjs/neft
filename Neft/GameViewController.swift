import UIKit

public extension CGFloat {
    /**
     Returns a random floating point number between 0.0 and 1.0, inclusive.
     */
    public static func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
}

class GameViewController: UIViewController {
    let client = Client()
    let renderer = Renderer()
    var window: Window!
    var customApp: CustomApp!
    
    class Window: UIView {
        var app: GameViewController!
        var windowItem: Item?
        let background = CAShapeLayer()
        
        override func didMoveToSuperview() {
            background.fillColor = UIColor.whiteColor().CGColor
            background.path = CGPathCreateWithRect(CGRect(x: 0, y: 0, width: frame.width, height: frame.height), nil)
        }
        
        override func drawRect(rect: CGRect) {
            let context = UIGraphicsGetCurrentContext()!
            background.renderInContext(context)
            windowItem?.draw(context, inRect: rect)
            
            // DEBUG dirty rectangles
//            CGContextSetRGBFillColor(context, CGFloat.random(), CGFloat.random(), CGFloat.random(), 0.3);
//            CGContextFillRect(context, rect);
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.customApp = CustomApp(app: self)
        
        renderer.app = self
        
        view.addSubview(self.client.js.webView)
        (UIApplication.sharedApplication() as! NeftApplication).renderer = renderer
        
        client.actions[InAction.SET_WINDOW] = {
            (reader: Reader) in
            self.window.windowItem = self.renderer.getObjectFromReader(reader) as? Item
            self.window.setNeedsDisplay()
        }
        
        self.window = Window(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.window.app = self
        self.view.addSubview(self.window)
        
        self.renderer.load()
        self.client.js.runScript("neft")
    }

    override func shouldAutorotate() -> Bool {
        return false
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func prefersStatusBarHidden() -> Bool {
        return false
    }
}
