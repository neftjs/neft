package io.neft.renderer;

import android.graphics.drawable.Drawable;

import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.handlers.NoArgsActionHandler;
import io.neft.nimage.NImage;
import io.neft.nimage.NImageHolder;
import io.neft.renderer.handlers.StringItemActionHandler;
import io.neft.utils.ViewUtils;

public class Image extends Item {
    public static void register() {
        onAction(InAction.CREATE_IMAGE, new NoArgsActionHandler() {
            @Override
            public void accept() {
                new Image();
            }
        });

        onAction(InAction.SET_IMAGE_SOURCE, new StringItemActionHandler<Image>() {
            @Override
            public void accept(Image item, String value) {
                item.setSource(value);
            }
        });
    }

    private String source;
    private final NImageHolder<Drawable> holder;

    private Image() {
        super();

        holder = new NImageHolder<Drawable>() {
            @Override
            public void draw(Drawable resource) {
                ViewUtils.setBackground(view, resource);
            }

            @Override
            public void onLoad(Drawable resource) {
                float width = pxToDp(resource.getIntrinsicWidth());
                float height = pxToDp(resource.getIntrinsicHeight());
                pushAction(OutAction.IMAGE_SIZE, source, true, width, height);
            }

            @Override
            public void onError() {
                pushAction(OutAction.IMAGE_SIZE, source, false, 0f, 0f);
            }
        };
    }

    public void setSource(String val) {
        source = val;
        NImage.loadDrawable(holder, val);
    }
}
