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
				self = @

				@changes = new ChangesObject
				@_name = utils.uid()
				super()

				setImmediate ->
					if self.target?.states.has(self.name)
						reloadItem self

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

				reloadItem @

				super()
				target.statesChanged states

		usedBindingsPool = []
		reloadItem = (state) ->
			assert.instanceOf state, State

			{target, name, changes} = state
			stateExtensions = target._stateExtensions
			states = target.states.items()
			defaultState = stateExtensions['']

			usedBindings = usedBindingsPool.pop() or Object.create(null)
			targetBindings = target._bindings
			bindingsUsed = false

			# set properties
			for prop, val of changes
				if utils.isObject(val) and utils.isObject(target[prop])
					# set deep property
					for subprop, subval of val
						newVal = defaultState[prop][subprop]
						if newVal is undefined
							newVal = defaultState[prop][subprop] = target[prop][subprop]

						for stateName in states by -1 when stateExtensions[stateName]?
							state = stateExtensions[stateName].changes
							if state.hasOwnProperty(prop) and state[prop].hasOwnProperty(subprop)
								newVal = state[prop][subprop]
								break
						target[prop][subprop] = newVal

					# set deep bindings
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

										target[prop].createBinding subprop, subval
										usedBindings[uniqueName] = true

						for subprop, subval of defaultBindings
							uniqueName = target[prop]._uniquePropertiesNames[subprop]
							unless usedBindings[uniqueName]
								target[prop].createBinding subprop, subval
				else
					# set main property
					newVal = defaultState[prop]
					if newVal is undefined
						newVal = defaultState[prop] = target[prop]

					for stateName in states by -1 when stateExtensions[stateName]?
						state = stateExtensions[stateName].changes
						if state.hasOwnProperty(prop)
							newVal = state[prop]
							break
					target[prop] = newVal

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

								target.createBinding prop, val
								usedBindings[prop] = true

				for prop, val of defaultBindings
					unless usedBindings[prop]
						target.createBinding prop, val

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
