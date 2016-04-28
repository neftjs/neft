Rectangle { // first style in `view.js` is a window
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
