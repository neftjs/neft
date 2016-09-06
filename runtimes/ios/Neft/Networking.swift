import JavaScriptCore

class Networking {
    internal static var lastId: Int = 0

    // args: id, error, code, resp, headers
    static var responseCallback: JSValue!
    static func request(uri: String, method: String, headers: [String: String], data: JSValue) -> Int {
        let id = self.lastId
        self.lastId += 1

        let req = NSMutableURLRequest()
        let session = NSURLSession.sharedSession()
        req.timeoutInterval = 0

        // url
        req.URL = NSURL(string: uri)

        // method
        req.HTTPMethod = method

        // headers
        for (name, val) in headers {
            req.setValue(val, forHTTPHeaderField: name)
        }

        // body
        if method != "get" {
            req.HTTPBody = data.toString().dataUsingEncoding(NSUTF8StringEncoding)
        }

        let task = session.dataTaskWithRequest(req) {
            (data, response, error) in
            let httpResponse = response as? NSHTTPURLResponse
            let errMsg = error != nil ? String(error) : ""
            let status = httpResponse != nil ? httpResponse!.statusCode : 0
            let headers = httpResponse?.allHeaderFields as? [String: String]
            let httpData = data != nil ? NSString(data: data!, encoding: NSUTF8StringEncoding)! : ""
            let httpHeaders: [String: String] = headers != nil ? headers! : [:]
            responseCallback.callWithArguments([id, errMsg, status, httpData, httpHeaders])
        }

        task.resume()

        return id
    }
}
