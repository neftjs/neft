package io.neft.extensions.sliderextension;

import io.neft.renderer.NativeItem;

public final class SliderExtension {
    public static void register() {
        NativeItem.registerItem(SliderItem.class);
    }
}
