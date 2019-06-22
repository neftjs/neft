fileprivate let app = App.getApp()
fileprivate let binding = NativeBinding("DeepLinking")

extension Extension.DeepLinking {
    static func register() {
        binding
            .onCall("getOpenUrl") { (args: [Any?]) in
                pushOpenUrlChange()
            }
            .finalize()

        app.onOpenUrlChange.connect { _ in pushOpenUrlChange() }
    }

    private static func pushOpenUrlChange() {
        binding.pushEvent("openUrlChange", args: [app.openUrl])
    }
}
