for ('h1'){
	background.color: 'orange'
	font.pixelSize: 37
	margin.bottom: 20
}

for ('h2'){
	font.pixelSize: 27
	margin.top: 10
}

for ('.products'){
	for ('> li'){
		padding: '10 0'
	}

	for ('button.anchorRight'){
		anchors.right: parent.right
		anchors.verticalCenter: parent.verticalCenter
		layout.enabled: false
	}
}
