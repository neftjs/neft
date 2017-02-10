package io.neft.renderer;

import java.util.Locale;

import io.neft.App;
import io.neft.client.OutAction;

final class Navigator {
    private static final App APP = App.getInstance();
    private String language;

    static void init(Navigator navigator) {
        // NAVIGATOR_LANGUAGE
        navigator.language = Locale.getDefault().getLanguage();
        APP.getClient().pushAction(OutAction.NAVIGATOR_LANGUAGE, navigator.language);

        // NAVIGATOR_ONLINE
        // TODO
    }
}
