import JavaScriptCore

extension Extension.Request {
    static let app = App.getApp()

    static func register() {
        app.client.addCustomFunction("NeftRequest/request") {
            (args: [Any?]) in
            let uid = args[0] as? String ?? ""
            let uri = args[1] as? String ?? ""
            let method = args[2] as? String ?? ""
            let headersJson = args[3] as? String ?? "{}"
            let body = args[4] as? String ?? ""
            let timeout = (args[5] as? Number)?.int() ?? 0

            let headers: [String: String] = (try? JSONDecoder().decode([String: String].self, from: headersJson.data(using: String.Encoding.utf8)!)) ?? [:]


            request(uri, method, headers, body, timeout) {
                (error: String, code: Int, data: String, headers: [String: String]) in
                let headersData = try? JSONEncoder().encode(headers)
                let headersJson = headersData == nil ? "{}" : String(data: headersData!, encoding: .utf8)
                app.client.pushEvent("NeftRequest/response", args: [uid, error, code, data, headersJson] as [Any?]?)
            }
        }
    }

    static func request(_ uri: String, _ method: String, _ headers: [String: String], _ body: String, _ timeout: Int, _ completion: @escaping (_ error: String, _ code: Int, _ data: String, _ headers: [String: String]) -> Void) {
        var req = URLRequest(url: URL(string: uri)!)
        let session = URLSession.shared
        req.timeoutInterval = Double(timeout) / 1000
        req.httpMethod = method.lowercased()

        for (name, val) in headers {
            req.setValue(val, forHTTPHeaderField: name)
        }

        if method.lowercased() != "get" {
            req.httpBody = body.data(using: String.Encoding.utf8)
        }

        let task = session.dataTask(with: req, completionHandler: {
            (data, response, error) in
            let httpResponse = response as? HTTPURLResponse
            let errMsg = error != nil ? String(describing: error) : ""
            let status = httpResponse != nil ? httpResponse!.statusCode : 0
            let headers = httpResponse?.allHeaderFields as? [String: String]
            let httpData = data != nil ? NSString(data: data!, encoding: String.Encoding.utf8.rawValue)! : ""
            let httpHeaders: [String: String] = headers != nil ? headers! : [:]
            completion(errMsg, status, httpData as String, httpHeaders)
        })

        task.resume()
    }
}
