'use strict'

setImmediate = do ->

	stack = []

	setImmediateTimer.triggered.connect ->
		while stack.length
			func = stack.shift()
			args = stack.shift()
			func.apply null, args

	(func) ->
		# support extra arguments
		if arguments.length > 1
			Array::shift.call arguments
			args = arguments

		stack.push func, args
		setImmediateTimer.start()

setTimeout = do ->
	(func, ms, args...) ->
		unless ms
			return setImmediate func, args...

		console.error "ERROR: ms in setTimeout are not supported"

requestAnimationFrame = (func) ->
	canvas.requestAnimationFrame ->
		setImmediate func