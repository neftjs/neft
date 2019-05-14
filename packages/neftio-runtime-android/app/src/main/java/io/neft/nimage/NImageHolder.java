package io.neft.nimage;

import android.graphics.drawable.Drawable;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import com.bumptech.glide.request.Request;
import com.bumptech.glide.request.target.SizeReadyCallback;
import com.bumptech.glide.request.target.Target;
import com.bumptech.glide.request.transition.Transition;

public abstract class NImageHolder<T> implements Target<T> {
    private Request request;

    public abstract void draw(T resource);

    public abstract void onLoad(T resource);

    public abstract void onError();

    @Override
    public void onLoadStarted(@Nullable Drawable placeholder) {
        // NOP
    }

    @Override
    public void onLoadFailed(@Nullable Drawable errorDrawable) {
        onError();
    }

    @Override
    public void onResourceReady(@NonNull T resource, @Nullable Transition<? super T> transition) {
        onLoad(resource);
        draw(resource);
    }

    @Override
    public void onLoadCleared(@Nullable Drawable placeholder) {
        draw(null);
    }

    @Override
    public void getSize(@NonNull SizeReadyCallback cb) {
        cb.onSizeReady(SIZE_ORIGINAL, SIZE_ORIGINAL);
    }

    @Override
    public void removeCallback(@NonNull SizeReadyCallback cb) {
        // NOP
    }

    @Override
    public void setRequest(@Nullable Request request) {
        this.request = request;
    }

    @Nullable
    @Override
    public Request getRequest() {
        return request;
    }

    @Override
    public void onStart() {
        // NOP
    }

    @Override
    public void onStop() {
        // NOP
    }

    @Override
    public void onDestroy() {
        // NOP
    }
}
