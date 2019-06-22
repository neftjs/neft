package io.neft.extensions.backpress_extension

import io.neft.App
import io.neft.client.NativeBinding

object BackPressExtension {
    private val APP = App.getInstance()
    private val BINDING = NativeBinding("BackPress")

    @JvmStatic
    fun register() {
        BINDING
                .onCall("killApp") {
                    APP.activity.finish()
                }

        APP.onBackPress.connect { BINDING.pushEvent("backPress") }
    }
}
