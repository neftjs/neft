package io.neft.renderer.handlers;

import io.neft.client.Reader;
import io.neft.renderer.Item;

public abstract class StringItemActionHandler<T extends Item> implements ItemActionHandler<T> {
    public abstract void accept(T item, String value);

    public final void accept(T item, Reader reader) {
        accept(item, reader.getString());
    }
}
