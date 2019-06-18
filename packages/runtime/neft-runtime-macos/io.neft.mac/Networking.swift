import JavaScriptCore

class Networking {
    let script: Script

    init(script: Script) {
        self.script = script

        script.onNetworkingMessage = self.onMessage
    }

    func onMessage(body: NetworkingMessage) {
        self.request(uri: body.uri, method: body.method.lowercased(), headers: body.headers, data: body.data) {
            (error: String, status: Int, resp: String, headers: [String: String]) in
            let headersJson: String
            do {
                let data = try JSONSerialization.data(withJSONObject: headers)
                headersJson = String(data: data, encoding: .ascii)!
            } catch {
                headersJson = ""
            }
            self.script.runCode(
                "__macos__.networkingHandler(\(body.id), \(error.debugDescription), \(status), \(resp), \(headersJson.debugDescription))"
            )
        }
    }

    func request(uri: String, method: String, headers: [String: String], data: String?, completion: @escaping (_ error: String, _ status: Int, _ data: String, _ headers: [String: String]) -> Void) -> Void {
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
            req.httpBody = data?.data(using: String.Encoding.utf8)
        }

        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            let errMsg = error != nil ? String(describing: error) : ""
            let status = httpResponse != nil ? httpResponse!.statusCode : 0
            let headers = httpResponse?.allHeaderFields as? [String: String]
            let httpData = data != nil ? NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! : ""
            let httpHeaders: [String: String] = headers != nil ? headers! : [:]
            completion(errMsg as String, status, httpData as String, httpHeaders)
        })

        task.resume()
    }

}
