package io.neft.extensions.scanner_extension

import io.neft.renderer.NativeItem

object ScannerExtension {
    @JvmStatic
    fun register() {
        NativeItem.registerItem(ScannerItem::class.java)
    }
}
