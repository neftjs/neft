package io.neft.extensions.tileimage_extension;

import io.neft.renderer.NativeItem;

public final class TileImageExtension {
    public static void register() {
        NativeItem.registerItem(TileImageItem.class);
    }
}
