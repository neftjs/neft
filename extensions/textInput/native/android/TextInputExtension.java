package io.neft.extensions.textinput;

import io.neft.renderer.NativeItem;

public final class TextInputExtension {
    public static void register() {
        NativeItem.registerItem(TextInputItem.class);
    }
}
