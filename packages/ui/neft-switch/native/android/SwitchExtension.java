package io.neft.extensions.switch_extension;

import io.neft.renderer.NativeItem;

public final class SwitchExtension {
    public static void register() {
        NativeItem.registerItem(SwitchItem.class);
    }
}
