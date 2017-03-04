package io.neft.extensions.scrollable_extension;

import android.content.Context;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.HorizontalScrollView;
import android.widget.ScrollView;

import io.neft.renderer.Item;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;

public class ScrollableItem extends NativeItem {
    private static class ScrollableView extends ScrollView {
        private ScrollableItem scrollable;
        private HorizontalScrollView hScroll;

        class HorizontalScrollableView extends HorizontalScrollView {
            public HorizontalScrollableView(Context context) {
                super(context);
            }

            @Override
            protected void onScrollChanged(int l, int t, int oldl, int oldt) {
                scrollable.sendContentX();
            }
        }

        public ScrollableView(Context context) {
            super(context);

            setLayerType(LAYER_TYPE_HARDWARE, null);

            hScroll = new HorizontalScrollableView(context);
            hScroll.setLayoutParams(new LayoutParams(
                    ViewGroup.LayoutParams.MATCH_PARENT,
                    ViewGroup.LayoutParams.WRAP_CONTENT
            ));
            hScroll.setClipChildren(false);
            addView(hScroll);
        }

        @Override
        protected void onScrollChanged(int l, int t, int oldl, int oldt) {
            scrollable.sendContentY();
        }

        @Override
        public boolean onTouchEvent(MotionEvent event) {
            return super.onTouchEvent(event) || hScroll.onTouchEvent(event);
        }

        @Override
        public boolean onInterceptTouchEvent(MotionEvent event) {
            return super.onInterceptTouchEvent(event) || hScroll.onInterceptTouchEvent(event);
        }

        void addContentView(View view) {
            hScroll.addView(view);
        }
    }

    public Item contentItem;

    @OnCreate("Scrollable")
    public ScrollableItem() {
        super(new ScrollableView(APP.getActivity().getApplicationContext()));
        getItemView().scrollable = this;
    }

    private ScrollableView getItemView() {
        return (ScrollableView) itemView;
    }

    private void sendContentX() {
        float scrollX = pxToDp(getItemView().hScroll.getScrollX());
        pushEvent("contentXChange", scrollX);
    }

    private void sendContentY() {
        float scrollY = pxToDp(getItemView().getScrollY());
        pushEvent("contentYChange", scrollY);
    }

    @OnSet("contentItem")
    public void setContentItem(Item val) {
        if (contentItem != null) {
            contentItem.removeFromParent();
        }
        contentItem = val;
        if (val != null) {
            getItemView().addContentView(val.view);
        }
    }

    @OnSet("contentX")
    public void setContentX(int val) {
        int px = Math.round(dpToPx(val));
        getItemView().hScroll.scrollTo(px, 0);
        sendContentX();
    }

    @OnSet("contentY")
    public void setContentY(int val) {
        int px = Math.round(dpToPx(val));
        getItemView().scrollTo(0, px);
        sendContentY();
    }
}
