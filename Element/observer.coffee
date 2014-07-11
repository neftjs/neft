'use strict'

[utils, expect] = ['utils', 'expect'].map require

module.exports = (Element) -> class Observer

	@EVENTS = ['onAttrChange', 'onParentChange', 'onTextChange', 'onVisibilityChange']

	###
	Register event listener on the node
	###
	connect = (observer, node, name) ->

		unless node[name] then do ->
			node[name] = event = (a, b) -> trigger event, @, a, b
			event.listenersLen = 0

		node[name][node[name].listenersLen++] = observer[name]

	###
	Call `connect` on the node and on the each child recursively
	###
	connectDeep = (observer, node, name) ->

		connect observer, node, name

		if node.children
			for child in node.children
				connectDeep observer, child, name
			
		null

	###
	Call all registered listeners
	###
	trigger = (event, node, a, b) ->

		expect(event).toBe.function()
		expect(node).toBe.any Element

		for i in [0...event.listenersLen]
			event[i] node, a, b

		null

	constructor: (@node, opts) ->

		expect(node).toBe.any Element
		expect(opts).toBe.simpleObject()
		expect().defined(opts.deep).toBe.boolean()
		expect().defined(opts[event]).toBe.function() for event in Observer.EVENTS

		utils.fill @, opts

		# chosen function depends on the `deep` flag
		if opts.deep
			connectFunc = connectDeep
		else
			connectFunc = connect

		# register listeners
		for name in Observer.EVENTS when @[name]			
			connectFunc @, node, name

	# mark listeners in the prototype
	for event in Observer.EVENTS
		Element::[event] = null
		@::[event] = null
