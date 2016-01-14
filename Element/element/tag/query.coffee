'use strict'

utils = require 'utils'
signal = require 'signal'
assert = require 'neft-assert'

{emitSignal} = signal.Emitter
Tag = Text = null

test = (node, funcs, index, targetFunc, targetCtx, single) ->
	while index < funcs.length
		func = funcs[index]

		if func.isIterator
			return func node, funcs, index+3, targetFunc, targetCtx, single
		else
			data1 = funcs[index + 1]
			data2 = funcs[index + 2]
			unless func(node, data1, data2)
				return false

		index += 3

	targetFunc.call targetCtx, node
	true

anyDescendant = (node, funcs, index, targetFunc, targetCtx, single) ->
	for child in node.children
		if not (child instanceof Tag) or child.name isnt 'neft:blank'
			if test(child, funcs, index, targetFunc, targetCtx, single)
				if single
					return true

		if child instanceof Tag
			if anyDescendant(child, funcs, index, targetFunc, targetCtx, single)
				if single
					return true
	false
anyDescendant.isIterator = true
anyDescendant.toString = -> 'anyDescendant'

directParent = (node, funcs, index, targetFunc, targetCtx, single) ->
	if parent = node._parent
		if test(parent, funcs, index, targetFunc, targetCtx, single)
			return true
		if parent.name is 'neft:blank'
			return directParent parent, funcs, index, targetFunc, targetCtx, single
	false
directParent.isIterator = true
directParent.toString = -> 'directParent'

anyChild = (node, funcs, index, targetFunc, targetCtx, single) ->
	for child in node.children
		if child instanceof Tag and child.name is 'neft:blank'
			if anyChild(child, funcs, index, targetFunc, targetCtx, single)
				if single
					return true
		else
			if test(child, funcs, index, targetFunc, targetCtx, single)
				if single
					return true
	false
anyChild.isIterator = true
anyChild.toString = -> 'anyChild'

anyParent = (node, funcs, index, targetFunc, targetCtx, single) ->
	if parent = node._parent
		if test(parent, funcs, index, targetFunc, targetCtx, single)
			return true
		else
			return anyParent(parent, funcs, index, targetFunc, targetCtx, single)
	false
anyParent.isIterator = true
anyParent.toString = -> 'anyParent'

byName = (node, data1) ->
	if node instanceof Tag
		node.name is data1
	else if data1 is '#text' and node instanceof Text
		true
byName.isIterator = false
byName.toString = -> 'byName'

byInstance = (node, data1) ->
	node instanceof data1
byInstance.isIterator = false
byInstance.toString = -> 'byInstance'

byTag = (node, data1) ->
	node is data1
byTag.isIterator = false
byTag.toString = -> 'byTag'

byAttr = (node, data1) ->
	if node instanceof Tag
		node._attrs[data1] isnt undefined
	else
		false
byAttr.isIterator = false
byAttr.toString = -> 'byAttr'

byAttrValue = (node, data1, data2) ->
	if node instanceof Tag
		`node._attrs[data1] == data2`
	else
		false
byAttrValue.isIterator = false
byAttrValue.toString = -> 'byAttrValue'

byAttrStartsWithValue = (node, data1, data2) ->
	if node instanceof Tag
		attr = node._attrs[data1]
		if typeof attr is 'string'
			return attr.indexOf(data2) is 0
	false
byAttrStartsWithValue.isIterator = false
byAttrStartsWithValue.toString = -> 'byAttrStartsWithValue'

byAttrEndsWithValue = (node, data1, data2) ->
	if node instanceof Tag
		attr = node._attrs[data1]
		if typeof attr is 'string'
			return attr.indexOf(data2, attr.length - data2.length) > -1
	false
byAttrEndsWithValue.isIterator = false
byAttrEndsWithValue.toString = -> 'byAttrEndsWithValue'

byAttrContainsValue = (node, data1, data2) ->
	if node instanceof Tag
		attr = node._attrs[data1]
		if typeof attr is 'string'
			return attr.indexOf(data2) > -1
	false
byAttrContainsValue.isIterator = false
byAttrContainsValue.toString = -> 'byAttrContainsValue'

TYPE = /^#?[a-zA-Z0-9|\-:_]+/
DEEP = /^([ ]*)>([ ]*)|^([ ]+)/
ATTR_SEARCH = /^\[([^\]]+?)\]/
ATTR_VALUE_SEARCH = /^\[([^=]+?)=([^\]]+?)\]/
ATTR_CLASS_SEARCH = /^\.([a-zA-Z0-9|\-_]+)/

