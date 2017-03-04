package io.neft.extensions.switchextension;

import io.neft.renderer.NativeItem;

public final class SwitchToggleExtension {
    public static void register() {
        NativeItem.registerItem(SwitchItem.class);
    }
}
