package io.neft.extensions.tileimageextension;

import io.neft.renderer.NativeItem;

public final class TileImageExtension {
    public static void register() {
        NativeItem.registerItem(TileImageItem.class);
    }
}
