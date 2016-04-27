'use strict'

Binding = require 'neft-binding'

module.exports = (impl) ->

	class RendererBinding extends Binding
		pool = []

		@factory = (obj, prop, binding, component, ctx) ->
			if elem = pool.pop()
				RendererBinding.call elem, obj, prop, binding, component, ctx
			RendererBinding.New obj, prop, binding, component, ctx, elem

		@New = (obj, prop, binding, component, ctx, target) ->
			target ?= new RendererBinding obj, prop, binding, component, ctx
			Binding.New binding, ctx, target
			target.update()
			target

		onComponentObjectChange = (id) ->
			for conn in @connections
				while conn.child
					conn = conn.child
				if conn.itemId is id
					conn.updateItem()
			return

		constructor: (@obj, @prop, binding, component, ctx) ->
			super binding, ctx
			@component = component
			@args = component.objectsOrder

			if @listensOnComponentObjectChange = @component.onObjectChange?
				@component.onObjectChange onComponentObjectChange, @

		getItemById: (item) ->
			if item is 'this'
				@ctx
			else if item is 'view'
				impl.Renderer.window
			else
				@component.objects[item] or impl.Renderer[item] or null

		getValue: ->
			@obj[@prop]

		setValue: (val) ->
			if not val? or val isnt val
				val = @getDefaultValue()
			@obj[@prop] = val
			return

		getLoopDetectedErrorMessage: ->
			"Potential loop detected. Property binding '#{@prop}' on '#{@item.toString()}' has been disabled."

		destroy: ->
			# remove from the list
			@obj._impl.bindings[@prop] = null

			if @listensOnComponentObjectChange
				@component.onObjectChange.disconnect onComponentObjectChange, @

			super()

			pool.push @
			return

	setItemBinding: (prop, binding, component, ctx) ->
		data = @_impl
		data.bindings ?= {}

		data.bindings[prop]?.destroy()

		if binding?
			data.bindings[prop] = RendererBinding.factory @, prop, binding, component, ctx

		return
