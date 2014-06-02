View Structure Element
=======================

*Element* as a collection of elements.

	'use strict'

	[utils, expect, Emitter] = ['utils', 'expect', 'emitter'].map require

	{isArray} = Array

*class* Element
----------------

	module.exports = (impl, modules) -> class Element extends Emitter

		@__name__ = 'Element'
		@__path__ = 'File.Element'

### Events

		@CHILD_APPEND = 'childAppend'
		@CHILD_REMOVE = 'childRemove'
		@TEXT_CHANGE = 'textChange'
		@VISIBILITY_CHANGE = 'visibilityChange'

### Static

#### modules

		@modules = modules

#### *Element* fromHTML(*String*)

Create new *Element* instance based on *HTML*.
The whole structure will be returned.

		@fromHTML = (html) ->

			expect(html).toBe.truthy().string()

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

			super

			utils.defProp @, 'children', 'e', []
			utils.defProp @, 'attrs', 'e', new modules.Attrs @
			utils.defProp @, '_parent', 'ew', null

### Properties

		Object.defineProperties @::,

#### name

Name of element as in *HTML*.
Only first set value will be saved.
It's *readonly* property.

			name:
				set: (value) ->

					expect(value).toBe.truthy().string()

					utils.defProp @, 'name', 'e', value

#### *Array* children

List of all children. Don't edit this array.
Use `parent` property to manipulate children.

			children:
				value: null
				writable: true

#### *Element* parent

Link to other *Element*.
Value will automatically change `children`.

			parent:

				get: -> @_parent

				set: (value) ->

					expect(@).not().toBe value

					parent = @_parent

					return if parent is value

					# remove element
					index = parent and parent.children.indexOf @
					if parent and ~index

						parent.trigger Element.CHILD_REMOVE, @
						parent.children.splice index, 1
						impl.child.remove.call parent, @

					@_parent = parent = value

					# append element
					if parent and not ~parent.children.indexOf @

						parent.trigger Element.CHILD_APPEND, @
						parent.children.push @
						impl.child.append.call parent, @

#### *Boolean* visible

			visible:

				get: ->

					impl.visible.get.call @

				set: (value) ->

					expect(value).toBe.boolean()

					return if @visible is value

					impl.visible.set.call @, value
					@trigger Element.VISIBILITY_CHANGE, value

					for child in @children
						child.visible = value

#### *Number* index

Position of *Element* in the parent.
Can be changed.

			index:

				get: ->

					unless @parent then return undefined

					impl.index.get.call @

				set: (value) ->

					expect(@parent).toBe.truthy()
					expect(value).toBe.integer()
					expect(value >= 0).toBe.truthy()
					expect(value < @parent.children.length).toBe.truthy()

					impl.index.set.call @, value

#### *String* text

			text:

				get: -> impl.text.get.call @

				set: (value) ->

					expect(value).toBe.string()

					# remove all children
					elem.parent = undefined while elem = @children[0]

					# set text
					impl.text.set.call @, value

					# trigger event
					@trigger Element.TEXT_CHANGE

#### *Attrs* attrs

Instance of *Attrs* class.

			attrs:
				value: null
				writable: true

### Methods

#### *String* stringify()

Returns *Element* as *HTML* string.

			stringify: value: ->

				impl.stringify.call @

#### *String* stringifyChildren()

Returns all children as *HTML* string.

			stringifyChildren: value: ->

				impl.stringifyChildren.call @

#### *Element* clone()

Returns new instance of *Element* with the same properties.

			clone: value: ->

				clone = Object.create @
				Element.call clone

				impl.clone.call @, clone

				clone

#### *Element* cloneDeep()

Returns cloned *Element* will all new instances of children.

			cloneDeep: value: ->

				clone = @clone()

				for child in @children
					clonedChild = child.cloneDeep()
					clonedChild.parent = clone

				clone

#### *Element[]* queryAll()

			queryAll: value: (selector, target=[]) ->

				expect(target).toBe.array()
				expect(selector).toBe.string()

				return target unless @children

				selector = selector.trim()
				expect(selector).toBe.truthy()

				impl.queryAll.call @, selector.trim(), target

				target

#### replace(*Element*, *Element*)

			replace: value: (oldElement, newElement) ->

				expect(oldElement).toBe.any Element
				expect(newElement).toBe.any Element
				expect(oldElement.parent).toBe @

				{children} = @

				# call impl
				impl.replace.call @, oldElement, newElement

				# trigger events
				@trigger Element.CHILD_REMOVE, oldElement
				@trigger Element.CHILD_APPEND, newElement

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
