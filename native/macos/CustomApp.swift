import Cocoa

class CustomApp {
    init() {
        let app = App.getApp()
        app.client.addCustomFunction("testRequestEventName") {
            (args: [Any?]) in
            let bool = args[0] as! Bool
            let float = args[1] as! CGFloat
            let string = args[2] as! String
            app.client.pushEvent("testResponseEventName", args: [
                !bool, float * 2, string.uppercased(), args[3]
            ])
        }
    }
}
