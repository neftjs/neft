Rectangle { // first style in `view.js` is a window
	color: 'rgba(0, 0, 0, .1)'

	Scrollable {
		anchors.fill: parent
		contentItem: Column {
			anchors.fillWidth: parent
			alignment.horizontal: 'center'

			Flow {
				document.query: 'body'
				width: 400
			}
		}
	}
}

Rectangle {
	document.query: 'button'
	property $.text: ''
	color: 'orange'
	children.layout: Row {
		padding: '5 10'
	}

	Text {
		text: parent.$.text.toUpperCase()
		color: '#444'
		margin: '7 10'
		visible: this.text != ''
		font.pixelSize: 10
		font.weight: 1

		if (this.parent.pointer.hover){
			color: 'white'
		}
	}
}
