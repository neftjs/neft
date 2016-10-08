import JavaScriptCore

/**
 Protocol for a internal object exported to the JavaScript.
*/
@objc protocol NeftJSExports: JSExport {
    var timerCallback: JSValue { get set }
    var animationFrameCallback: JSValue { get set }
    var dataCallback: JSValue { get set }
    func postMessage(_ name: String, _ data: NSDictionary) -> Void
    func timerShot(_ delay: Int64) -> Int
    func immediate(_ function: JSValue) -> Void
    var httpResponseCallback: JSValue { get set }
    func httpRequest(_ uri: String, _ method: String, _ headers: NSArray, _ data: JSValue) -> Int
}

/**
 Class used as a internal object exported to the JavaScirpt.
*/
@objc class NeftJS: NSObject, NeftJSExports {
    var js: JS!
    fileprivate var lastTimerId = 0

    fileprivate var timerCallbackValue: JSValue!
    var timerCallback: JSValue {
        get {
            return timerCallbackValue
        }
        set (val) {
            timerCallbackValue = val
        }
    }

    fileprivate var animationFrameCallbackValue: JSValue!
    var animationFrameCallback: JSValue {
        get {
            return animationFrameCallbackValue
        }
        set (val) {
            animationFrameCallbackValue = val
        }
    }

    fileprivate var dataCallbackValue: JSValue!
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

    func postMessage(_ name: String, _ data: NSDictionary) {
        switch name {
        case "response":
            let id = data.object(forKey: "id") as! Int
            let request = js.pendingRequests[id]
            if request != nil {
                js.pendingRequests.removeValue(forKey: id)
                request!(data.object(forKey: "response")! as AnyObject)
            } else {
                print("Response has no handler; id '\(id)'")
            }
        default:
            let handler = js.handlers[name]
            if handler != nil {
                handler!(data)
            } else {
                print("Undefined JavaScript event comes \(name)")
            }
        }
    }

    func timerShot(_ delay: Int64) -> Int {
        let id = lastTimerId
        lastTimerId += 1

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)) {
            self.timerCallbackValue.call(withArguments: [id])
        }

        return id
    }

    func immediate(_ function: JSValue) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(0) / Double(NSEC_PER_SEC)) {
            function.call(withArguments: nil)
        }
    }

    func httpRequest(_ uri: String, _ method: String, _ headersArr: NSArray, _ data: JSValue) -> Int {
        var headers = [String: String]()
        for i in (0..<headersArr.count) where i % 2 == 0 {
            let name = String(describing: headersArr[i])
            let val = String(describing: headersArr[i+1])
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

    fileprivate var handlers: Dictionary<String, (_ message: AnyObject) -> ()> = [:]

    var lastRequestId = 0
    var pendingRequests: Dictionary<Int, (_ message: AnyObject) -> Void> = [:]

    init(){
        context = JSContext()
        proxy = NeftJS()
        proxy.js = self
        context.setObject(proxy, forKeyedSubscript: "ios" as (NSCopying & NSObjectProtocol)!)
        self.runScript("js")
    }

    func runScript(_ filename: String) {
        let path = Bundle.main.path(forResource: filename, ofType: "js")
        do {
            let file = try NSString(contentsOfFile: path!, encoding: String.Encoding.utf8.rawValue)
            context.evaluateScript(file as String)
        } catch let error as NSError {
            print(error);
        }
    }

    func runCode(_ code: String) {
        context.evaluateScript(code)
    }

    func addHandler(_ name: String, handler: @escaping (_ message: AnyObject) -> Void) {
        handlers[name] = handler
    }

    func callFunction(_ name: String, argv: String = "", completion: ((_ message: AnyObject) -> Void)? = nil) {
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
        proxy.animationFrameCallback.call(withArguments: [])
    }
}
