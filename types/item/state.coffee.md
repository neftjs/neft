Item.States
===========

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

	List = require 'list'

	{isArray} = Array

	update = do ->
		queue = []
		queueItems = {}
		pending = false

		updateItem = (item) ->
			{state, states} = item

			# restore default state
			states[''].update item

			# apply states
			for stateElem in state.items()
				states[stateElem]?.update item

			null

		updateItems = ->
			pending = false
			while queue.length
				item = queue.pop()
				queueItems[item.__hash__] = false
				updateItem item
			null

		(item) ->
			if queueItems[item.__hash__]
				return

			queueItems[item.__hash__] = true
			queue.push item

			unless pending
				setImmediate updateItems
				pending = true

	support = (item, state) ->
		state = item.states[state]
		unless state
			return

		defaultState = item.states['']

		for name, val of state when state.hasOwnProperty(name)
			unless defaultState.hasOwnProperty name
				defaultState[name] = utils.clone(item[name]?._data or item[name])

		null

	stateInserted = (val, i) ->
		support @_item, val
		update @_item
		@_item.stateChanged? @

	statePopped = (oldVal, i) ->
		@_item.states[oldVal]?.restore @_item
		update @_item
		@_item.stateChanged? @

	module.exports = (Renderer, Impl, Item, itemUtils) ->

*List* Item::state
------------------

### Item::stateChanged(*List* list)

		itemUtils.defineProperty Item::, 'state', null, ((_super) -> ->
			if @_data.state is null
				list = @_data.state = new List()
				utils.defineProperty list, '_item', null, @

				list.onInserted stateInserted
				list.onChanged statePopped
				list.onPopped statePopped

			@_data.state

		), (_super) -> (val='') ->
			{state} = @

			state.clear()

			if val[0] is '['
				val = utils.tryFunction JSON.stringify, JSON, [val], val

			if typeof val is 'string'
				if val isnt ''
					state.append val
			else
				if val instanceof List
					val = val.items()

				if isArray(val)
					for elem in val
						state.append elem

			null

*List<Renderer.State>* Item::states
-----------------------------------

		utils.defineProperty Item::, 'states', utils.ENUMERABLE, ->
			val =
				'': new Renderer.State
			utils.defineProperty @, 'states', utils.ENUMERABLE, val
			val
		, (val) ->
			expect(val).toBe.simpleObject()
			utils.merge @states, val