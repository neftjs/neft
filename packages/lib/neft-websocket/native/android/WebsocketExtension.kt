package io.neft.extensions.websocket_extension

import io.neft.client.NativeBinding

object WebsocketExtension {
    private val BINDING = NativeBinding("Websocket")
    private val sockets = mutableMapOf<String, WsClient>()

    @JvmStatic
    fun register() {
        BINDING
                .onCall("connect") { args ->
                    val uid = args[0] as String
                    val url = args[1] as String
                    val socket = WsClient(uid, url)
                    sockets[uid] = socket
                }
                .onCall("send") { args ->
                    val uid = args[0] as String
                    val data = args[1] as String
                    val socket = sockets[uid]
                    socket?.send(data)
                }
                .onCall("close") { args ->
                    val uid = args[0] as String
                    val code = (args[1] as Number).toInt()
                    val reason = args[2] as String
                    val socket = sockets[uid]
                    socket?.close(code, reason)
                }
    }

    fun emitOpen(uid: String) {
        BINDING.pushEvent("open", uid)
    }

    fun emitMessage(uid: String, data: String) {
        BINDING.pushEvent("message", uid, data)
    }

    fun emitError(uid: String, message: String) {
        BINDING.pushEvent("error", uid, message)
    }

    fun emitClose(uid: String, code: Int, reason: String) {
        BINDING.pushEvent("close", uid, code, reason)
        sockets.remove(uid)
    }
}
