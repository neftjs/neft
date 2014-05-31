import QtQuick 2.3
import QtWebKit 3.0
import "./bootstrap.js" as Bootstrap

Rectangle {
	id: window
	width: 500
	height: 600
	color: '#444'

	Flickable {
		id: styles
		contentWidth: 500
		contentHeight: 1600
		clip: true
		anchors.fill: parent
	}

	Rectangle {
		id: scrollbar
		anchors.right: styles.right
		anchors.rightMargin: 5
		y: styles.visibleArea.yPosition * styles.height
		width: 5
		radius: 2
		height: styles.visibleArea.heightRatio * styles.height
		color: Qt.rgba(0, 0, 0, 0.7)
     }

	/*WebView {
		id: webView
		width: 500
		height: 300
		y: 300
	}*/

	Timer {
		id: setImmediateTimer
		interval: 1
	}

	Component.onCompleted: {
		Bootstrap.boot();
	}
}