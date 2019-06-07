import Cocoa

extension Extension.Request {
    private static let app = App.getApp()
    private static let onRequestFunc = "NeftRequest/request"
    private static let responseEvent = "NeftRequest/response"

    static func register() {
        app.client.addCustomFunction(onRequestFunc) { (args: [Any?]) in
            let uid = args[0] as? String ?? ""
            request(
                uid: uid,
                uri: args[1] as? String ?? "",
                method: args[2] as? String ?? "",
                headers: decodeHeaders(args[3] as? String ?? "{}"),
                body: args[4] as? String ?? "",
                timeout: args[5] as? Number ?? Number(0)
            ) { (error: String, statusCode: Int, body: String, headers: [String: String]) in
                app.client.pushEvent(responseEvent, args: [uid, error, statusCode, body, serializeHeaders(headers)])
            }
        }
    }

    static private func decodeHeaders(_ json: String) -> [String: String] {
        let decoder = JSONDecoder()
        do {
            let data = json.data(using: String.Encoding.utf8)!
            return try decoder.decode([String: String].self, from: data)
        } catch {
            return [String: String]()
        }
    }

    static private func serializeHeaders(_ headers: [String: String]) -> String {
        do {
            let data = try JSONSerialization.data(withJSONObject: headers)
            return String(data: data, encoding: .ascii)!
        } catch {
            return "{}"
        }
    }

    static private func request(
        uid: String,
        uri: String,
        method: String,
        headers: [String: String],
        body: String,
        timeout: Number,
        completion: @escaping (_ error: String, _ statusCode: Int, _ body: String, _ headers: [String: String]) -> Void
    ) {
        var req = URLRequest(url: URL(string: uri)!)
        let session = URLSession.shared
        req.timeoutInterval = TimeInterval(timeout.int() / 1000)

        // method
        req.httpMethod = method

        // headers
        for (name, val) in headers {
            req.setValue(val, forHTTPHeaderField: name)
        }

        // body
        if !body.isEmpty {
            req.httpBody = body.data(using: String.Encoding.utf8)
        }

        let task = session.dataTask(with: req, completionHandler: { (data, response, error) in
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
