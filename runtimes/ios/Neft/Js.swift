import JavaScriptCore

/**
 Protocol for a internal object exported to the JavaScript.
*/
@objc protocol NeftJSExports: JSExport {
    var timerCallback: JSValue? { get set }
    var animationFrameCallback: JSValue? { get set }
    var dataCallback: JSValue? { get set }
    func postMessage(_ name: String, _ data: NSDictionary) -> Void
    func timerShot(_ delay: Int64) -> Int
    func immediate(_ function: JSValue) -> Void
    var httpResponseCallback: JSValue? { get set }
    func httpRequest(_ uri: String, _ method: String, _ headers: NSArray, _ data: JSValue) -> Int
}

/**
 Class used as a internal object exported to the JavaScirpt.
*/
@objc class NeftJS: NSObject, NeftJSExports {
    weak var js: JS!
    private var lastTimerId = 0

    private var timerCallbackValue: JSValue?
    var timerCallback: JSValue? {
        get {
            return timerCallbackValue
        }
        set (val) {
            timerCallbackValue = val
        }
    }

    private var animationFrameCallbackValue: JSValue?
    var animationFrameCallback: JSValue? {
        get {
            return animationFrameCallbackValue
        }
        set (val) {
            animationFrameCallbackValue = val
        }
    }

    private var dataCallbackValue: JSValue?
    var dataCallback: JSValue? {
        get {
            return dataCallbackValue
        }
        set (val) {
            dataCallbackValue = val
        }
    }

    private var httpResponseCallbackValue: JSValue?
    var httpResponseCallback: JSValue? {
        get {
            return httpResponseCallbackValue
        }
        set (val) {
            httpResponseCallbackValue = val;
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
        guard timerCallbackValue != nil else { return -1 }

        let id = lastTimerId
        lastTimerId += 1

        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(Int(delay))) {
            guard self.js != nil else { return }
            self.js.queue.async {
                guard self.timerCallbackValue != nil else { return }
                self.timerCallbackValue!.call(withArguments: [id])
            }
        }

        return id
    }

    func immediate(_ function: JSValue) {
        js.queue.async {
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

        return Networking.request(uri, method: method, headers: headers, data: data) {
            (args: [Any]) -> Void in
            guard self.js != nil else { return }
            self.js.queue.async {
                guard self.httpResponseCallback != nil else { return }
                self.httpResponseCallback!.call(withArguments: args)
            }
        }
    }

    func destroy() {
        timerCallbackValue = nil
        animationFrameCallbackValue = nil
        dataCallbackValue = nil
        httpResponseCallbackValue = nil
    }
}

/**
 Creates new JavaScript context and communicate with it.
*/
class JS {
    let context: JSContext
    let proxy: NeftJS

    fileprivate var handlers: Dictionary<String, (_ message: AnyObject) -> ()> = [:]

    var queue = DispatchQueue(label: "io.neft", target: DispatchQueue.main)
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
            runCode(file as String)
        } catch let error as NSError {
            print(error);
        }
    }

    func runCode(_ code: String) {
        queue.async {
            self.context.evaluateScript(code)
        }
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

        queue.async {
            self.context.evaluateScript(code)
        }
    }

    func callAnimationFrame() {
        let callback = proxy.animationFrameCallback
        guard callback != nil else { return }
        queue.async {
            callback!.call(withArguments: [])
        }
    }

    func destroy() {
        self.handlers.removeAll()
        proxy.destroy()
    }
}
