Item states
===========

	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	List = require 'list'

*State* State()
---------------

	module.exports = (Renderer, Impl, itemUtils) ->
		class DeepChangesObject
			utils.defineProperty @::, 'createBinding', null, (prop, val) ->
				unless @_bindings
					utils.defineProperty @, '_bindings', null, {}
				@_bindings[prop] = val
				return

		class ChangesObject extends DeepChangesObject
			utils.defineProperty @::, 'constructor', null, ChangesObject

		class State extends Renderer.Extension
			@__name__ = 'State'

			@supportObjectProperty = (propName) ->
				return if ChangesObject::hasOwnProperty propName

				utils.defineProperty ChangesObject::, propName, null, ->
					utils.defineProperty @, propName, utils.ENUMERABLE, val = new DeepChangesObject
					val
				, (val) ->
					utils.defineProperty @, propName, utils.ENUMERABLE, val

			constructor: ->
				assert.lengthOf arguments, 0

				@changes = new ChangesObject
				@_name = utils.uid()
				@_ready = false
				super()

				@onReady ->
					@_ready = true
					fillItemDefaultState @
					if @target?.states.has(@name)
						reloadItem @
					return

*String* State::name
--------------------

This property is used in the [Renderer.Item::states][] list to identify various states.

It's a random string by default.

### *Signal* State::nameChanged(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'name'
				developmentSetter: (val) ->
					assert.isString val
					assert.notLengthOf val, 0
				setter: (_super) -> (val) ->
					{target, name} = @

					if name is val
						return

					if target
						if target.states.has(name)
							@disable()
						target._stateExtensions[name] = undefined
						target._stateExtensions[val] = @

					_super.call @, val

					if target.states.has(val)
						@enable()

*Renderer.Item* State::target
-----------------------------

Reference to the [Renderer.Item][] on which this state has effects.

If state is created inside the [Renderer.Item][], this property is set automatically.

### *Signal* State::targetChanged(*Renderer.Item* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'target'
				setter: (_super) -> (val) ->
					{target, name} = @

					if target
						if target.states.has(name)
							@disable()
						target._stateExtensions[name] = undefined

					_super.call @, val

					if val
						if val._stateExtensions is undefined
							val._stateExtensions = {}
							val._stateExtensions[''] = new ChangesObject
						val._stateExtensions[name] = @

						if val.states.has(name)
							@enable()

*Object* State::changes
-----------------------

This objects contains all property changes brought by a state.

It accepts bindings as well.

*Boolean* State::when
---------------------

This boolean value indicates whether state is active or not.

When comes *true*, this state is appended on the end of the [Renderer.Item::states][] list.

Mostly used with bindings.

```
Grid {
\  columns: 2
\
\  // reduce to one column if the window width is lower than 500 pixels
\  State {
\    when: windowStyle.width < 500
\    changes: {
\      columns: 1
\    }
\  }
}
```

