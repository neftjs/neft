import QtQuick 2.3
import "./bootstrap.js" as Bootstrap

Item {
	id: window
	readonly property var items: Object({ window: window })
	width: 900
	height: 700

	Item {
		id: hatchery
		visible: false
	}

	QtObject {
		id: qmlUtils

		// TODO: use cache for funcs
		function createBinding(item, prop, binding){
			var func = "func = function(){ try {return " + binding + ";} catch(err){ console.log('Binding error:\\n'+err.message+'\\n"+binding+"'); } }";
			try {
				eval(func);
			} catch(err){
				console.log("Can't create binding:\n"+func+"\n"+err.message);
			}

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