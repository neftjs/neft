import UIKit

class Db {
    static let RESPONSE = "__neftDbResponse"
    static func register() {
        let client = App.getApp().client;

        client?.addCustomFunction("__neftDbGet") {
            (args: [Any?]) in
            let key = args[0] as! String
            let id = args[1] as! CGFloat
            resolve(key, id) {
                (url: URL) throws in
                return try String(contentsOf: url)
            }
        }

        client?.addCustomFunction("__neftDbSet") {
            (args: [Any?]) in
            let key = args[0] as! String
            let value = args[1] as! String
            let id = args[2] as! CGFloat
            resolve(key, id) {
                (url: URL) throws in
                try value.write(to: url, atomically: true, encoding: .utf8)
                return nil
            }
        }

        client?.addCustomFunction("__neftDbRemove") {
            (args: [Any?]) in
            let key = args[0] as! String
            let id = args[1] as! CGFloat
            resolve(key, id) {
                (url: URL) throws in
                try FileManager.default.removeItem(at: url)
                return nil
            }
        }
    }
    private static func resolve(_ path: String, _ id: CGFloat, _ completion: @escaping (URL) throws -> String?) {
        thread {
            let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            let client = App.getApp().client
            var result: String? = nil
            do {
                result = try completion(dir!.appendingPathComponent("__neftDb_" + path))
            } catch {
                client?.pushEvent(RESPONSE, args: [id, error.localizedDescription, nil])
                return
            }
            client?.pushEvent(RESPONSE, args: [id, nil, result])
        }
    }
}