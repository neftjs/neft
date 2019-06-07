package io.neft.extensions.scrollable_extension;

import io.neft.renderer.NativeItem;

public final class ScrollableExtension {
    public static void register() {
        NativeItem.registerItem(ScrollableItem.class);
    }
}
