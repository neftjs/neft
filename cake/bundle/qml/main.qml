import QtQuick 2.3
import QtWebKit 3.0
import "./bootstrap.js" as Bootstrap

Item {
	id: stylesWindow
	readonly property var items: Object([])
	width: 900
	height: 700

	Item {
		id: stylesHatchery
		visible: false
	}

	QtObject {
		id: qmlUtils

		// TODO: use cache for funcs
		function createBinding(item, prop, binding){
			// DEBUG
			var func = "func = function(){ try {return " + binding + ";} catch(err){ console.log(\"Binding error:\\n\"+err.message+\"\\n"+binding+"\"); } }";
			// var func = "func = function(){ return " + binding + "; }";
			try {
				eval(func);
			} catch(err){
				console.log("Can't create binding:\n"+func+"\n"+err.message);
			}

			item[prop] = Qt.binding(func);
		}
	}

	WebView {
		id: webview
		anchors.fill: parent
	}

	Item {
		id: stylesBody
	}

	Timer {
		id: setImmediateTimer
		interval: 1
	}

	Canvas {
		id: canvas
	}

	Component.onCompleted: {
		Bootstrap.boot();
	}
}