STARTS_WITH = /\^$/
ENDS_WITH = /\$$/
CONTAINS = /\*$/
TRIM_ATTR_VALUE = /(?:'|")?([^'"]*)/

i = 0
OPTS_QUERY_BY_PARENTS = 1<<(i++)
OPTS_REVERSED = 1<<(i++)
OPTS_ADD_ANCHOR = 1<<(i++)

queriesCache = []
getQueries = (selector, opts=0) ->
	reversed = !!(opts & OPTS_REVERSED)

	# get from the cache
	if r = queriesCache[opts]?[selector]
		return r

	distantTagFunc = if reversed then anyParent else anyDescendant
	closeTagFunc = if reversed then directParent else anyChild
	arrFunc = if reversed then 'unshift' else 'push'
	reversedArrFunc = if reversed then 'push' else 'unshift'

	funcs = []
	queries = [funcs]
	sel = selector.trim()
	while sel.length
		if sel[0] is '*'
			sel = sel.slice 1
			funcs[arrFunc] byInstance, Tag, null
		else if sel[0] is '&'
			sel = sel.slice 1
			unless opts & OPTS_QUERY_BY_PARENTS
				funcs[arrFunc] byTag, null, null
		else if exec = TYPE.exec(sel)
			sel = sel.slice exec[0].length
			name = exec[0]
			funcs[arrFunc] byName, name, null
		else if exec = ATTR_VALUE_SEARCH.exec(sel)
			sel = sel.slice exec[0].length
			[_, name, val] = exec
			val = TRIM_ATTR_VALUE.exec(val)[1]

			if STARTS_WITH.test(name)
				func = byAttrStartsWithValue
			else if ENDS_WITH.test(name)
				func = byAttrEndsWithValue
			else if CONTAINS.test(name)
				func = byAttrContainsValue
			else
				func = byAttrValue

			if func isnt byAttrValue
				name = name.slice 0, -1

			funcs[arrFunc] func, name, val
		else if exec = ATTR_SEARCH.exec(sel)
			sel = sel.slice exec[0].length
			funcs[arrFunc] byAttr, exec[1], null
		else if exec = ATTR_CLASS_SEARCH.exec(sel)
			sel = sel.slice exec[0].length
			funcs[arrFunc] byAttrContainsValue, 'class', exec[1]
		else if exec = DEEP.exec(sel)
			sel = sel.slice exec[0].length
			deep = exec[0].trim()
			if deep is ''
				funcs[arrFunc] distantTagFunc, null, null
			else if deep is '>'
				funcs[arrFunc] closeTagFunc, null, null
		else if sel[0] is ','
			funcs = []
			queries.push funcs
			sel = sel.slice 1
			sel = sel.trim()
		else
			throw new Error "queryAll: unexpected selector '#{sel}' in '#{selector}'"

	# set iterator
	for funcs in queries
		firstFunc = if reversed and not (opts & OPTS_QUERY_BY_PARENTS)
			funcs[funcs.length-3]
		else
			funcs[0]
		if firstFunc is byTag
			continue

		if opts & OPTS_QUERY_BY_PARENTS and not firstFunc?.isIterator
			funcs[arrFunc] distantTagFunc, null, null
		else if reversed and not firstFunc?.isIterator
			funcs[reversedArrFunc] distantTagFunc, null, null
		else if not reversed and not firstFunc?.isIterator
			funcs[reversedArrFunc] distantTagFunc, null, null

		if opts & OPTS_ADD_ANCHOR
			funcs[reversedArrFunc] byTag, null, null

	# save to the cache
	queriesCache[opts] ?= {}
	queriesCache[opts][selector] = queries

	queries

class Watcher extends signal.Emitter
	NOP = ->

	pool = []

	@watchers = []

	@create = (node, queries) ->
		if pool.length
			watcher = pool.pop()
			watcher.node = node
			watcher.queries = queries
			watcher.forceUpdate = true
		else
			watcher = new Watcher node, queries
			Watcher.watchers.push watcher
		watcher

	constructor: (@node, @queries) ->
		super()
		@uid = utils.uid()
		@nodes = []
		@forceUpdate = true
		Object.preventExtensions @

	signal.Emitter.createSignal @, 'onAdd'
	signal.Emitter.createSignal @, 'onRemove'

	test: (tag) ->
		for funcs in @queries
			funcs[funcs.length-2] = @node # set byTag anchor data1
			if test(tag, funcs, 0, NOP, null, true)
				return true
		false

	disconnect: ->
		assert.ok @node

		{uid, nodes} = @

		while node = nodes.pop()
			node._inWatchers[uid] = false
			emitSignal @, 'onRemove', node

		@onAdd.disconnectAll()
		@onRemove.disconnectAll()

		@node = @queries = null
		pool.push @
		return

module.exports = (Element, _Tag) ->
	Tag = _Tag
	Text = Element.Text

	getSelectorCommandsLength: module.exports.getSelectorCommandsLength

	queryAll: queryAll = (selector, target=[], targetCtx=target, opts=0) ->
		assert.isString selector
		assert.notLengthOf selector, 0
		unless typeof target is 'function'
			assert.isArray target

		queries = getQueries selector, opts
		func = if Array.isArray(target) then target.push else target

		for funcs in queries
			funcs[0] @, funcs, 3, func, targetCtx, false

		if Array.isArray(target)
			target

	queryAllParents: (selector, target, targetCtx) ->
		queryAll.call @, selector, target, targetCtx, OPTS_REVERSED | OPTS_QUERY_BY_PARENTS

	query: query = do ->
		result = null
		resultFunc = (arg) ->
			result = arg

		(selector, opts=0) ->
			assert.isString selector
			assert.notLengthOf selector, 0

			queries = getQueries selector, opts
			for funcs in queries
				if funcs[0](@, funcs, 3, resultFunc, null, true)
					return result

			null

	queryParents: (selector) ->
		query.call @, selector, OPTS_REVERSED | OPTS_QUERY_BY_PARENTS

	watch: (selector) ->
		assert.isString selector
		assert.notLengthOf selector, 0

		queries = getQueries selector, OPTS_REVERSED | OPTS_ADD_ANCHOR
		watcher = Watcher.create @, queries
		checkWatchersDeeply @
		watcher

	checkWatchersDeeply: checkWatchersDeeply = do ->
		pending = false

		i = 0
		CHECK_WATCHERS_THIS = 1 << i++
		CHECK_WATCHERS_CHILDREN = 1 << i++
		CHECK_WATCHERS_ALL = (1 << i++) - 1

		checkRec = (watcher, watcherUid, node, update) ->
			unless update & CHECK_WATCHERS_THIS
				update |= node._checkWatchers

			if update & CHECK_WATCHERS_THIS
				inWatchers = node._inWatchers
				if (not inWatchers or not inWatchers[watcherUid]) and watcher.test(node)
					# add in node
					unless inWatchers
						node._inWatchers = {}
					node._inWatchers[watcherUid] = true

					# add in watcher
					watcher.nodes.push node
					emitSignal watcher, 'onAdd', node
				else if inWatchers and inWatchers[watcherUid] and not watcher.test(node)
					# remove from node
					node._inWatchers[watcherUid] = false

					# remove from watcher
					utils.removeFromUnorderedArray watcher.nodes, node
					emitSignal watcher, 'onRemove', node

			# check recursively
			if update & CHECK_WATCHERS_CHILDREN and node instanceof Tag
				for child in node.children
					if update & CHECK_WATCHERS_THIS or child._checkWatchers
						checkRec watcher, watcherUid, child, update
			return

		clearRec = (node) ->
			node._checkWatchers = 0
			if node instanceof Tag
				for child in node.children
					if child._checkWatchers > 0
						clearRec child
			return

		isChildOf = (child, parent) ->
			tmp = child
			while tmp = tmp._parent
				if tmp is parent
					return true
			false

		updateWatcher = (watcher) ->
			# remove invalid nodes
			nodes = watcher.nodes
			watcherNode = watcher.node
			i = n = nodes.length
			while i-- > 0
				node = nodes[i]
				if node isnt watcherNode and not isChildOf(node, watcherNode)
					# remove from node
					node._inWatchers[watcher.uid] = false

					# remove from watcher
					nodes[i] = nodes[n-1]
					nodes.pop()
					emitSignal watcher, 'onRemove', node
					n--

			# find new nodes
			if watcher.forceUpdate
				checkRec watcher, watcher.uid, watcher.node, CHECK_WATCHERS_ALL
				watcher.forceUpdate = false
			else
				checkRec watcher, watcher.uid, watcher.node, 0

			return

		updateWatchers = ->
			pending = false
			{watchers} = Watcher

			for watcher in watchers
				if watcher.node
					updateWatcher watcher

			for watcher in watchers
				if watcher.node
					clearRec watcher.node
			return

		(node) ->
			tmp = node
			node._checkWatchers |= CHECK_WATCHERS_THIS
			while tmp = tmp._parent
				if tmp._checkWatchers & CHECK_WATCHERS_CHILDREN
					break
				tmp._checkWatchers |= CHECK_WATCHERS_CHILDREN

			unless pending
				setImmediate updateWatchers
				pending = true
			return

module.exports.getSelectorCommandsLength = (selector, beginQuery=0, endQuery=Infinity) ->
	sum = 0
	queries = getQueries selector, 0
	for query, i in queries
		if i < beginQuery
			continue
		if i >= endQuery
			break
		sum += query.length
	sum