### *Signal* State::whenChanged(*Boolean* oldValue)

			enable: ->
				if @running
					return

				{target, name} = @

				assert.ok target._stateExtensions[name]

				unless target.states.has(name)
					target.states.append name
					return

				if @_ready
					reloadItem @

				super()
				target.statesChanged target.states

			disable: ->
				unless @running
					return

				{target, name, changes} = @
				{states} = target
				defaultState = target._stateExtensions['']

				if states.has(name)
					states.remove name
					return

				if @_ready
					reloadItem @

				super()
				target.statesChanged states

		getSafeValue = (val) ->
			if utils.isObject(val) and val.toJSON?
				val.toJSON()
			else
				val

		fillItemDefaultState = (state) ->
			{target, changes} = state
			stateExtensions = target._stateExtensions
			states = target.states.items()
			defaultState = stateExtensions['']

			# set main bindings
			if changes.hasOwnProperty('_bindings')
				for stateName in states by -1 when stateExtensions[stateName]?
					state = stateExtensions[stateName].changes
					if state.hasOwnProperty('_bindings')
						for prop of state._bindings
							unless defaultState.hasOwnProperty(prop)
								defaultState[prop] = getSafeValue target[prop]

			# set properties
			for prop, val of changes
				if utils.isObject(val) and utils.isObject(target[prop])
					# set deep binding
					if val.hasOwnProperty('_bindings')
						for stateName in states by -1 when stateExtensions[stateName]?
							state = stateExtensions[stateName].changes
							if state.hasOwnProperty(prop) and state[prop].hasOwnProperty('_bindings')
								for subprop, subval of state[prop]._bindings
									unless defaultState[prop].hasOwnProperty(subprop)
										defaultState[prop][subprop] = getSafeValue target[prop][subprop]

					# set deep property
					for subprop of val
						unless defaultState[prop].hasOwnProperty(subprop)
							defaultState[prop][subprop] = target[prop][subprop]
				else
					# set main property
					unless defaultState.hasOwnProperty(prop)
						defaultState[prop] = getSafeValue target[prop]

			return

		getPropValue = (item, prop) ->
			states = item.states.items()
			stateExtensions = item._stateExtensions

			for stateName in states by -1 when stateExtensions[stateName]?
				state = stateExtensions[stateName].changes
				if state.hasOwnProperty(prop)
					return state[prop]

			stateExtensions[''][prop]

		getDeepPropValue = (item, prop, subprop) ->
			states = item.states.items()
			stateExtensions = item._stateExtensions

			for stateName in states by -1 when stateExtensions[stateName]?
				state = stateExtensions[stateName].changes
				if state.hasOwnProperty(prop) and state[prop].hasOwnProperty(subprop)
					return state[prop][subprop]

			stateExtensions[''][prop][subprop]

		# TODO: support anchor in one state (restore default value)
		usedBindingsPool = []
		reloadItem = (state) ->
			assert.instanceOf state, State

			{target, changes} = state
			stateExtensions = target._stateExtensions
			states = target.states.items()
			defaultState = stateExtensions['']

			usedBindings = usedBindingsPool.pop() or Object.create(null)
			targetBindings = target._bindings
			bindingsUsed = false

			# set main bindings
			if changes.hasOwnProperty('_bindings')
				bindingsUsed = true
				defaultBindings = defaultState._bindings

				for stateName in states by -1 when stateExtensions[stateName]?
					state = stateExtensions[stateName].changes
					if state.hasOwnProperty('_bindings')
						for prop, val of state._bindings
							unless usedBindings[prop]
								defaultVal = targetBindings?[prop] or null
								if defaultBindings is undefined
									defaultState.createBinding prop, defaultVal
									defaultBindings = defaultState._bindings
								else if not defaultBindings.hasOwnProperty(prop)
									defaultBindings[prop] = defaultVal

								unless defaultState.hasOwnProperty(prop)
									defaultState[prop] = getSafeValue target[prop]

								target.createBinding prop, val
								usedBindings[prop] = true

				for prop, val of defaultBindings
					unless usedBindings[prop]
						target.createBinding prop, val
						target[prop] = getPropValue target, prop

			# set properties
			for prop, val of changes
				if utils.isObject(val) and utils.isObject(target[prop])
					# set deep binding
					if val.hasOwnProperty('_bindings')
						bindingsUsed = true
						defaultBindings = defaultState[prop]._bindings

						for stateName in states by -1 when stateExtensions[stateName]?
							state = stateExtensions[stateName].changes
							if state.hasOwnProperty(prop) and state[prop].hasOwnProperty('_bindings')
								for subprop, subval of state[prop]._bindings
									uniqueName = target[prop]._uniquePropertiesNames[subprop]
									unless usedBindings[uniqueName]
										defaultVal = targetBindings?[uniqueName] or null
										if defaultBindings is undefined
											defaultState[prop].createBinding subprop, defaultVal
											defaultBindings = defaultState[prop]._bindings
										else if not defaultBindings.hasOwnProperty(subprop)
											defaultBindings[subprop] = defaultVal

										unless defaultState[prop].hasOwnProperty(subprop)
											defaultState[prop][subprop] = getSafeValue target[prop][subprop]

										target[prop].createBinding subprop, subval
										usedBindings[uniqueName] = true

						for subprop, subval of defaultBindings
							uniqueName = target[prop]._uniquePropertiesNames[subprop]
							unless usedBindings[uniqueName]
								target[prop].createBinding subprop, subval
								target[prop][subprop] = getDeepPropValue target, prop, subprop

					# set deep property
					for subprop, subval of val
						uniqueName = target[prop]._uniquePropertiesNames[subprop]
						unless defaultState[prop].hasOwnProperty(subprop)
							defaultState[prop][subprop] = target[prop][subprop]
						newVal = getDeepPropValue target, prop, subprop

						if newVal isnt defaultState[prop][subprop] or (not target._bindings or not target._bindings[uniqueName])
							target[prop][subprop] = newVal
				else
					# set main property
					unless defaultState.hasOwnProperty(prop)
						defaultState[prop] = getSafeValue target[prop]
					newVal = getPropValue target, prop

					if newVal isnt defaultState[prop] or (not target._bindings or not target._bindings[prop])
						target[prop] = newVal

			# clear usedBindings
			if bindingsUsed
				for prop, val of usedBindings
					usedBindings[prop] = false
			usedBindingsPool.push usedBindings

			return

*Item* Item()
-------------

*List* Item::states
-------------------

Mutable [List][] used to specify current [Renderer.Item][] states.

One [Renderer.Item][] can have many states.

States at the end have the highest priority.

This property has a setter, which accepts strings and arrays of strings.

### *Signal* Item::statesChanged(*List* states)

		Renderer.onReady ->
			itemUtils.defineProperty
				constructor: Renderer.Item
				name: 'states'
				defaultValue: null
				getter: do ->
					onChanged = (oldVal, index) ->
						{states} = @
						unless @_stateExtensions
							return
						unless states.has(oldVal)
							@_stateExtensions[oldVal]?.disable()
						@_stateExtensions[states.get(index)]?.enable()

					onInserted = (val, index) ->
						unless @_stateExtensions
							return
						@_stateExtensions[@states.get(index)]?.enable()

					onPopped = (oldVal, index) ->
						unless @_stateExtensions
							return
						unless @states.has(oldVal)
							@_stateExtensions[oldVal]?.disable()

					(_super) -> ->
						unless @_states
							list = @_states = new List
							list.onChanged onChanged, @
							list.onInserted onInserted, @
							list.onPopped onPopped, @

						_super.call @
				setter: (_super) -> (val) ->
					unless Array.isArray(val)
						val = [val]

					{states} = @

					assert.isArray val
					states.clear()
					for name in val when name
						states.append name
					return

		State
