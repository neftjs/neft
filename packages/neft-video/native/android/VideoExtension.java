package io.neft.extensions.video_extension;

import io.neft.renderer.NativeItem;

public final class VideoExtension {
    public static void register() {
        NativeItem.registerItem(VideoItem.class);
    }
}
