package io.neft.extensions.scrollable_extension;

import android.content.Context;
import android.graphics.Rect;
import android.view.View;
import android.view.ViewGroup;
import android.view.ViewTreeObserver;
import android.widget.FrameLayout;
import android.widget.HorizontalScrollView;
import android.widget.ScrollView;
import io.neft.renderer.Item;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCall;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;

public class ScrollableItem extends NativeItem {
    private static class ScrollableView extends ScrollView {
        private ScrollableItem scrollable;
        private HorizontalScrollView hScroll;
        private ViewGroup content;

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

            hScroll = new HorizontalScrollableView(context);
            hScroll.setLayoutParams(new LayoutParams(
                    LayoutParams.MATCH_PARENT,
                    LayoutParams.WRAP_CONTENT
            ));
            addView(hScroll);

            content = new FrameLayout(context);
            hScroll.addView(content);
        }

        @Override
        protected void onScrollChanged(int l, int t, int oldl, int oldt) {
            scrollable.sendContentY();
        }

        // overriding this method gives smooth scroll effect in both directions but
        // breaks touch events on native elements
        // @Override
        // public boolean dispatchTouchEvent(MotionEvent event) {
        //     hScroll.dispatchTouchEvent(event);
        //     onTouchEvent(event);
        //     return true;
        // }

        @Override
        protected void onSizeChanged(int w, int h, int oldw, int oldh) {
            // disable default animation on activity size change
            smoothScrollBy(0, 0);
        }

        @Override
        public View findFocus() {
            // do not scroll to focus element
            return null;
        }

        @Override
        protected int computeScrollDeltaToGetChildRectOnScreen(Rect rect) {
            // do not scroll to focus element
            return 0;
        }

        void addContentView(View view) {
            content.addView(view);
        }
    }

    public Item contentItem;

    @OnCreate("Scrollable")
    public ScrollableItem() {
        super(new ScrollableView(APP.getActivity().getApplicationContext()));
        getItemView().scrollable = this;
        setHorizontalScrollEffect(true);
        setVerticalScrollEffect(true);
        setClip(true);
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
            val.setParent(this);
            view.removeView(val.view);
            getItemView().addContentView(val.view);
        }
    }

    @OnSet("contentX")
    public void setContentX(int val) {
        final int px = Math.round(dpToPx(val));
        getItemView().getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                getItemView().hScroll.scrollTo(px, 0);
                sendContentX();
                getItemView().getViewTreeObserver().removeOnGlobalLayoutListener(this);
            }
        });
    }

    @OnSet("contentY")
    public void setContentY(int val) {
        final int px = Math.round(dpToPx(val));
        getItemView().getViewTreeObserver().addOnGlobalLayoutListener(new ViewTreeObserver.OnGlobalLayoutListener() {
            @Override
            public void onGlobalLayout() {
                getItemView().scrollTo(0, px);
                sendContentY();
                getItemView().getViewTreeObserver().removeOnGlobalLayoutListener(this);
            }
        });
    }

    @OnSet("horizontalScrollBar")
    public void setHorizontalScrollBar(boolean val) {
        getItemView().hScroll.setHorizontalScrollBarEnabled(val);
    }

    @OnSet("verticalScrollBar")
    public void setVerticalScrollBar(boolean val) {
        getItemView().setVerticalScrollBarEnabled(val);
    }

    @OnSet("horizontalScrollEffect")
    public void setHorizontalScrollEffect(boolean val) {
        getItemView().hScroll.setOverScrollMode(val ? View.OVER_SCROLL_IF_CONTENT_SCROLLS : View.OVER_SCROLL_NEVER);
    }

    @OnSet("verticalScrollEffect")
    public void setVerticalScrollEffect(boolean val) {
        getItemView().setOverScrollMode(val ? View.OVER_SCROLL_IF_CONTENT_SCROLLS : View.OVER_SCROLL_NEVER);
    }

    @OnCall("animatedScrollTo")
    public void animatedScrollTo(Object[] args) {
        float x = ((Number) args[0]).floatValue();
        float y = ((Number) args[1]).floatValue();
        getItemView().hScroll.smoothScrollTo(Math.round(dpToPx(x)), 0);
        getItemView().smoothScrollTo(0, Math.round(dpToPx(y)));
    }
}
