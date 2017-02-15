package io.neft.extensions.tileimage;

import io.neft.renderer.NativeItem;

public final class TileImageExtension {
    public static void register() {
        NativeItem.registerItem(TileImageItem.class);
    }
}
