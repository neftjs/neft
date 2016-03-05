'use strict'

utils = require 'neft-utils'
assert = require 'neft-assert'
log = require 'neft-log'

assert = assert.scope 'View.Use'
log = log.scope 'View', 'Use'

module.exports = (File) -> class Use
	@__name__ = 'Use'
	@__path__ = 'File.Use'

	JSON_CTOR_ID = @JSON_CTOR_ID = File.JSON_CTORS.push(Use) - 1

	i = 1
	JSON_NODE = i++
	JSON_ARGS_LENGTH = @JSON_ARGS_LENGTH = i

	@_fromJSON = (file, arr, obj) ->
		unless obj
			node = file.node.getChildByAccessPath arr[JSON_NODE]
			obj = new Use file, node
		obj

	visibilityChangeListener = ->
		if @file.isRendered and not @isRendered
			@render()

	attrsChangeListener = (name) ->
		if name is 'neft:fragment'
			@name = @node.attrs['neft:fragment']

			if @isRendered
				@revert()
				@render()
		else if file = @usedFragment
			file.inputAttrs.set name, @node.attrs[name]
		return

	queue = []
	queuePending = false

	runQueue = ->
		style = queue.shift()
		file = queue.shift()

		if style.isRendered
			style.renderFragment file

		if queue.length
			requestAnimationFrame runQueue
		else
			queuePending = false
		return

	constructor: (@file, @node) ->
		assert.instanceOf @file, File
		assert.instanceOf @node, File.Element

		@name = @node.attrs['neft:fragment']
		@usedFragment = null
		@isRendered = false

		@node.onVisibleChange visibilityChangeListener, @
		@node.onAttrsChange attrsChangeListener, @

		`//<development>`
		if @constructor is Use
			Object.preventExtensions @
		`//</development>`

	`//<development>`
	usesWithNotFoundFragments = []
	logUsesWithNoFragments = ->
		while useElem = usesWithNotFoundFragments.pop()
			unless useElem.usedFragment
				log.warn "neft:fragment '#{useElem.name}' can't be find in file '#{useElem.file.path}'"
		return
	`//</development>`

	render: (file) ->
		assert.instanceOf file, File if file?

		return unless @node.visible

		if @isRendered
			@revert()

		@isRendered = true

		useAsync = utils.isClient
		useAsync &&= @node.attrs.has 'neft:async'
		useAsync &&= @node.attrs['neft:async'] isnt false
		if useAsync
			queue.push this, file
			unless queuePending
				requestAnimationFrame runQueue
				queuePending = true
		else
			@renderFragment file

		return

	renderFragment: (file) ->
		fragment = @file.fragments[@name]
		if not file and not fragment and not File._files[@name]
			`//<development>`
			# if usesWithNotFoundFragments.push(@) is 1
			# 	setTimeout logUsesWithNoFragments
			`//</development>`
			return

		usedFragment = file or File.factory(fragment or @name)
		unless file
			usedFragment.storage = @file.storage

		if file
			file.parentUse?.detachUsedFragment()

		unless usedFragment.isClone
			usedFragment = usedFragment.clone()

		# attrs
		{inputAttrs} = usedFragment
		viewAttrs = usedFragment.node.attrs
		useAttrs = @node.attrs
		for prop, val of inputAttrs
			if viewAttrs[prop] is undefined and useAttrs[prop] is undefined
				inputAttrs.pop prop
		for prop, val of viewAttrs
			if useAttrs[prop] is undefined
				inputAttrs.set prop, val
		for prop, val of useAttrs
			inputAttrs.set prop, val

		# ids
		{inputIds} = usedFragment
		viewIds = usedFragment.ids
		useIds = @file.inputIds
		for prop, val of inputIds
			if viewIds[prop] is undefined and useIds[prop] is undefined
				inputIds.pop prop
		for prop, val of useIds
			if viewIds[prop] is undefined
				inputIds.set prop, val
		for prop, val of viewIds
			inputIds.set prop, val

		# funcs
		{inputFuncs} = usedFragment
		viewFuncs = usedFragment.ids
		useFuncs = @file.inputFuncs
		for prop, val of inputFuncs
			if viewFuncs[prop] is undefined and useFuncs[prop] is undefined
				inputFuncs.pop prop
		for prop, val of useFuncs
			if viewFuncs[prop] is undefined
				inputFuncs.set prop, val
		for prop, val of viewFuncs
			inputFuncs.set prop, val

		unless usedFragment.isRendered
			usedFragment = usedFragment.render @

		usedFragment.node.parent = @node
		@usedFragment = usedFragment

		# signal
		usedFragment.parentUse = @
		usedFragment.onReplaceByUse.emit @
		File.emitNodeSignal usedFragment, 'neft:onReplaceByUse', @

		return

	revert: ->
		return unless @isRendered

		# destroy used fragment
		if @usedFragment
			@usedFragment.revert().destroy()

		@isRendered = false
		return

	detachUsedFragment: ->
		assert.isDefined @usedFragment

		@usedFragment.node.parent = null
		@usedFragment.parentUse = null
		@usedFragment = null
		return

	clone: (original, file) ->
		node = original.node.getCopiedElement @node, file.node

		new Use file, node

	toJSON: (key, arr) ->
		unless arr
			arr = new Array JSON_ARGS_LENGTH
			arr[0] = JSON_CTOR_ID
		arr[JSON_NODE] = @node.getAccessPath @file.node
		arr
