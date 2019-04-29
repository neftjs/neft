package io.neft.extensions.ambientsound_extension;

import io.neft.renderer.NativeItem;

public final class AmbientSoundExtension {
    public static void register() {
        NativeItem.registerItem(AmbientSoundItem.class);
    }
}
