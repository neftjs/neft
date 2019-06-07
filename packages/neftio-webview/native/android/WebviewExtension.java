package io.neft.extensions.webview_extension;

import io.neft.renderer.NativeItem;

public final class WebviewExtension {
    public static void register() {
        NativeItem.registerItem(WebViewItem.class);
    }
}
