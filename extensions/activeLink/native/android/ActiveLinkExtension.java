package io.neft.extensions.activelink_extension;

import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.net.Uri;
import android.util.Log;
import io.neft.App;
import io.neft.utils.Consumer;

public final class ActiveLinkExtension {
    private final static App APP = App.getInstance();

    public static void register() {
        APP.getClient().addCustomFunction("extensionActiveLinkMailto", new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                mailto((String) var[0]);
            }
        });

        APP.getClient().addCustomFunction("extensionActiveLinkTel", new Consumer<Object[]>() {
            @Override
            public void accept(Object[] var) {
                tel((String) var[0]);
            }
        });
    }

    public static void mailto(String address) {
        Intent intent = new Intent(Intent.ACTION_SENDTO);
        intent.setData(Uri.parse("mailto:" + address));
        try {
            APP.getActivity().startActivity(intent);
        } catch (ActivityNotFoundException error) {
            Log.e("NEFT", "Cannot mailto in ActiveLink extension", error);
        }
    }

    public static void tel(String number) {
        Intent intent = new Intent(Intent.ACTION_DIAL);
        intent.setData(Uri.parse("tel:" + number));
        try {
            APP.getActivity().startActivity(intent);
        } catch (ActivityNotFoundException error) {
            Log.e("NEFT", "Cannot tel in ActiveLink extension", error);
        }
    }
}
