package io.neft.renderer.handlers;

import io.neft.client.Reader;
import io.neft.renderer.Item;

public abstract class FloatItemActionHandler<T extends Item> implements ItemActionHandler<T> {
    public abstract void accept(T item, float value);

    public final void accept(T item, Reader reader) {
        accept(item, reader.getFloat());
    }
}
