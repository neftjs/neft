package io.neft.extensions.scrollableextension;

import io.neft.renderer.NativeItem;

public final class ScrollableExtension {
    public static void register() {
        NativeItem.registerItem(ScrollableItem.class);
    }
}
