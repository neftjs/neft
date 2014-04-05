View Structure Element
=======================

*Element* as a collection of elements.

	'use strict'

	defineProp = Object.defineProperty
	isArray = Array.isArray

	[utils] = ['utils'].map require

	{assert} = console

*class* Element
----------------

	module.exports = (impl, modules) -> class Element

		@__name__ = 'Element'
		@__path__ = 'File.Element'

### Static

#### modules

		@modules = modules

#### *Element* fromHTML(*string*)

Create new *Element* instance based on *HTML*.
The whole structure will be returned.

		@fromHTML = (html) ->

			assert html and typeof html is 'string'

			elem = Element.factory()
			impl.parseHTML.call elem, html
			elem

#### *Element* factory()

Create new *Element* instance and fill it by the implementation.

		@factory = ->

			elem = new Element
			impl.factory.call elem
			elem

### Constructor

Constructor is instance of *Events* class, so after every initializing
*INIT* event is triggered.

		constructor: ->

			@children = []
			@attrs = new modules.Attrs @

### Properties

		Object.defineProperties @::,

#### name

Name of element as in *HTML*.
Only first set value will be saved.
It's *readonly* property.

			name:
				configurable: true
				set: (value) ->

					assert value and typeof value is 'string'

					defineProp @, 'name', value: value

#### *Array* children

List of all children. Don't edit this array.
Use `parent` property to manipulate children.

			children:
				value: null
				writable: true

#### *Element* parent

Link to other *Element*.
Value will automatically change `children`.

			_parent:
				value: null
				writable: true

			parent:

				get: -> @_parent

				set: (value) ->

					assert @ isnt value

					parent = @_parent

					if parent is value then return

					# remove element
					index = parent and parent.children.indexOf @
					if parent and ~index

						parent.children.splice index, 1
						impl.child.remove.call parent, @

					@_parent = parent = value

					# append element
					if parent and not ~parent.children.indexOf @

						parent.children.push @
						impl.child.append.call parent, @

#### *boolean* visible

			visible:

				get: ->

					visible = impl.visible.get.call @
					unless @parent then return true
					if visible then return @parent.visible
					visible

				set: (value) ->

					assert typeof value is 'boolean'

					if @visible is value then return

					impl.visible.set.call @, value

#### *number* index

Position of *Element* in the parent.
Can be changed.

			index:

				get: ->

					unless @parent then return undefined

					impl.index.get.call @

				set: (value) ->

					assert @parent
					assert typeof value is 'number'
					assert value >= 0 and isFinite value
					assert value < @parent.children.length

					impl.index.set.call @, value

#### *string* text

			text:

				get: -> impl.text.get.call @

				set: (value) ->

					value += ''

					# remove all children
					elem.parent = undefined while elem = @children[0]

					# set text
					impl.text.set.call @, value

#### *Attrs* attrs

Instance of *Attrs* class.

			attrs:
				value: null
				writable: true

### Methods

#### stringify()

Returns *Element* as *HTML* string.

			stringify: value: ->

				impl.stringify.call @

#### *Element* clone()

Returns new instance of *Element* with the same properties.

			clone: value: ->

				clone = new Element
				if @name then clone.name = @name

				impl.clone.call @, clone

				clone.visible = @visible

				clone

#### *Element* cloneDeep()

Returns cloned *Element* will all new instances of children.

			cloneDeep: value: ->

				clone = @clone()

				cloneChild = (child) ->

					clonedChild = child.cloneDeep()
					clonedChild.parent = clone

				@children.forEach cloneChild

				clone

#### *Element[]* queryAll()

			queryAll: value: (selector, target=[]) ->

				assert isArray target
				assert typeof selector is 'string'
				selector = selector.trim()
				assert selector

				impl.queryAll.call @, selector.trim(), target
				target

#### replace(*Element*, *Element*)

			replace: value: (oldElement, newElement) ->

				assert oldElement instanceof Element
				assert newElement instanceof Element
				assert oldElement.parent is @

				{children} = @

				# call impl
				impl.replace.call @, oldElement, newElement

				# update new element
				newElement._parent = oldElement._parent
				index = children.indexOf(newElement)
				if ~index then @children.splice index, 1

				# update children list
				children[children.indexOf(oldElement)] = newElement

				# update old element
				oldElement._parent = undefined

				null

#### getCopiedElement(*Element*, *Element*)

			getCopiedElement: value: do (tmp = []) -> (lookForElement, copiedParent) ->

				# get indexes to parent
				elem = lookForElement
				while elem.parent
					tmp.push elem.index
					elem = elem.parent
					break if elem is @

				# go by indexes in copied parent
				elem = copiedParent
				while tmp.length
					index = tmp.pop()
					elem = elem.children[index]

				elem
