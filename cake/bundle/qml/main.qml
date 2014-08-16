import QtQuick 2.3
import "./bootstrap.js" as Bootstrap

Item {
	id: window
	readonly property var items: Object({ window: window })
	width: 500
	height: 600

	QtObject {
		id: hatchery
	}

	QtObject {
		id: qmlUtils

		function createBinding(item, prop, binding){
			var func = "func = function(){ return " + binding + "; }";
			eval(func);
			item[prop] = Qt.binding(func);
		}
	}

	Item {
		id: styles
	}

	Timer {
		id: setImmediateTimer
		interval: 1
	}

	Component.onCompleted: {
		Bootstrap.boot();
	}
}