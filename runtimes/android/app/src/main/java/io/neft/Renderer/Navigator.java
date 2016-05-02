package io.neft.Renderer;

import java.util.Locale;

import io.neft.Client.OutAction;
import io.neft.MainActivity;

public class Navigator {

    public String language;

    static void init(Navigator navigator, MainActivity app) {
        // NAVIGATOR_LANGUAGE
        navigator.language = Locale.getDefault().getLanguage();
        app.client.pushAction(OutAction.NAVIGATOR_LANGUAGE);
        app.client.pushString(navigator.language);

        // NAVIGATOR_ONLINE
        // TODO
    }

    static void register(MainActivity app) {}

}
