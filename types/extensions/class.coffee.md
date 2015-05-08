Class @modifier
===============

	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	log = require 'log'
	List = require 'list'

	log = log.scope 'Rendering', 'Class'

*Class* Class()
---------------

	module.exports = (Renderer, Impl, itemUtils) ->
		class ChangesObject
			constructor: ->
				@_attributes = {}
				@_functions = []
				@_bindings = {}

			setAttribute: (prop, val) ->
				@_attributes[prop] = val
				return

			setFunction: (prop, val) ->
				@_functions.push prop, val
				return

			setBinding: (prop, val) ->
				@_attributes[prop] = val
				@_bindings[prop] = true
				return

		class Class extends Renderer.Extension
			@__name__ = 'Class'

			onReady = ->
				if @_name is '' and not @_bindings?.when
					@when = true
				else if @_running
					updateTargetClass enableClass, @_target, @
				return

			constructor: ->
				assert.lengthOf arguments, 0

				@_priority = 1
				@_name = ''
				@changes = new ChangesObject
				super()

				@onReady onReady

*String* Class::name
--------------------

This property is used in the [Renderer.Item::classes][] list to identify various classes.

It's a random string by default.

### *Signal* Class::nameChanged(*String* oldValue)

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
						if target.classes.has(name)
							@disable()
						target._classExtensions[name] = null
						target._classExtensions[val] = @

					if target and val
						target._classExtensions ?= {}

					_super.call @, val

					if target._classes?.has(val)
						@enable()
					return

*Renderer.Item* Class::target
-----------------------------

Reference to the [Renderer.Item][] on which this state has effects.

If state is created inside the [Renderer.Item][], this property is set automatically.

### *Signal* Class::targetChanged(*Renderer.Item* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'target'
				developmentSetter: (val) ->
					if val?
						assert.instanceOf val, Renderer.Item
				setter: (_super) -> (val) ->
					{target, name} = @

					if target is val
						return

					@disable()

					if name
						if target
							target._classExtensions[name] = null
						if val
							val._classExtensions ?= {}
							val._classExtensions[name] = @

					_super.call @, val

					if val
						if name
							@_target._classExtensions ?= {}
						if val._classes?.has(name) or @_when
							@enable()
					return

*Object* Class::changes
-----------------------

This objects contains all property changes brought by a state.

It accepts bindings as well.

*Float* Class::priority = 1
---------------------------

Default class has priority 0.

All inherited classes have pririty in range (0, 1).

			itemUtils.defineProperty
				constructor: @
				name: 'priority'
				defaultValue: 1
				setter: (_super) -> (val) ->
					assert.isFloat val
					_super.call @, val
					if @_target and @_running
						updateTargetClass disableClass, @_target, @
						updateClassList @_target
						updateTargetClass enableClass, @_target, @
					return

*Boolean* Class::when
---------------------

This boolean value indicates whether state is active or not.

When comes *true*, this state is appended on the end of the [Renderer.Item::classes][] list.

Mostly used with bindings.

#### Reduce grid columns on small screen @snippet

```
Grid {
\  columns: 2
\
\  // reduce to one column if the view width is lower than 500 pixels
\  Class {
\    when: view.width < 500
\    changes: {
\      columns: 1
\    }
\  }
}
```

