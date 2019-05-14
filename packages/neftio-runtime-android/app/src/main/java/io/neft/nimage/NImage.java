package io.neft.nimage;

import android.app.Activity;
import android.graphics.Bitmap;
import android.graphics.drawable.Drawable;
import android.net.Uri;
import android.util.Base64;

import com.bumptech.glide.Glide;
import com.bumptech.glide.RequestBuilder;
import com.bumptech.glide.load.DecodeFormat;
import com.bumptech.glide.request.RequestOptions;

import io.neft.App;

public class NImage {
    private static App APP = App.getInstance();
    private static RequestOptions OPTIONS = new RequestOptions()
            .format(DecodeFormat.PREFER_ARGB_8888);

    private static RequestBuilder<Bitmap> buildBitmapRequest() {
        return Glide.with(APP.getActivity())
                .applyDefaultRequestOptions(OPTIONS)
                .asBitmap();
    }

    private static RequestBuilder<Drawable> buildDrawableRequest() {
        return Glide.with(APP.getActivity())
                .applyDefaultRequestOptions(OPTIONS)
                .asDrawable();
    }

    private static <T> RequestBuilder<T> request(RequestBuilder<T> request, String resource) {
        if (resource.startsWith("/static")) {
            return request.load(Uri.parse("file:///android_asset" + resource));
        }

        if (resource.startsWith("data:")) {
            String base64 = resource.substring(resource.indexOf(","));
            byte[] imageAsBytes = Base64.decode(base64.getBytes(), 0);
            return request.load(imageAsBytes);
        }

        return request.load(resource);
    }

    private static <T> boolean prepareLoad(NImageHolder<T> holder, String resource) {
        if (resource == null || resource.isEmpty()) {
            clear(holder);
            return false;
        }
        return true;
    }

    public static void loadBitmap(NImageHolder<Bitmap> holder, String resource) {
        if (!prepareLoad(holder, resource)) return;
        request(buildBitmapRequest(), resource).into(holder);
    }

    public static void loadDrawable(NImageHolder<Drawable> holder, String resource) {
        if (!prepareLoad(holder, resource)) return;
        request(buildDrawableRequest(), resource).into(holder);
    }

    public static void clear(NImageHolder holder) {
        Activity activity = APP.getActivity();
        if (activity.isDestroyed()) return;
        Glide.with(activity).clear(holder);
    }
}
