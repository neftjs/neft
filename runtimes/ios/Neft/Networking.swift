import JavaScriptCore

class Networking {
    internal static var lastId: Int = 0

    // args: id, error, code, resp, headers
    static var responseCallback: JSValue!
    static func request(_ uri: String, method: String, headers: [String: String], data: JSValue) -> Int {
        let id = self.lastId
        self.lastId += 1

        var req = URLRequest(url: URL(string: uri)!)
        let session = URLSession.shared
        req.timeoutInterval = 0

        // method
        req.httpMethod = method

        // headers
        for (name, val) in headers {
            req.setValue(val, forHTTPHeaderField: name)
        }

        // body
        if method != "get" {
            req.httpBody = data.toString().data(using: String.Encoding.utf8)
        }

        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            let errMsg = error != nil ? String(describing: error) : ""
            let status = httpResponse != nil ? httpResponse!.statusCode : 0
            let headers = httpResponse?.allHeaderFields as? [String: String]
            let httpData = data != nil ? NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! : ""
            let httpHeaders: [String: String] = headers != nil ? headers! : [:]
            responseCallback.call(withArguments: [id, errMsg, status, httpData, httpHeaders])
        })

        task.resume()

        return id
    }
}
