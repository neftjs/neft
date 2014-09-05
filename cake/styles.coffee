'use strict'

[vm, utils, expect, coffee, log] = ['vm', 'utils', 'expect', 'coffee-script', 'log'].map require
[Styles] = ['styles'].map require
{assert} = console

BINDING_RE = ///([a-z0-9_]+)\.(left|top|width|height)///ig
RESERVED_IDS = ['window']
HASH_PATTERN = 'u{hash}_'
BINDED_PROPS = ['left', 'top', 'width', 'height']

result =
	items: []
	ids: {}
units = {}
sandbox = {}

setItemId = (item, id) ->
	assert item.variables?.id is undefined

	result.ids[id] = item.index
	item.variables ?= {}
	item.variables.id = HASH_PATTERN + id
	item.config.id = ''

sandbox.Item = (opts) ->
	index = result.items.length

	obj =
		type: 'Item'
		index: index
		config: opts

	result.items.push obj

	# id
	if opts.id
		setItemId obj, opts.id

	# binded properties
	for prop in BINDED_PROPS when typeof opts[prop] is 'string'
		obj.variables ?= {}
		args = []
		idsIndexes = {}
		expr = opts[prop].replace BINDING_RE, (str, id, prop) ->
			unless utils.has RESERVED_IDS, id
				id = HASH_PATTERN + id
			unless idsIndexes[id]
				idsIndexes[id] = args.length
				args.push id
			"$#{idsIndexes[id]}.#{prop}"

		opts[prop] = [expr, []]
		obj.variables[prop] = args

	obj
utils.merge sandbox.Item, Styles.Item

sandbox.Node = (opts, children) ->
	if Array.isArray opts
		children = opts
		opts = {}

	if children ||= opts.children
		childrenIndexes = []

	obj = utils.merge sandbox.Item(opts),
		type: 'Node'
		children: childrenIndexes

	if children
		for child in children
			childrenIndexes.push child.index
			child.parent = obj.index

	obj
utils.merge sandbox.Node, Styles.Node

sandbox.Image = ->
	utils.merge sandbox.Item(arguments...),
		type: 'Image'
utils.merge sandbox.Image, Styles.Image

sandbox.Text = ->
	utils.merge sandbox.Item(arguments...),
		type: 'Text'
utils.merge sandbox.Text, Styles.Text

sandbox.Column = ->
	utils.merge sandbox.Node(arguments...),
		type: 'Column'
utils.merge sandbox.Column, Styles.Column

sandbox.Row = ->
	utils.merge sandbox.Node(arguments...),
		type: 'Row'
utils.merge sandbox.Row, Styles.Row

sandbox.Scrollable = ->
	utils.merge obj = sandbox.Node(arguments...),
		type: 'Scrollable'

	if obj.config.content?
		obj.links ?= {}
		obj.links.content = obj.config.content.index
		obj.config.content = null

	obj
utils.merge sandbox.Scrollable, Styles.Scrollable

sandbox.Unit = (name, node) ->
	expect(name).toBe.truthy().string()
	expect(node).toBe.object()

	unless node.variables?.id
		setItemId node, 'root'
	else if node.variables.id isnt "#{HASH_PATTERN}root"
		log.error "`#{name}` unit item id must be `root`"

	units[name] = result
	result =
		items: []
		ids: {}

exports.compile = (data) ->

	data = coffee.compile data, bare: true

	script = vm.createScript data
	script.runInNewContext sandbox

	# stringify
	json = JSON.stringify units, null, 4

	# clear
	utils.clear result.items
	utils.clear result.ids

	json