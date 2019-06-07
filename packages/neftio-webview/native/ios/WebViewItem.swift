import UIKit
import WebKit

fileprivate class ViewController: UIViewController, WKNavigationDelegate {
    weak var item: Extension.Webview.WebViewItem?

    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == #keyPath(WKWebView.url)) {
            item?.handleUrlChange()
        }
    }
}

extension Extension.Webview {
    class WebViewItem: NativeItem {
        override class var name: String { return "WebView" }

        override class func register() {
            onCreate() {
                return WebViewItem()
            }

            onSet("source") {
                (item: WebViewItem, val: String) in
                let url = URL(string: val) ?? URL(string: "about:")!
                item.webView.load(URLRequest(url: url))
            }
        }

        var webView: WKWebView {
            return itemView as! WKWebView
        }

        fileprivate let controller = ViewController()

        init() {
            super.init(itemView: WKWebView())

            controller.item = self
            webView.navigationDelegate = controller
            webView.addObserver(controller, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        }

        fileprivate func handleUrlChange() {
            guard let url = webView.url else { return }
            pushEvent(event: "sourceChange", args: [url.absoluteString])
        }
    }
}
