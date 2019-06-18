fileprivate let app = App.getApp()

extension Extension.DeepLinking {
    static func register() {
        app.client.addCustomFunction("NeftDeepLinking/getOpenUrl") {
            (args: [Any?]) in
            pushOpenUrlChange()
        }

        app.onOpenUrlChange.connect { _ in pushOpenUrlChange() }
    }

    fileprivate static func pushOpenUrlChange() {
        app.client.pushEvent("NeftDeepLinking/openUrlChange", args: [app.openUrl])
    }
}
