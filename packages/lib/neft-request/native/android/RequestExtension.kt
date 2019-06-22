package io.neft.extensions.request_extension

import org.json.JSONException
import org.json.JSONObject

import io.neft.client.NativeBinding

object RequestExtension {
    private val BINDING = NativeBinding("Request")

    @JvmStatic
    fun register() {
        BINDING
                .onCall("request") { args: Array<Any> ->
                    val uid = args[0] as String
                    val uri = args[1] as String
                    val method = args[2] as String
                    var headers: JSONObject? = null
                    try {
                        headers = JSONObject(args[3] as String)
                    } catch (e: JSONException) {
                        // NOP
                    }

                    val body = args[4] as String
                    val timeout = (args[5] as Number).toInt()
                    HttpRequest(uid, uri, method, headers, body, timeout).resolveAsync { response ->
                        BINDING.pushEvent("response", uid, response.error, response.code, response.data, response.headers)
                    }
                }
    }
}
