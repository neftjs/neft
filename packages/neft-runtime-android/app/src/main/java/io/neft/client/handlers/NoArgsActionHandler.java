package io.neft.client.handlers;

import io.neft.client.Reader;

public abstract class NoArgsActionHandler implements ActionHandler {
    public abstract void accept();

    public final void accept(Reader reader) {
        accept();
    }
}
