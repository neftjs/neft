'use strict'

utils = require 'utils'
assert = require 'neft-assert'
log = require 'log'

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
			@name = @node.getAttr 'neft:fragment'

			if @isRendered
				@revert()
				@render()
		return

	constructor: (@file, @node) ->
		assert.instanceOf file, File
		assert.instanceOf node, File.Element

		@name = node.getAttr 'neft:fragment'
		@usedFragment = null
		@isRendered = false

		node.onVisibleChange visibilityChangeListener, @
		node.onAttrsChange attrsChangeListener, @

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

		fragment = @file.fragments[@name]
		if not file and not fragment
			`//<development>`
			if usesWithNotFoundFragments.push(@) is 1
				setTimeout logUsesWithNoFragments
			`//</development>`
			return

		usedFragment = file or File.factory(fragment)
		unless file
			usedFragment.storage = @file.storage

		unless usedFragment.isRendered
			usedFragment = usedFragment.render @

		usedFragment.node.parent = @node
		@usedFragment = usedFragment

		# signal
		usedFragment.parentUse = @
		usedFragment.onReplaceByUse.emit @

		@isRendered = true

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
