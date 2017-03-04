package io.neft.extensions.slider_extension;

import io.neft.renderer.NativeItem;

public final class SliderExtension {
    public static void register() {
        NativeItem.registerItem(SliderItem.class);
    }
}
