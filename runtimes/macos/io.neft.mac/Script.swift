import Cocoa
import WebKit

class Script: NSObject, WKScriptMessageHandler {
    let webView: WKWebView
    var onClientUpdateMessage: ((ClientUpdateMessage) -> Void)?
    var onNetworkingMessage: ((NetworkingMessage) -> Void)?
    private let config = WKWebViewConfiguration()
    private let contentController = WKUserContentController()

    override init() {
        config.userContentController = contentController

        self.webView = WKWebView(
            frame: CGRect(x: 0, y: 0, width: 0, height: 0),
            configuration: config
        )

        super.init()

        contentController.add(self, name: "log")
        contentController.add(self, name: "client")
        contentController.add(self, name: "networking")
    }

    func runCode(_ code: String, _ completion: (() -> Void)? = nil) {
        self.webView.evaluateJavaScript(code) { (result, error) in
            if error != nil {
                print(error.debugDescription)
            }
            completion?()
        }
    }

    func runScript(_ filename: String, _ completion: (() -> Void)? = nil) {
        let path = Bundle.main.path(forResource: filename, ofType: "js")
        do {
            let file = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
            runCode(file as String, completion)
        } catch let error as NSError {
            print(error)
        }
    }

    internal func userContentController(
        _ userContentController: WKUserContentController,
        didReceive message: WKScriptMessage
    ) {
        switch message.name {
        case "log":
            let data = message.body as? String
            if data != nil {
                NSLog("%@", data!)
            }
        case "client":
            let data = message.body as! [String: [Any]]
            self.onClientUpdateMessage?(
                ClientUpdateMessage(
                    actions: data["actions"] as! [Int],
                    booleans: data["booleans"] as! [Bool],
                    floats: data["floats"] as! [CGFloat],
                    integers: data["integers"] as! [Int],
                    strings: data["strings"] as! [String]
                )
            )
        case "networking":
            let data = message.body as! [String: Any]
            self.onNetworkingMessage?(
                NetworkingMessage(
                    id: data["id"] as! Int,
                    uri: data["uri"] as! String,
                    method: data["method"] as! String,
                    headers: data["headers"] as! [String: String],
                    data: data["data"] as! String?
                )
            )
        default:
            print("Unknown message received \(message.name)")
        }
    }

    func attach(_ view: NSView, debug: Bool = false) {
        if debug {
            webView.frame = NSScreen.main()!.frame
            webView.configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")
        }
        view.addSubview(webView)
    }

}
