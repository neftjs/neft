package io.neft.Renderer;

import java.util.Locale;

public class Navigator {

    public final String language;

    static void register(Renderer renderer){}

    public Navigator(Renderer renderer){
        // NAVIGATOR_LANGUAGE
        this.language = Locale.getDefault().getLanguage();
        renderer.pushAction(Renderer.OutAction.NAVIGATOR_LANGUAGE);
        renderer.pushString(language);

        // NAVIGATOR_ONLINE
        // TODO
    }

}
