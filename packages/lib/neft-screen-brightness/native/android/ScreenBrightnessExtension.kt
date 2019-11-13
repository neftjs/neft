package io.neft.extensions.screenbrightness_extension

import io.neft.App
import io.neft.client.NativeBinding

object ScreenBrightnessExtension {
    private val APP = App.getInstance()
    private val BINDING = NativeBinding("ScreenBrightness")

    @JvmStatic
    fun register() {
        BINDING
                .onCall("getBrightness") {
                    pushBrightness()
                }
                .onCall("setBrightness") {
                    value ->
                    setBrightness((value[0] as Number).toFloat())
                    pushBrightness()
                }
    }

    private fun pushBrightness() {
        BINDING.pushEvent("brightness", getBrightness())
    }

    fun getBrightness() : Float {
        return APP.activity.window.attributes.screenBrightness
    }

    fun setBrightness(value: Float) {
        val window = APP.activity.window
        val attributes = window.attributes
        attributes.screenBrightness = value
        window.attributes = attributes
    }
}
