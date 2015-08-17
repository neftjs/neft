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
				boundFunc = (arg1, arg2) ->
					if @_component
						arr = @_component.objectsOrderSignalArr
						arr[arr.length - 2] = arg1
						arr[arr.length - 1] = arg2
						val.apply @_target, arr
					else
						val.call @_target, arg1, arg2
				@_functions.push prop, boundFunc
				return

			setBinding: (prop, val) ->
				@_attributes[prop] = val
				@_bindings[prop] = true
				return

		class Class extends Renderer.Extension
			@__name__ = 'Class'

			constructor: (component, opts) ->
				assert.instanceOf component, Renderer.Component

				@_priority = 0
				@_name = ''
				@_changes = null
				@_document = null
				super component, opts

*String* Class::name
--------------------

This property is used in the [Renderer.Item::classes][] list to identify various classes.

It's a random string by default.

### *Signal* Class::onNameChange(*String* oldValue)

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

					_super.call @, val

					if target
						if val
							target._classExtensions ?= {}

						if target._classes?.has(val)
							@enable()
					return

*Renderer.Item* Class::target
-----------------------------

Reference to the [Renderer.Item][] on which this state has effects.

If state is created inside the [Renderer.Item][], this property is set automatically.

### *Signal* Class::onTargetChange(*Renderer.Item* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'target'
				developmentSetter: (val) ->
					if val?
						assert.instanceOf val, itemUtils.Object
				setter: (_super) -> (val) ->
					{target, name} = @

					if target is val
						return

					@disable()

					if target
						utils.remove target._extensions, @
					if name
						if target
							target._classExtensions[name] = null
						if val
							val._classExtensions ?= {}
							val._classExtensions[name] = @

					_super.call @, val

					if val
						val._extensions.push @
						if name
							@_target._classExtensions ?= {}
						if val._classes?.has(name) or @_when
							@enable()
					return

*Object* Class::changes
-----------------------

This objects contains all property changes brought by a state.

It accepts bindings as well.

			utils.defineProperty @::, 'changes', null, ->
				@_changes ||= new ChangesObject
			, (obj) ->
				assert.isObject obj

				{changes} = @
				for prop, val of obj
					if typeof val is 'function'
						changes.setFunction prop, val
					else if Array.isArray(val) and val.length is 2 and typeof val[0] is 'function' and Array.isArray(val[1])
						changes.setBinding prop, val
					else
						changes.setAttribute prop, val
				return

*Float* Class::priority = 0
---------------------------

Default class has priority -1.

All inherited classes have priority in range (-1, 0).

### *Signal* Class::onPriorityChange(*Float* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'priority'
				defaultValue: 0
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

