package io.neft.extensions.input_extension;

import io.neft.renderer.NativeItem;

public final class InputExtension {
    public static void register() {
        NativeItem.registerItem(TextInputItem.class);
    }
}
