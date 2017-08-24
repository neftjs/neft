package io.neft.client.handlers;

import io.neft.client.Reader;

public interface ActionHandler {
    void accept(Reader reader);
}
