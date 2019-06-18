package io.neft.extensions.gesturerecognizer_extension;

import io.neft.renderer.NativeItem;

public final class GestureRecognizerExtension {
    public static void register() {
        NativeItem.registerItem(GestureRecognizerItem.class);
    }
}
