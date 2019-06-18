package io.neft.renderer.handlers;

import io.neft.client.Reader;
import io.neft.renderer.Item;

public interface ItemActionHandler<T extends Item> {
    void accept(T item, Reader reader);
}
