package io.neft.client.handlers;

import io.neft.client.Reader;

public abstract class StringActionHandler implements ActionHandler {
    public abstract void accept(String value);

    public final void accept(Reader reader) {
        accept(reader.getString());
    }
}
