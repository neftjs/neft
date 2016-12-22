// https://www.w3.org/TR/CSS2/sample.html

Flow {
	document.query: 'address, div, dl, dt, li, pre'
	layout.fillWidth: true
}

Flow {
	document.query: 'h1'
	padding.vertical: 18.76
	layout.fillWidth: true

	select ('#text'){
		font.pixelSize: 28
	}
}

Flow {
	document.query: 'h2'
	padding.vertical: 21
	layout.fillWidth: true

	select ('#text'){
		font.pixelSize: 21
	}
}

Flow {
	document.query: 'h3'
	padding.vertical: 23.24
	layout.fillWidth: true

	select ('#text'){
		font.pixelSize: 16.38
	}
}

Flow {
	document.query: 'h4, p, fieldset, form, dl'
	padding.vertical: 31.36
	layout.fillWidth: true
}

Flow {
	document.query: 'h5'
	padding.vertical: 42
	layout.fillWidth: true

	select ('#text'){
		font.pixelSize: 11.62
	}
}

Flow {
	document.query: 'h6'
	padding.vertical: 46.76
	layout.fillWidth: true

	select ('#text'){
		font.pixelSize: 10.5
	}
}

select ('h1, h2, h3, h4, h5, h6, b, strong'){
	select ('#text'){
		font.weight: 0.7
	}
}

Flow {
	document.query: 'blockquote'
	padding: '31.36 40 31.36 40'
	layout.fillWidth: true
}

select ('i, cite, em, var, address'){
	select ('#text'){
		font.italic: true
	}
}

select ('pre, tt, code, kbd, samp'){
	select ('#text'){
		font.family: 'monospace'
	}
}

Flow {
	document.query: 'textarea, input, select'
}

Rectangle {
	document.query: 'hr'
	border.width: 1
	border.color: 'gray'
	layout.fillWidth: true
}

Flow {
	document.query: 'ol, ul, menu'
	padding.vertical: 31.36
	padding.left: 40
	layout.fillWidth: true

	select ('ul, ol'){
		margin.vertical: 0
	}
}

Flow {
	document.query: 'dd'
	padding.left: 40
	layout.fillWidth: true
}
