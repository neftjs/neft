import JavaScriptCore

fileprivate let binding = NativeBinding("Storage")

extension Extension.Storage {
    static let app = App.getApp()

    static func register() {
        binding
            .onCall("get") { (args: [Any?]) in
                let uid = args[0] as? String ?? ""
                let key = args[1] as? String ?? ""
                resolve(uid, key) {
                    (url: URL) throws in
                    return try String(contentsOf: url)
                }
            }
            .onCall("set") { (args: [Any?]) in
                let uid = args[0] as? String ?? ""
                let key = args[1] as? String ?? ""
                let value = args[2] as? String ?? ""
                resolve(uid, key) {
                    (url: URL) throws in
                    try value.write(to: url, atomically: true, encoding: .utf8)
                    return nil
                }
            }
            .onCall("remove") { (args: [Any?]) in
                let uid = args[0] as? String ?? ""
                let key = args[1] as? String ?? ""
                resolve(uid, key) {
                    (url: URL) throws in
                    try FileManager.default.removeItem(at: url)
                    return nil
                }
            }
            .finalize()
    }

    private static func resolve(_ id: String, _ path: String, _ completion: @escaping (URL) throws -> String?) {
        var responseArgs: [Any?]? = nil
        thread({
            let dir = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            var result: String? = nil
            do {
                result = try completion(dir!.appendingPathComponent("neft_storage_" + path))
            } catch {
                responseArgs = [id, error.localizedDescription, nil]
                return
            }
            responseArgs = [id, nil, result]
        }) {
            binding.pushEvent("response", args: responseArgs)
        }
    }
}