### *Signal* Class::whenChanged(*Boolean* oldValue)

			enable: ->
				if @_running
					return

				if @_name and not @_target.classes.has(@_name)
					@_target.classes.append @_name
					return

				super()
				@_target._classList.unshift @
				updateClassList @_target
				updateTargetClass enableClass, @_target, @
				return

			disable: ->
				unless @_running
					return

				if @_name and @_target.classes.has(@_name)
					@_target.classes.remove @_name
					return

				super()
				updateTargetClass disableClass, @_target, @
				utils.remove @_target._classList, @
				return

		updateClassList = do ->
			sortFunc = (a, b) ->
				b._priority - a._priority
			(item) ->
				item._classList.sort sortFunc

		splitAttribute = do ->
			cache = Object.create null
			(attr) ->
				cache[attr] ?= attr.split '.'

		getObject = (item, path) ->
			len = path.length - 1
			i = 0
			while i < len
				unless item = item[path[i]]
					return null
				i++
			item

		setAttribute = (item, attr, val) ->
			path = splitAttribute attr
			if object = getObject(item, path)
				object[path[path.length - 1]] = val
			return

		###
		TODO: support deeper attributes properly
		e.g. margin doesn't restore margin.left
		and margin doesn't remove margin.left binding
		###
		enableClass = (item, classElem) ->
			assert.instanceOf item, Renderer.Item
			assert.instanceOf classElem, Class

			classList = item._classList
			classListIndex = classList.indexOf classElem
			assert.isNot classListIndex, -1

			{changes} = classElem
			attributes = changes._attributes
			bindings = changes._bindings
			functions = changes._functions

			# functions
			for attr, i in functions by 2
				path = splitAttribute attr
				object = getObject item, path
				`//<development>`
				if not object or typeof object?[path[path.length - 1]] isnt 'function'
					log.error "Handler '#{attr}' in '#{item.toString()}' doesn't exist"
				`//</development>`
				object?[path[path.length - 1]]? functions[i+1], item

			# attributes
			for attr, val of attributes
				writeAttr = true
				for i in [classListIndex-1..0] by -1
					if classList[i].changes._attributes.hasOwnProperty(attr)
						writeAttr = false
						break
				if writeAttr
					path = splitAttribute attr
					lastPath = path[path.length - 1]
					object = getObject item, path
					`//<development>`
					unless object
						log.error "Attribute '#{attr}' in '#{item.toString()}' doesn't exist"
					`//</development>`
					if bindings[attr]
						object?.createBinding lastPath, val
					else
						if object
							if object._bindings?[lastPath]
								object.createBinding lastPath, null
							object[lastPath] = val

			return

		EXTRA_RESTORE_ATTRS =
			__proto__: null
			left: { anchors: ['x'] }
			top: { anchors: ['y'] }
			right: { anchors: ['x'] }
			bottom: { anchors: ['y'] }
			horizontalCenter: { anchors: ['x'] }
			verticalCenter: { anchors: ['y'] }
			fill: { anchors: ['width', 'height'] }

		RESTORE_ATTRS_BLOCKED_BY =
			__proto__: null
			x: ['anchors.left', 'anchors.right', 'anchors.horizontalCenter']
			y: ['anchors.top', 'anchors.bottom', 'anchors.verticalCenter']
			width: ['anchors.fill']
			height: ['anchors.fill']

		restoreAttribute = (item, attr, omitClass) ->
			assert.instanceOf item, Renderer.Item
			assert.isString attr
			assert.instanceOf omitClass, Class if omitClass?

			# check whether it's not blocked
			if blockedAttrs = RESTORE_ATTRS_BLOCKED_BY[attr]
				for blockedAttr in blockedAttrs
					path = splitAttribute blockedAttr
					object = getObject item, path
					lastPath = path[path.length - 1]
					if object[lastPath]?
						return

			path = splitAttribute attr
			object = getObject item, path
			lastPath = path[path.length - 1]

			isBinding = false
			for classElem in item._classList
				if classElem isnt omitClass and classElem.changes._attributes.hasOwnProperty(attr)
					val = classElem.changes._attributes[attr]
					isBinding = !!classElem.changes._bindings[attr]
					break

			if val is undefined
				val = Object.getPrototypeOf(object)[lastPath]

			if isBinding
				object.createBinding lastPath, val
			else
				object[lastPath] = val
			return

		restoreExtraAttributes = (item, path, omitClass) ->
			index = path.length - 1
			obj = EXTRA_RESTORE_ATTRS
			while obj and not Array.isArray(obj)
				obj = obj[path[index]]
				index--
			if Array.isArray(obj)
				for attr in obj
					restoreAttribute item, attr, omitClass
			return

		disableClass = (item, classElem) ->
			assert.instanceOf item, Renderer.Item
			assert.instanceOf classElem, Class

			classList = item._classList
			classListIndex = classList.indexOf classElem
			classListLength = classList.length
			assert.isNot classListIndex, -1

			{changes} = classElem
			attributes = changes._attributes
			bindings = changes._bindings
			functions = changes._functions

			# functions
			for attr, i in functions by 2
				path = splitAttribute attr
				object = getObject item, path
				object?[path[path.length - 1]]?.disconnect functions[i+1], item

			# attributes
			for attr, val of attributes
				path = splitAttribute attr
				object = getObject item, path
				lastPath = path[path.length - 1]
				unless object
					continue

				restoreDefault = true
				for i in [classListIndex-1..0] by -1
					if classList[i].changes._attributes.hasOwnProperty(attr)
						restoreDefault = false
						break

				if restoreDefault
					defaultValue = undefined
					defaultIsBinding = false
					for i in [classListIndex+1...classListLength] by 1
						if classList[i].changes._attributes.hasOwnProperty(attr)
							defaultValue = classList[i].changes._attributes[attr]
							defaultIsBinding = !!classList[i].changes._bindings[attr]
							break
					if defaultValue is undefined
						defaultValue = Object.getPrototypeOf(object)[lastPath]

					if defaultIsBinding
						object.createBinding lastPath, defaultValue
					else
						object.createBinding lastPath, null
						object[lastPath] = defaultValue

					if EXTRA_RESTORE_ATTRS[lastPath]?
						restoreExtraAttributes item, path, classElem

			return

		runQueue = (target) ->
			classQueue = target._classQueue
			[func, target, classElem] = classQueue
			func target, classElem
			classQueue.shift()
			classQueue.shift()
			classQueue.shift()
			if classQueue.length > 0
				runQueue target
			return

		updateTargetClass = (func, target, classElem) ->
			classQueue = target._classQueue
			classQueue.push func, target, classElem
			if classQueue.length is 3
				runQueue target
			return

*Item* Item()
-------------

*List* Item::classes
--------------------

Mutable [List][] used to specify current [Renderer.Item][] classes.

One [Renderer.Item][] can have many classes.

Classs at the end have the highest priority.

This property has a setter, which accepts strings and arrays of strings.

### *Signal* Item::classesChanged(*List* classes)

		Renderer.onReady ->
			itemUtils.defineProperty
				constructor: Renderer.Item
				name: 'classes'
				defaultValue: null
				getter: do ->
					onChanged = (oldVal, index) ->
						onPopped.call @, oldVal, index
						onInserted.call @, @_classes.get(index), index
						@classesChanged @_classes
						return

					onInserted = (val, index) ->
						@_classExtensions[val]?.enable()
						@classesChanged @_classes
						return

					onPopped = (oldVal, index) ->
						unless @_classes.has(oldVal)
							@_classExtensions[oldVal]?.disable()
						@classesChanged @_classes
						return

					(_super) -> ->
						unless @_classes
							@_classExtensions ?= {}
							list = @_classes = new List
							list.onChanged onChanged, @
							list.onInserted onInserted, @
							list.onPopped onPopped, @

						_super.call @
				setter: (_super) -> (val) ->
					if typeof val is 'string'
						if val.indexOf(',') isnt -1
							val = val.split ','
						else
							val = val.split ' '

					classes = @_classes

					classes.clear()
					if Array.isArray(val)
						for name in val
							if name = name.trim()
								classes.append name
					return

		Class
