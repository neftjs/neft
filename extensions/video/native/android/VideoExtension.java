package io.neft.extensions.video;

import io.neft.renderer.NativeItem;

public final class VideoExtension {
    public static void register() {
        NativeItem.registerItem(VideoItem.class);
    }
}
