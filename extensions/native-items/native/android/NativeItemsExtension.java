package io.neft.extensions.nativeitems;

import io.neft.renderer.NativeItem;

public final class NativeItemsExtension {
    public static void register() {
        NativeItem.registerItem(DSScrollable.class);
        NativeItem.registerItem(DSButton.class);
        NativeItem.registerItem(DSSlider.class);
        NativeItem.registerItem(DSSwitch.class);
    }
}
