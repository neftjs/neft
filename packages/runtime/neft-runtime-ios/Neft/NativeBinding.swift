import Foundation

class NativeBinding {
    var module: String

    init(_ module: String) {
        self.module = module
    }

    private func getFullName(_ name: String) -> String {
        return "\(module)/\(name)"
    }

    func onCall(_ name: String, _ handler: @escaping ([Any?]) -> Void) -> NativeBinding {
        App.getApp().client.addCustomFunction(getFullName(name), function: handler)
        return self
    }

    func pushEvent(_ name: String, args: [Any?]?) {
        App.getApp().client?.pushEvent(getFullName(name), args: args)
    }

    func finalize() {}
}
