'use strict'

[coffee, utils] = ['coffee-script', 'utils'].map require

module.exports = (File) -> (file) ->

	{Style} = File
	funcs = file.funcs ?= {}

	nodes = file.node.queryAll 'x:func'
	for node in nodes

		name = node.attrs.get 'name'
		unless name
			throw 'Func name is requried'

		if funcs.hasOwnProperty name
			throw "Func `#{name}` already exists"

		body = node.stringifyChildren()
		try
			body = coffee.compile body, bare: true

		funcs[name] = body

		# remove node
		node.parent = null

	if utils.isEmpty funcs
		file.funcs = null

	null