Rectangle {
	Scrollable {
		anchors.fill: parent
		contentItem: Column {
			anchors.fillWidth: parent
			alignment.horizontal: 'center'

			Flow {
				document.query: 'body'
				width: 800
			}
		}
	}
}
