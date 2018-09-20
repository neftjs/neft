package io.neft.renderer.handlers;

import io.neft.App;
import io.neft.client.Reader;
import io.neft.renderer.Item;

public abstract class ItemItemActionHandler<T extends Item> implements ItemActionHandler<T> {
    public abstract void accept(T item, Item value);

    public final void accept(T item, Reader reader) {
        accept(item, App.getInstance().getRenderer().getItemFromReader(reader));
    }
}
