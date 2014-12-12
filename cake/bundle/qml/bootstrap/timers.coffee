'use strict'

setImmediate = do ->
	stack = []

	setImmediateTimer.triggered.connect ->
		while stack.length
			func = stack.shift()
			func.apply null

	(func) ->
		if arguments.length > 1
			throw new RangeError "setImmediate() doesn't support extra arguments"

		stack.push func
		setImmediateTimer.start()

setTimeout = do ->
	stack = []

	setTimeoutTimer.triggered.connect ->
		while stack.length
			func = stack.shift()
			args = stack.shift()
			func.apply null, args

	(func, ms, args...) ->
		if ms
			console.error "ERROR: ms in setTimeout are not supported"

		stack.push func, args
		setTimeoutTimer.start()

requestAnimationFrame = (func) ->
	canvas.requestAnimationFrame ->
		setImmediate func