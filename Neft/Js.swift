import WebKit

class Js: NSObject, WKScriptMessageHandler {
    let webView: WKWebView
    
    private var handlers: Dictionary<String, (message: AnyObject) -> ()> = [:]
    
    var lastRequestId = 0
    var pendingRequests: Dictionary<Int, (message: AnyObject) -> Void> = [:]
    
    init(name: String = ""){
        let contentController = WKUserContentController();
        let config = WKWebViewConfiguration()
        config.userContentController = contentController
        
        webView = WKWebView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), configuration: config)
        webView.hidden = true
        
        super.init();
        
        // change name for debugging
        let url = NSURL(string: "about:" + name)
        let req = NSURLRequest(URL: url!)
        webView.loadRequest(req)
        
        contentController.addScriptMessageHandler(self, name: "response")
        
        self.runScript("js")
    }
    
    func runScript(filename: String) {
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: "js")
        do {
            let file = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            webView.evaluateJavaScript(file as String, completionHandler: nil)
        } catch let error as NSError {
            print(error);
        }
    }
    
    func runCode(code: String) {
        webView.evaluateJavaScript(code, completionHandler: nil)
    }
    
    func userContentController(userContentController: WKUserContentController, didReceiveScriptMessage message: WKScriptMessage) {
        switch message.name {
        case "response":
            let id = message.body.objectForKey("id") as! Int
            let request = pendingRequests[id]
            if request != nil {
                pendingRequests.removeValueForKey(id)
                request!(message: message.body.objectForKey("response")!)
            } else {
                print("Response has no handler; id '\(id)'")
            }
        default:
            let handler = handlers[message.name]
            if handler != nil {
                handler!(message: message.body)
            } else {
                print("Undefined Js event comes \(message.name)")
            }
        }
    }
    
    func addHandler(name: String, handler: (message: AnyObject) -> Void) {
        handlers[name] = handler
        webView.configuration.userContentController.addScriptMessageHandler(self, name: name)
    }
    
    func callFunction(name: String, argv: String = "", completion: ((message: AnyObject) -> Void)? = nil) {
        var code = name + "(" + argv
        if completion != nil {
            let id = self.lastRequestId++
            pendingRequests[id] = completion
            if !argv.isEmpty {
                code += ", "
            }
            code += "_createOnCompletion(\(id))"
        }
        code += ")"
        
        webView.evaluateJavaScript(code, completionHandler: nil)
    }
}
