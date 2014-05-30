import QtQuick 2.3
import QtWebKit 3.0
import "./bootstrap.js" as Bootstrap

Item {
	id: window
	width: 500
	height: 600

	WebView {
		id: webView
		anchors.fill: parent
	}

	Timer {
		id: setImmediateTimer
		interval: 1
	}

	Component.onCompleted: {
		Bootstrap.boot();
	}
}