### *Signal* Class::onWhenChange(*Boolean* oldValue)

			enable: ->
				if @_running or not @_target or (@_document and @_document._query)
					return

				if @_name and not @_target.classes.has(@_name)
					@_target.classes.append @_name
					return

				super()
				updateTargetClass saveAndEnableClass, @_target, @
				return

			disable: ->
				if not @_running or not @_target
					return

				if @_name and @_target.classes.has(@_name)
					@_target.classes.remove @_name
					return

				super()
				updateTargetClass saveAndDisableClass, @_target, @
				return

			clone: (component) ->
				clone = cloneClassWithNoDocument.call @, component

				if query = @_document?._query
					clone.document.query = query

				clone

		cloneClassWithNoDocument = (component) ->
			clone = new Class component
			clone.id = @id
			clone._name = @_name
			clone._priority = @_priority
			clone._changes = @_changes

			if @_bindings
				for prop, val of @_bindings
					clone.createBinding prop, val, component

			clone

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

		saveAndEnableClass = (item, classElem) ->
			item._classList.unshift classElem
			updateClassList item
			enableClass item, classElem

		saveAndDisableClass = (item, classElem) ->
			disableClass item, classElem
			utils.remove item._classList, classElem

		###
		TODO: support deeper attributes properly
		e.g. margin doesn't restore margin.left
		and margin doesn't remove margin.left binding
		###
		enableClass = (item, classElem) ->
			assert.instanceOf item, itemUtils.Object
			assert.instanceOf classElem, Class

			classList = item._classList
			classListIndex = classList.indexOf classElem
			if classListIndex is -1
				return

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
				object?[path[path.length - 1]]? functions[i+1], classElem

			# attributes
			for attr, val of attributes
				writeAttr = true
				for i in [classListIndex-1..0] by -1
					if attr of classList[i].changes._attributes
						writeAttr = false
						break
				if writeAttr
					path = splitAttribute attr
					lastPath = path[path.length - 1]
					object = getObject item, path
					unless object
						log.error "Attribute '#{attr}' in '#{item.toString()}' doesn't exist"
						continue
					if bindings[attr]
						object.createBinding lastPath, val, classElem._component, item
					else
						if object._bindings?[lastPath]
							object.createBinding lastPath, null, classElem._component, item
						if val instanceof Renderer.Component.Link
							object[lastPath] = val.getItem classElem._component
						else
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
				object.createBinding lastPath, val, classElem._component, item
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
			assert.instanceOf item, itemUtils.Object
			assert.instanceOf classElem, Class

			classList = item._classList
			classListIndex = classList.indexOf classElem
			classListLength = classList.length
			if classListIndex is -1
				return

			{changes} = classElem
			attributes = changes._attributes
			bindings = changes._bindings
			functions = changes._functions

			# functions
			for attr, i in functions by 2
				path = splitAttribute attr
				object = getObject item, path
				object?[path[path.length - 1]]?.disconnect functions[i+1], classElem

			# attributes
			for attr, val of attributes
				path = splitAttribute attr
				object = getObject item, path
				lastPath = path[path.length - 1]
				unless object
					continue

				restoreDefault = true
				for i in [classListIndex-1..0] by -1
					# BUG: undefined on QML (potential Array::sort bug)
					unless classList[i]
						continue

					if attr of classList[i].changes._attributes
						restoreDefault = false
						break

				if restoreDefault
					defaultValue = undefined
					defaultIsBinding = false
					for i in [classListIndex+1...classListLength] by 1
						if attr of classList[i].changes._attributes
							defaultValue = classList[i].changes._attributes[attr]
							defaultIsBinding = !!classList[i].changes._bindings[attr]
							break
					if defaultValue is undefined
						defaultValue = Object.getPrototypeOf(object)[lastPath]

					if defaultIsBinding
						object.createBinding lastPath, defaultValue, classElem._component, item
					else
						object.createBinding lastPath, null, classElem._component, item
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

*Document* Class::document
--------------------------

		class ClassDocument extends itemUtils.DeepObject
			@__name__ = 'ClassDocument'

### *Signal* Class::onDocumentChange(*Document* document)

			itemUtils.defineProperty
				constructor: Class
				name: 'document'
				valueConstructor: @

*Document* Document()
---------------------

			onTargetChange = (oldVal) ->
				if oldVal
					oldVal.document.onNodeChange.disconnect @reloadQuery, @
				if val = @_ref._target
					val.document.onNodeChange @reloadQuery, @
				if oldVal isnt val
					@reloadQuery()
				return

			onPriorityChange = ->
				val = @_ref.priority

				for classElem in @_classesInUse
					classElem.priority = val
				for classElem in @_classesPool
					classElem.priority = val
				return

			constructor: (ref) ->
				@_query = ''
				@_parent = null
				@_classesInUse = []
				@_classesPool = []
				@_nodeWatcher = null
				super ref

				ref.onTargetChange onTargetChange, @
				onTargetChange.call @, ref._target

				ref.onPriorityChange onPriorityChange, @

*String* Document::query
------------------------

