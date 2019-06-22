package io.neft.extensions.deeplinking_extension

import io.neft.App
import io.neft.client.NativeBinding

object DeepLinkingExtension {
    private val APP = App.getInstance()
    private val BINDING = NativeBinding("DeepLinking")

    @JvmStatic
    fun register() {
        BINDING
                .onCall("getOpenUrl") {
                    pushOpenUrlChange()
                }

        APP.onIntentDataChange.connect { pushOpenUrlChange() }
    }

    private fun pushOpenUrlChange() {
        BINDING.pushEvent("openUrlChange", APP.intentData)
    }
}
