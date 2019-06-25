package io.neft.extensions.websocket_extension

import com.neovisionaries.ws.client.*

val factory = WebSocketFactory()

class WsClient(
        val uid: String,
        val url: String,
        val ws: WebSocket = factory.createSocket(url)
) {
    init {
        ws.addListener(object: WebSocketAdapter() {
            override fun onConnected(websocket: WebSocket?, headers: MutableMap<String, MutableList<String>>?) {
                WebsocketExtension.emitOpen(uid)
            }

            override fun onDisconnected(websocket: WebSocket?, serverCloseFrame: WebSocketFrame?, clientCloseFrame: WebSocketFrame?, closedByServer: Boolean) {
                WebsocketExtension.emitClose(uid,
                        code = serverCloseFrame?.closeCode ?: 0,
                        reason = serverCloseFrame?.payloadText ?: "")
            }

            override fun onError(websocket: WebSocket?, cause: WebSocketException?) {
                WebsocketExtension.emitError(uid, cause?.message ?: "")
            }

            override fun onTextMessage(ws: WebSocket, message: String) {
                WebsocketExtension.emitMessage(uid, message)
            }
        })

        ws.connectAsynchronously()
    }

    fun send(data: String) {
        ws.sendText(data)
    }

    fun close(code: Int, reason: String) {
        ws.sendClose(code, reason)
    }
}
