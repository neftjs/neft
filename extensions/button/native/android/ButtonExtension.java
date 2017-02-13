package io.neft.extensions.button;

import io.neft.renderer.NativeItem;

public final class ButtonExtension {
    public static void register() {
        NativeItem.registerItem(ButtonItem.class);
    }
}
