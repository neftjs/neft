package io.neft.renderer.handlers;

import io.neft.client.Reader;
import io.neft.renderer.Item;
import io.neft.utils.ColorValue;

public abstract class ColorItemActionHandler<T extends Item> implements ItemActionHandler<T> {
    public abstract void accept(T item, ColorValue value);

    public final void accept(T item, Reader reader) {
        int rgba = reader.getInteger();
        int argb = ColorValue.RGBAtoARGB(rgba);
        ColorValue color = new ColorValue(argb);
        accept(item, color);
    }
}
