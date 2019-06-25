import Starscream

fileprivate let binding = NativeBinding("Websocket")
fileprivate var sockets: Dictionary<String, WsDelegate> = [:]

fileprivate class WsDelegate: WebSocketDelegate {
    let uid: String
    var ws: WebSocket?

    init(_ uid: String, _ ws: WebSocket) {
        self.uid = uid
        self.ws = ws
    }

    func websocketDidConnect(socket: WebSocketClient) {
        emitOpen()
    }

    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        let wsError = error as? WSError
        if error != nil {
            emitError(message: wsError?.message ?? error!.localizedDescription)
        }
        emitClose(code: wsError?.code ?? Int(CloseCode.normal.rawValue), reason: "")
    }

    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        emitMessage(data: text)
    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        // NOP
    }

    func emitOpen() {
        binding.pushEvent("open", args: [self.uid])
    }

    func emitMessage(data: String) {
        binding.pushEvent("message", args: [self.uid, data])
    }

    func emitError(message: String) {
        binding.pushEvent("error", args: [self.uid, message])
    }

    func emitClose(code: Int, reason: String) {
        binding.pushEvent("close", args: [self.uid, code, reason])
        sockets.removeValue(forKey: self.uid)
    }
}

extension Extension.Websocket {
    static let app = App.getApp()

    static func register() {
        binding
            .onCall("connect") { (args: [Any?]) in
                let uid = args[0] as! String
                let url = args[1] as! String

                let ws = WebSocket(url: URL(string: url)!)
                let delegate = WsDelegate(uid, ws)
                ws.delegate = delegate
                ws.connect()
                sockets[uid] = delegate
            }
            .onCall("send") { (args: [Any?]) in
                let uid = args[0] as! String
                let data = args[1] as! String
                guard let socket = sockets[uid] else { return }
                socket.ws?.write(string: data)
            }
            .onCall("close") { (args: [Any?]) in
                let uid = args[0] as! String
                let code = (args[1] as? Number)?.int()
                guard let socket = sockets[uid] else { return }
                let closeCode = code != nil ? UInt16(code!) : CloseCode.normal.rawValue
                socket.ws?.disconnect(forceTimeout: 10, closeCode: closeCode)
            }
            .finalize()
    }
}
