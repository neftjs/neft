View Structure Element
=======================

*Element* as a collection of elements.

	'use strict'

	defineProp = Object.defineProperty
	isArray = Array.isArray

	assert = require 'assert'
	utils = require 'utils/index.coffee.md'
	Events = require 'Events/index.coffee.md'

*class* Element
----------------

	module.exports = (impl, modules) -> class Element

### Static

#### Events

		@INIT = 'init'

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

			Element.trigger Element.INIT, @

		utils.merge @, new Events

### Properties

#### name

Name of element as in *HTML*.
Only first set value will be saved.
It's *readonly* property.

		@on @INIT, (self) -> defineProp self, 'name',

			configurable: true

			set: (value) ->

				assert value and typeof value is 'string'

				defineProp @, 'name', value: value

#### *Array* children

List of all children. Don't edit this array.
Use `parent` property to manipulate children.

		@on @INIT, (self) -> defineProp self, 'children', do (children=[]) ->

			get: -> children

#### *Element* parent

Link to other *Element*.
Value will automatically change `children`.

		@on @INIT, (self) -> defineProp self, 'parent', do (parent=null) ->

			get: -> parent

			set: (value) ->

				assert @ isnt value

				if parent is value then return

				# remove element
				index = parent and parent.children.indexOf @
				if parent and ~index

					parent.children.splice index, 1
					impl.child.remove.call parent, @

				parent = value

				# append element
				if parent and not ~parent.children.indexOf @

					parent.children.push @
					impl.child.append.call parent, @	

#### *number* index

Position of *Element* in the parent.
Can be changed.

		@on @INIT, (self) -> defineProp self, 'index',

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

		@on @INIT, (self) -> defineProp self, 'text',

			get: -> impl.text.get.call @

			set: (value) ->

				value += ''

				if text is value then return

				# remove all children
				elem.parent = undefined while elem = @children[0]

				# set text
				text = value
				impl.text.set.call @, value

#### *Attrs* attrs

Instance of *Attrs* class.

		@on @INIT, (self) -> defineProp self, 'attrs', value: new modules.Attrs self

### Methods

#### stringify()

Returns *Element* as *HTML* string.

		stringify: ->

			impl.stringify.call @

#### *Element* clone()

Returns new instance of *Element* with the same properties.

		clone: ->

			clone = new Element
			if @name then clone.name = @name

			impl.clone.call @, clone

			clone

#### *Element* cloneDeep()

Returns cloned *Element* will all new instances of children.

		cloneDeep: ->

			clone = @clone()

			cloneChild = (child) ->

				clonedChild = child.cloneDeep()
				clonedChild.parent = clone

			@children.forEach cloneChild

			clone

#### *Element[]* queryAll()

		queryAll: (selector, target=[]) ->

			assert isArray target
			assert typeof selector is 'string'
			selector = selector.trim()
			assert selector

			impl.queryAll.call @, selector.trim(), target
			target

#### replace(*Element*, *Element*)

		replace: (oldElement, newElement) ->

			assert oldElement instanceof Element
			assert newElement instanceof Element
			assert oldElement.parent is @

			impl.replace.call @, oldElement, newElement

			newElement.parent = oldElement.parent
			index = @children.indexOf(newElement)
			if ~index then @children.splice index, 1

			@children[@children.indexOf(oldElement)] = newElement
			oldElement.parent = undefined

			null