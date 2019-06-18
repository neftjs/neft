package io.neft.renderer.handlers;

import io.neft.client.Reader;
import io.neft.renderer.Item;

public abstract class NoArgsItemActionHandler<T extends Item> implements ItemActionHandler<T> {
    public abstract void accept(T item);

    public final void accept(T item, Reader reader) {
        accept(item);
    }
}
