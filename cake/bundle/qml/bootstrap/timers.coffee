setImmediate = do ->

	stack = []
	timer = setImmediateTimer

	timer.triggered.connect ->
		while stack.length
			func = stack.shift()
			args = stack.shift()
			func.apply null, args

	(func, args...) ->

		stack.push func, args
		timer.running = true

setTimeout = do ->

	(func, ms, args...) ->

		unless ms
			return setImmediate func, args...

		console.error "ERROR: ms in setTimeout not supported"