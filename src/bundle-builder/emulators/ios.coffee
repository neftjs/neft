'use strict'

module.exports = ->
	window: global
	requestAnimationFrame: ->
	ios:
		postMessage: ->
	_neft:
		http:
			request: -> 0
			onResponse: ->
		native:
			transferData: ->
			onData: ->