### *Signal* Document::onQueryChange(*String* oldValue)

			itemUtils.defineProperty
				constructor: @
				name: 'query'
				defaultValue: ''
				namespace: 'document'
				parentConstructor: ClassDocument
				developmentSetter: (val) ->
					assert.isString val
				setter: (_super) -> (val) ->
					assert.notOk @_parent

					if @_query is val
						return

					_super.call @, val
					@reloadQuery()
					return

			getChildClass = (style, parentClass) ->
				for classElem in style._classList
					if classElem._document?._parent is parentClass
						return classElem
				return

			connectNodeStyle = (style) ->
				unless classElem = @_classesPool.pop()
					classElem = cloneClassWithNoDocument.call @_ref, @_ref._component
					classElem.document._parent = @
					classElem.priority = @_ref._priority
				@_classesInUse.push classElem
				classElem.target = style
				if not classElem._bindings?.when
					classElem.enable()
				return

			disconnectNodeStyle = (style) ->
				classElem = getChildClass style, @
				classElem.target = null
				utils.remove @_classesInUse, classElem
				@_classesPool.push classElem
				return

			onNodeStyleChange = (oldVal, val) ->
				if oldVal
					disconnectNodeStyle.call @, oldVal
				if val
					connectNodeStyle.call @, val
				return

			onNodeAdd = (node) ->
				node.onStyleChange onNodeStyleChange, @
				onNodeStyleChange.call @, null, node.style
				return

			onNodeRemove = (node) ->
				node.onStyleChange.disconnect onNodeStyleChange, @
				if style = node._style
					disconnectNodeStyle.call @, style
				return

			reloadQuery: ->
				# remove old
				@_nodeWatcher?.disconnect()
				@_nodeWatcher = null
				while classElem = @_classesInUse.pop()
					classElem.target = null
					@_classesPool.push classElem

				# add new ones
				if (query = @_query) and (target = @_ref.target) and (node = target.document.node)
					node.queryAll query, onNodeAdd, @
					watcher = @_nodeWatcher = node.watch query
					watcher.onAdd onNodeAdd, @
					watcher.onRemove onNodeRemove, @
				return

*Item* Item()
-------------

*List* Item::classes
--------------------

Mutable [List][] used to specify current [Renderer.Item][] classes.

One [Renderer.Item][] can have many classes.

Classs at the end have the highest priority.

This property has a setter, which accepts strings and arrays of strings.

### *Signal* Item::onClassesChange(*List* classes)

		normalizeClassesValue = (val) ->
			if typeof val is 'string'
				if val.indexOf(',') isnt -1
					val = val.split ','
				else
					val = val.split ' '
			else if val instanceof List
				val = val.items()
			val

		class ClassesList extends List
			constructor: ->
				super()

			utils.defineProperty @::, 'append', null, do (_super = @::append) ->
				-> _super
			, (val) ->
				val = normalizeClassesValue val
				if Array.isArray(val)
					for name in val
						if name = name.trim()
							@append name
				return

			utils.defineProperty @::, 'remove', null, do (_super = @::remove) ->
				-> _super
			, (val) ->
				val = normalizeClassesValue val
				if Array.isArray(val)
					for name in val
						if name = name.trim()
							@remove name
				return

		Renderer.onReady ->
			itemUtils.defineProperty
				constructor: Renderer.Item
				name: 'classes'
				defaultValue: null
				getter: do ->
					onChange = (oldVal, index) ->
						onPop.call @, oldVal, index
						onInsert.call @, @_classes.get(index), index
						@onClassesChange.emit @_classes
						return

					onInsert = (val, index) ->
						@_classExtensions[val]?.enable()
						@onClassesChange.emit @_classes
						return

					onPop = (oldVal, index) ->
						unless @_classes.has(oldVal)
							@_classExtensions[oldVal]?.disable()
						@onClassesChange.emit @_classes
						return

					(_super) -> ->
						unless @_classes
							@_classExtensions ?= {}
							list = @_classes = new ClassesList
							list.onChange onChange, @
							list.onInsert onInsert, @
							list.onPop onPop, @

						_super.call @
				setter: (_super) -> (val) ->
					val = normalizeClassesValue val
					{classes} = @

					classes.clear()
					if Array.isArray(val)
						for name in val
							if name = name.trim()
								classes.append name
					return

		Class
