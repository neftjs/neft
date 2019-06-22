package io.neft.extensions.activelink_extension

import android.content.ActivityNotFoundException
import android.content.Intent
import android.net.Uri
import android.util.Log

import io.neft.App
import io.neft.client.NativeBinding

object ActiveLinkExtension {
    private val APP = App.getInstance()
    private val BINDING = NativeBinding("ActiveLink")

    @JvmStatic
    fun register() {
        BINDING
                .onCall("web") { args: Array<Any> ->
                    web(args[0] as String)
                }
                .onCall("mailto") { args: Array<Any> ->
                    mailto(args[0] as String)
                }
                .onCall("tel") { args: Array<Any> ->
                    tel(args[0] as String)
                }
                .onCall("geo") { args: Array<Any> ->
                    geo(
                            latitude = (args[0] as Number).toFloat(),
                            longitude = (args[1] as Number).toFloat(),
                            address = args[2] as String
                    )
                }
    }

    fun web(url: String) {
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
        try {
            APP.activity.startActivity(intent)
        } catch (error: ActivityNotFoundException) {
            Log.e(App.TAG, "Cannot web in ActiveLink extension", error)
        }
    }

    fun mailto(address: String) {
        val intent = Intent(Intent.ACTION_SENDTO)
        intent.data = Uri.parse("mailto:$address")
        try {
            APP.activity.startActivity(intent)
        } catch (error: ActivityNotFoundException) {
            Log.e(App.TAG, "Cannot mailto in ActiveLink extension", error)
        }
    }

    fun tel(number: String) {
        val intent = Intent(Intent.ACTION_DIAL)
        intent.data = Uri.parse("tel:$number")
        try {
            APP.activity.startActivity(intent)
        } catch (error: ActivityNotFoundException) {
            Log.e(App.TAG, "Cannot tel in ActiveLink extension", error)
        }
    }

    fun geo(latitude: Float?, longitude: Float?, address: String) {
        val uri = "geo:$latitude,$longitude?q=$address"
        val intent = Intent(Intent.ACTION_VIEW, Uri.parse(uri))
        try {
            APP.activity.startActivity(intent)
        } catch (error: ActivityNotFoundException) {
            Log.e(App.TAG, "Cannot geo in ActiveLink extension", error)
        }
    }
}
