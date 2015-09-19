'use strict'

utils = require 'utils'
signal = require 'signal'
assert = require 'neft-assert'

{emitSignal} = signal.Emitter

test = (node, funcs, index, targetFunc, targetCtx, single) ->
	while index < funcs.length
		func = funcs[index]

		if func.isIterator
			# console.log ' ', func+''
			return func node, funcs, index+3, targetFunc, targetCtx, single
		else
			data1 = funcs[index + 1]
			data2 = funcs[index + 2]
			# console.log '  ', func+'', data1, data2
			unless func(node, data1, data2)
				return false

		index += 3

	targetFunc.call targetCtx, node
	true

anyDescendant = (node, funcs, index, targetFunc, targetCtx, single) ->
	if children = node.children
		for child in children
			if child.name isnt 'neft:blank' and test(child, funcs, index, targetFunc, targetCtx, single)
				if single
					return true

			if child.children
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
	if children = node.children
		for child in children
			if child.name is 'neft:blank'
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
	node.name is data1
byName.isIterator = false
byName.toString = -> 'byName'

byTag = (node, data1) ->
	node is data1
byTag.isIterator = false
byTag.toString = -> 'byTag'

byAttr = (node, data1) ->
	node._attrs?[data1]?
byAttr.isIterator = false
byAttr.toString = -> 'byAttr'

byAttrValue = (node, data1, data2) ->
	if attrs = node._attrs
		val = attrs[data1]
		if typeof val is typeof data2
			val is data2
		else
			val+'' is data2+''
	else
		false
byAttrValue.isIterator = false
byAttrValue.toString = -> 'byAttrValue'

byAttrStartsWithValue = (node, data1, data2) ->
	node._attrs?[data1]?.indexOf?(data2) is 0
byAttrStartsWithValue.isIterator = false
byAttrStartsWithValue.toString = -> 'byAttrStartsWithValue'

byAttrEndsWithValue = (node, data1, data2) ->
	val = node._attrs?[data1]
	if typeof val is 'string'
		val.indexOf(data2, val.length - data2.length) isnt -1
	else
		false
byAttrEndsWithValue.isIterator = false
byAttrEndsWithValue.toString = -> 'byAttrEndsWithValue'

byAttrContainsValue = (node, data1, data2) ->
	node._attrs?[data1]?.indexOf?(data2) > -1
byAttrContainsValue.isIterator = false
byAttrContainsValue.toString = -> 'byAttrContainsValue'

TYPE = /^[a-zA-Z0-9|\-:_]+/
DEEP = /^([ ]*)>([ ]*)|^([ ]+)/
ATTR_SEARCH = /^\[([^\]]+?)\]/
ATTR_VALUE_SEARCH = /^\[([^=]+?)=([^\]]+?)\]/

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
		if reversed and not funcs[funcs.length-3]?.isIterator
			funcs[reversedArrFunc] distantTagFunc, null, null
		if not reversed and not funcs[0]?.isIterator
			funcs[reversedArrFunc] distantTagFunc, null, null
		else if opts & OPTS_QUERY_BY_PARENTS and not funcs[0]?.isIterator
			funcs[arrFunc] distantTagFunc, null, null

		if opts & OPTS_ADD_ANCHOR
			funcs[reversedArrFunc] byTag, null, null

	# save to the cache
	queriesCache[opts] ?= {}
	queriesCache[opts][selector] = queries

	queries

class Watcher extends signal.Emitter
	NOP = ->

	pool = []

	@create = (node, queries) ->
		if pool.length
			watcher = pool.pop()
			watcher.node = node
			watcher.queries = queries
		else
			watcher = new Watcher node, queries
		node._watchers ?= []
		node._watchers.push watcher
		watcher

	constructor: (@node, @queries) ->
		super()
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
		assert.ok utils.has(@node._watchers, @)

		@onAdd.disconnectAll()
		@onRemove.disconnectAll()
		index = @node._watchers.indexOf @
		@node._watchers[index] = null
		pool.push @
		return

module.exports = (Tag) ->
	queryAll: queryAll = (selector, target=[], targetCtx=target, opts=0) ->
		assert.isString selector
		assert.notLengthOf selector, 0
		unless typeof target is 'function'
			assert.isArray target

		queries = getQueries selector, opts
		func = if Array.isArray(target) then target.push else target

		for funcs in queries
			if funcs[0](@, funcs, 3, func, targetCtx, false)
				if single
					break

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

		queries = getQueries(selector, OPTS_REVERSED | OPTS_ADD_ANCHOR)
		watcher = Watcher.create @, queries
		watcher

	checkWatchersDeeply: checkWatchersDeeply = (tag) ->
		if inWatchers = tag._inWatchers
			i = n = inWatchers.length
			while i-- > 0
				unless inWatchers[i].test(tag)
					emitSignal inWatchers[i], 'onRemove', tag
					if i is n - 1
						inWatchers.pop()
					else
						inWatchers.splice i, 1
					n--

		tmp = tag
		while tmp = tmp._parent
			if watchers = tmp._watchers
				i = 0
				n = watchers.length
				while i < n
					watcher = watchers[i]
					if watcher is null
						watchers.splice i, 1
						i--; n--
					else if (not tag._inWatchers or !utils.has(tag._inWatchers, watcher)) and watcher.test(tag)
						tag._inWatchers ?= []
						tag._inWatchers.push watcher
						emitSignal watcher, 'onAdd', tag
					i++

		if tag.children
			for child in tag.children
				if child instanceof Tag
					checkWatchersDeeply child

		return
