import JavaScriptCore

/**
 Protocol for a internal object exported to the JavaScript.
*/
@objc protocol NeftJSExports: JSExport {
    var timerCallback: JSValue { get set }
    var animationFrameCallback: JSValue { get set }
    var dataCallback: JSValue { get set }
    func postMessage(name: String, _ data: NSDictionary) -> Void
    func timerShot(delay: Int64) -> Int
    func immediate(function: JSValue) -> Void
    var httpResponseCallback: JSValue { get set }
    func httpRequest(uri: String, _ method: String, _ headers: NSArray, _ data: JSValue) -> Int
}

/**
 Class used as a internal object exported to the JavaScirpt.
*/
@objc class NeftJS: NSObject, NeftJSExports {
    var js: JS!
    private var lastTimerId = 0

    private var timerCallbackValue: JSValue!
    var timerCallback: JSValue {
        get {
            return timerCallbackValue
        }
        set (val) {
            timerCallbackValue = val
        }
    }

    private var animationFrameCallbackValue: JSValue!
    var animationFrameCallback: JSValue {
        get {
            return animationFrameCallbackValue
        }
        set (val) {
            animationFrameCallbackValue = val
        }
    }

    private var dataCallbackValue: JSValue!
    var dataCallback: JSValue {
        get {
            return dataCallbackValue
        }
        set (val) {
            dataCallbackValue = val
        }
    }

    var httpResponseCallback: JSValue {
        get {
            return Networking.responseCallback
        }
        set (val) {
            Networking.responseCallback = val;
        }
    }

    func postMessage(name: String, _ data: NSDictionary) {
        switch name {
        case "response":
            let id = data.objectForKey("id") as! Int
            let request = js.pendingRequests[id]
            if request != nil {
                js.pendingRequests.removeValueForKey(id)
                request!(message: data.objectForKey("response")!)
            } else {
                print("Response has no handler; id '\(id)'")
            }
        default:
            let handler = js.handlers[name]
            if handler != nil {
                handler!(message: data)
            } else {
                print("Undefined JavaScript event comes \(name)")
            }
        }
    }

    func timerShot(delay: Int64) -> Int {
        let id = lastTimerId
        lastTimerId += 1

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay), dispatch_get_main_queue()) {
            self.timerCallbackValue.callWithArguments([id])
        }

        return id
    }

    func immediate(function: JSValue) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0), dispatch_get_main_queue()) {
            function.callWithArguments(nil)
        }
    }

    func httpRequest(uri: String, _ method: String, _ headersArr: NSArray, _ data: JSValue) -> Int {
        var headers = [String: String]()
        for i in (0..<headersArr.count) where i % 2 == 0 {
            let name = String(headersArr[i])
            let val = String(headersArr[i+1])
            headers[name] = val
        }

        return Networking.request(uri, method: method, headers: headers, data: data)
    }
}

/**
 Creates new JavaScript context and communicate with it.
*/
class JS {
    let context: JSContext
    let proxy: NeftJS

    private var handlers: Dictionary<String, (message: AnyObject) -> ()> = [:]

    var lastRequestId = 0
    var pendingRequests: Dictionary<Int, (message: AnyObject) -> Void> = [:]

    init(){
        context = JSContext()
        proxy = NeftJS()
        proxy.js = self
        context.setObject(proxy, forKeyedSubscript: "ios")
        self.runScript("js")
    }

    func runScript(filename: String) {
        let path = NSBundle.mainBundle().pathForResource(filename, ofType: "js")
        do {
            let file = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            context.evaluateScript(file as String)
        } catch let error as NSError {
            print(error);
        }
    }

    func runCode(code: String) {
        context.evaluateScript(code)
    }

    func addHandler(name: String, handler: (message: AnyObject) -> Void) {
        handlers[name] = handler
    }

    func callFunction(name: String, argv: String = "", completion: ((message: AnyObject) -> Void)? = nil) {
        var code = name + "(" + argv
        if completion != nil {
            let id = self.lastRequestId
            self.lastRequestId += 1
            pendingRequests[id] = completion
            if !argv.isEmpty {
                code += ", "
            }
            code += "_createOnCompletion(\(id))"
        }
        code += ")"

        context.evaluateScript(code)
    }

    func callAnimationFrame() {
        proxy.animationFrameCallback.callWithArguments([])
    }
}
