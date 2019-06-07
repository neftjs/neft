package io.neft.extensions.webview_extension;

import android.annotation.SuppressLint;
import android.webkit.WebSettings;
import android.webkit.WebView;
import android.webkit.WebViewClient;

import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;

public class WebViewItem extends NativeItem {
    @SuppressLint("SetJavaScriptEnabled")
    @OnCreate("WebView")
    public WebViewItem() {
        super(new CustomWebView(APP.getActivity().getApplicationContext()));

        WebSettings settings = getItemView().getSettings();
        settings.setJavaScriptEnabled(true);
        settings.setJavaScriptCanOpenWindowsAutomatically(true);
        settings.setBuiltInZoomControls(true);
        settings.setDisplayZoomControls(false);
        settings.setAppCacheEnabled(true);
        settings.setDatabaseEnabled(true);
        settings.setDomStorageEnabled(true);
        settings.setGeolocationEnabled(true);

        getItemView().setWebViewClient(new WebViewClient() {
            @Override
            public void onPageFinished(WebView view, String url) {
                super.onPageFinished(view, url);
                pushEvent("sourceChange", url);
            }
        });
    }

    private CustomWebView getItemView() {
        return (CustomWebView) itemView;
    }

    @OnSet("source")
    public void setSource(String val) {
        getItemView().loadUrl(val.isEmpty() ? "about:" : val);
    }
}
