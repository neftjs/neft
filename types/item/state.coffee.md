	'use strict'

	utils = require 'utils'
	assert = require 'assert'

	# update = do ->
	# 	queue = []
	# 	queueItems = {}
	# 	pending = false

	# 	updateItem = (item) ->
	# 		{state, states} = item

	# 		# restore default state
	# 		states[''].update item

	# 		# apply states
	# 		for stateElem in state.items()
	# 			states[stateElem]?.update item

	# 		null

	# 	updateItems = ->
	# 		pending = false
	# 		while queue.length
	# 			item = queue.pop()
	# 			queueItems[item.__hash__] = false
	# 			updateItem item
	# 		null

	# 	(item) ->
	# 		if queueItems[item.__hash__]
	# 			return

	# 		queueItems[item.__hash__] = true
	# 		queue.push item

	# 		unless pending
	# 			setImmediate updateItems
	# 			pending = true

	support = (item, state) ->
		state = item.states[state]
		unless state
			return

		defaultState = item.states['']

		for name, val of state
			unless defaultState.hasOwnProperty name
				defaultState[name] = utils.clone(item[name]?._data or item[name])

		null

	module.exports = (Renderer, Impl, Item, itemUtils) ->

*String* Item::state
--------------------

### *Signal* Item::stateChanged(*List* list)

		itemUtils.defineProperty
			constructor: Item
			name: 'state'
			setter: (_super) -> (val='') ->
				assert.isString val
				if @state is val
					return

				Renderer.State.restore @states[@state], @

				_super.call @, val

				support @, val
				Renderer.State.update @states[val], @

*Object* Item::states
---------------------

		itemUtils.defineProperty
			constructor: Item
			name: 'states'
			getter: (_super) -> ->
				@_data.states ?=
					'': new Renderer.State @
				_super.call @
			setter: (_super) -> (val) ->
				assert.isPlainObject val
				{states} = @

				# remove old
				for key of states
					if key isnt ''
						delete states[key]

				# merge new ones
				utils.merge states, val

				# call signal
				@statesChanged? states

				# update current state
				if val[@state]
					@state = @state
				else unless states[@state]
					@state = ''
