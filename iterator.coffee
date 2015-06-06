'use strict'

utils = require 'utils'
assert = require 'assert'
List = require 'list'
log = require 'log'

{isArray} = Array

assert = assert.scope 'View.Iterator'
log = log.scope 'View', 'Iterator'

module.exports = (File) -> class Iterator extends File.Use
	@__name__ = 'Iterator'
	@__path__ = 'File.Iterator'

	@HTML_ATTR = "#{File.HTML_NS}:each"

	constructor: (@self, node) ->
		assert.instanceOf self, File
		assert.instanceOf node, File.Element

		prefix = if self.name then "#{self.name}-" else ''
		@name = "#{prefix}each[#{utils.uid()}]"

		super self, node

		# create fragment
		fragment = new File.Fragment self, @name, @bodyNode
		fragment.parse()
		@fragment = fragment.id
		@bodyNode.parent = undefined

	fragment: ''
	storage: null
	usedFragments: null
	data: null

	render: ->
		unless @node.visible
			return

		each = @node.attrs.get Iterator.HTML_ATTR

		# stop if nothing changed
		if each is @data
			return

		# stop if no data found
		if not isArray(each) and not (each instanceof List)
			log.warn "Data is not an array nor List:\n#{each}"
			return

		# set as data
		@data = array = each

		# listen on changes
		if each instanceof List
			each.onChange @updateItem, @
			each.onInsert @insertItem, @
			each.onPop @popItem, @

			array = each.items()

		# add items
		for _, i in array
			@insertItem i

		null

	revert: ->
		{data} = @

		if data
			@clearData()

			if data instanceof List
				data.onChange.disconnect @updateItem, @
				data.onInsert.disconnect @insertItem, @
				data.onPop.disconnect @popItem, @

		@data = null

	update: ->
		@revert()
		@render()

	clearData: ->
		assert.isObject @data

		while length = @usedFragments.length
			@popItem length - 1

		@

	updateItem: (elem, i) ->
		unless i?
			i = elem

		assert.isObject @data
		assert.isInteger i

		@popItem i
		@insertItem i

		@

	insertItem: (elem, i) ->
		unless i?
			i = elem

		assert.isObject @data
		assert.isInteger i

		{data} = @

		usedFragment = File.factory @fragment
		@usedFragments.splice i, 0, usedFragment

		if data instanceof List
			each = data.items()
			item = data.get i
		else
			each = data
			item = data[i]

		# render fragment with storage
		storage = usedFragment.storage = Object.create @self.storage or null
		storage.each = each
		storage.i = i
		storage.item = item
		usedFragment.render @

		# replace
		newChild = usedFragment.node
		newChild.parent = @node
		newChild.index = i

		# signal
		usedFragment.onReplaceByUse.emit @

		@

	popItem: (elem, i) ->
		unless i?
			i = elem

		assert.isObject @data
		assert.isInteger i

		@node.children[i].parent = undefined

		usedFragment = @usedFragments[i]
		usedFragment.revert().destroy()
		@usedFragments.splice i, 1

		@

	attrsChangeListener = (e) ->
		if @self.isRendered and e.name is Iterator.HTML_ATTR
			@update()

	visibilityChangeListener = (oldVal) ->
		if @self.isRendered and oldVal is false and not @node.data
			@update()

	clone: (original, self) ->
		clone = super

		clone.storage = utils.cloneDeep @storage
		clone.array = null
		clone.usedFragments = []

		clone.node.onAttrsChange attrsChangeListener, clone
		clone.node.onVisibilityChange visibilityChangeListener, clone

		clone
