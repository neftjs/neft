'use strict'

module.exports = (opts) ->
	window: global
	document: {}
	isFake: true
	addEventListener: ->
	Image: ->
	HTMLCanvasElement: if opts.extras?.game then (->) else null
	location: pathname: ''
	navigator: userAgent: ''
	innerWidth: 1024
	innerHeight: 600
	scrollX: 0
	scrollY: 0
	screen: {}
	document: document =
		body:
			appendChild: ->
		createElement: ->
			classList:
				add: ->
			appendChild: ->
			insertBefore: ->
			style: {}
			children: [
				{
					childNodes: []
					width:
						baseVal: 0
					height:
						baseVal: 0
				}
			]
			removeChild: ->
			getBoundingClientRect: -> {}
			addEventListener: ->
			setAttribute: ->
			getAttribute: ->
			innerHTML: ''
			cloneNode: ->
				global.document.createElement()
			getContext: ->
		createElementNS: ->
			width: baseVal: value: null
			height: baseVal: value: null
			style: {}
			classList:
				add: ->
			transform:
				baseVal:
					appendItem: ->
			setAttribute: ->
			appendChild: ->
			setAttributeNS: ->
			createSVGTransform: ->
				setTranslate: ->
				setScale: ->
			childNodes: [
				{
					transform:
						baseVal:
							appendItem: ->
					childNodes: []
					setAttribute: ->
				}
			]
			children: []
		getElementById: ->
		addEventListener: ->
		querySelector: ->
		createTextNode: ->
			{}
	history:
		pushState: ->
	requestAnimationFrame: ->
	Image: document.createElement
	XMLHttpRequest: class XMLHttpRequest
		open: ->
		setRequestHeader: ->
		send: ->
