Rectangle { // first style in `view.js` is a window
	color: 'rgba(0, 0, 0, .1)'
	children.layout: Column {
		spacing: 50
	}

	Rectangle {
		width: 200
		height: 200
		color: 'red'
		pointer.onDragEnter: function(){
			console.log('drag enter');
			this.color = 'green';
		}
		pointer.onDragExit: function(){
			console.log('drag exit');
			this.color = 'red';
		}
		pointer.onDrop: function(){
			console.log('drop');
			this.color = 'yellow';
		}
	}

	Scrollable {
		width: 200
		height: 200
		contentItem: Item {
			width: 500
			height: 500

			Rectangle {
				width: 200
				height: 200
				color: 'gray'
				pointer.onPress: function(){
					console.log('PRESSED');
					var self = this;
					setTimeout(function(){
						console.log('DELAY', self.pointer.pressed)
						if (self.pointer.pressed){
							self.pointer.draggable = true;
							self.pointer.dragging = true;
						}
					}, 500);
				}
				pointer.onDragStart: function(){
					console.log('drag start');
				}
				pointer.onDragEnd: function(){
					console.log('drag end');
				}

				if (this.pointer.dragging){
					scale: 1.5
					opacity: 0.5
				}
			}
		}
	}
}

Text {
	document.query: 'h1,h2,h3,h4,h5,h6,p'
	property $.level: parseInt(this.document.node.name[1]) || 6
	anchors.fillWidth: parent
	margin: '10 0'
	color: '#444'
	font.weight: this.$.level/6
	font.pixelSize: Math.pow(6-this.$.level, 1.9) + 13

	if (this.$.level === 1){
		color: 'rgba(0, 100, 255, 0.8)'
	}

	if (this.document.node.name === 'p'){
		font.weight: 0.4
	}
}

Rectangle {
	document.query: 'button'
	property $.text: ''
	color: 'orange'
	children.layout: Row {
		id: buttonOrder
	}

	Class {
		name: 'floatRight'
		changes: {
			anchors.right: parent.right
		}
	}

	Text {
		text: parent.$.text.toUpperCase()
		color: '#444'
		margin: '7 10'
		font.pixelSize: 10
		font.weight: 1

		if (this.parent.pointer.hover){
			color: 'white'
		}
	}
}