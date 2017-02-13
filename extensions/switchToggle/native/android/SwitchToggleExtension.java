package io.neft.extensions.switchtoggle;

import io.neft.renderer.NativeItem;

public final class SwitchToggleExtension {
    public static void register() {
        NativeItem.registerItem(SwitchItem.class);
    }
}
