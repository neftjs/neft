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
        override class func main() {
            NativeItemBinding()
                .onCreate("WebView") { WebViewItem() }
                .onSet("source") { (item, val: String) in item.setSource(val) }
                .finalize()
        }

        private var webView = WKWebView()

        fileprivate let controller = ViewController()

        required init() {
            super.init(itemView: webView)

            controller.item = self
            webView.navigationDelegate = controller
            webView.addObserver(controller, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        }

        func setSource(_ val: String) {
            let url = URL(string: val) ?? URL(string: "about:")!
            webView.load(URLRequest(url: url))
        }

        fileprivate func handleUrlChange() {
            guard let url = webView.url else { return }
            pushEvent(event: "sourceChange", args: [url.absoluteString])
        }
    }
}
