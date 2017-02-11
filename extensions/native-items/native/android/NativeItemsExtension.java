package io.neft.extensions.nativeitems;

import io.neft.renderer.NativeItem;

public final class NativeItemsExtension {
    public static void register() {
        NativeItem.registerItem(DSScrollable.class);
        NativeItem.registerItem(DSTextInput.class);
        NativeItem.registerItem(DSButton.class);
        NativeItem.registerItem(DSSwitch.class);
        NativeItem.registerItem(DSVideo.class);
    }
}
