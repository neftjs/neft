package io.neft.extensions.defaultstyles;

import io.neft.renderer.NativeItem;

public final class DefaultStylesExtension {
    public static void register() {
        NativeItem.registerItem(DSButton.class);
        NativeItem.registerItem(DSSlider.class);
        NativeItem.registerItem(DSSwitch.class);
    }
}
