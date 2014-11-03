'use strict'

expect = require 'expect'
utils = require 'utils'
signal = require 'signal'
Dict = require 'dict'
List = require 'list'

{isArray} = Array

module.exports = (Renderer, Impl, itemUtils) -> class Item extends Dict
	@__name__ = 'Item'
	@__path__ = 'Renderer.Item'

	@SIGNALS = ['pointerClicked', 'pointerPressed', 'pointerReleased',
	            'pointerEntered', 'pointerExited', 'pointerWheel', 'pointerMove']

	Margin = require('./item/margin') Renderer, Impl, itemUtils
	Anchors = require('./item/anchors') Renderer, Impl, itemUtils
	Animations = require('./item/animations') Renderer, Impl, itemUtils

	@DATA =
		parent: null
		clip: false
		visible: true
		x: 0
		y: 0
		z: 0
		width: 0
		height: 0
		rotation: 0
		scale: 1
		opacity: 1
		state: ''
		states: null
		anchors: Anchors.DATA
		margin: Margin.DATA

	constructor: (opts, children) ->
		# optional `opts` argument
		if arguments.length is 1 and isArray(opts)
			children = opts
			opts = undefined

		expect(@).toBe.any Item
		expect(arguments.length).not().toBe.greaterThan 2
		expect().defined(opts).toBe.simpleObject()
		expect().defined(children).toBe.array()

		# custom properties
		if opts?.properties?
			for propName in opts.properties
				itemUtils.defineProperty @, propName
			delete opts.properties

		# custom signals
		if opts?.signals?
			for signalName in opts.signals
				signal.create @, signalName
			delete opts.signals

		# initialization
		unless @hasOwnProperty '__hash__'
			utils.defProp @, '_impl', '', {}

			super Object.create(@constructor.DATA)
			Impl.createItem @, @constructor.__name__

		# fill
		if opts?
			# set properties
			for key, val of opts
				unless key of @
					throw "Unexpected property `#{key}`"

				if typeof val is 'function'
					continue

				itemUtils.setProperty @, key, val

			# connect handlers
			for key, val of opts
				unless key of @
					throw "Unexpected property `#{key}`"

				if typeof val is 'function'
					@[key].connect val

		# save opts object as a default state
		if opts?
			delete opts.state
			delete opts.states
			delete opts.animations

			for key, val of opts
				if typeof val is 'function'
					delete opts[key]

			if @states.hasOwnProperty ''
				utils.mergeDeep @states[''], opts
			else
				@states[''] = opts

		# append children
		if children
			for child in children
				child.parent = @

	utils.defProp @::, 'id', 'e', ->
		undefined
	, (val) ->
		expect(val).toBe.truthy().string()
		utils.defProp @, 'id', 'e', val

	readyLazySignal = signal.createLazy @::, 'ready'

	readyLazySignal.onInitialized (item) ->
		setImmediate -> item.ready()

	onLazySignalInitialized = (item, signalName) ->
		Impl.attachItemSignal.call item, signalName, item[signalName]

	for signalName in Item.SIGNALS
		lazySignal = signal.createLazy @::, signalName
		lazySignal.onInitialized onLazySignalInitialized

	Dict.defineProperty @::, 'children'
	childrenSetter = utils.lookupSetter @::, 'children'

	ChildrenObject = {}
	signal.createLazy ChildrenObject, 'inserted'
	signal.createLazy ChildrenObject, 'popped'

	utils.defProp @::, 'children', 'e', ->
		val = Object.create ChildrenObject
		utils.defProp val, 'length', 'w', 0
		utils.defProp @, 'children', 'e', val
		val
	, (val) ->
		expect(val).toBe.array()
		for item in val
			val.parent = @
		null

	itemUtils.defineProperty @::, 'parent', null, (_super) -> (val) ->
		if old = @parent
			index = Array::indexOf.call old.children, @
			Array::splice.call old.children, index, 1
			childrenSetter.call old, old.children
			old.children.popped? index, @

		if val?
			expect(val).toBe.any Item
			length = Array::push.call val.children, @
			childrenSetter.call val, val.children
			val.children.inserted? length - 1, @

		_super.call @, val
		Impl.setItemParent.call @, val

	itemUtils.defineProperty @::, 'visible', null, (_super) -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val
		Impl.setItemVisible.call @, val

	itemUtils.defineProperty @::, 'clip', null, (_super) -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val
		Impl.setItemClip.call @, val

	itemUtils.defineProperty @::, 'width', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemWidth.call @, val

	itemUtils.defineProperty @::, 'height', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemHeight.call @, val

	itemUtils.defineProperty @::, 'x', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemX.call @, val

	itemUtils.defineProperty @::, 'y', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemY.call @, val

	itemUtils.defineProperty @::, 'z', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemZ.call @, val

	itemUtils.defineProperty @::, 'scale', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemScale.call @, val

	itemUtils.defineProperty @::, 'rotation', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemRotation.call @, val

	itemUtils.defineProperty @::, 'opacity', null, (_super) -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemOpacity.call @, val

	itemUtils.defineProperty @::, 'state', null, (_super) -> (val) ->
		expect(val).toBe.string()
		expect().some().keys(@states).toBe val

		{DATA} = @.constructor
		defaultState = @states['']
		oldState = @states[@state]
		newState = @states[val]

		# break on no change
		if oldState is newState
			return

		# clear
		if oldState isnt defaultState
			for key, optVal of oldState
				switch optVal? and not isArray(optVal) and typeof optVal
					when 'function'
						@[key].disconnect optVal
					when 'object'
						utils.mergeDeep @[key], DATA[key]

						if defaultState.hasOwnProperty key
							utils.mergeDeep @[key], defaultState[key]
					else
						unless newState.hasOwnProperty key
							@[key] = defaultState[key] or DATA[key]

		# set new state
		for key, optVal of newState
			if typeof optVal is 'function'
					@[key].connect optVal
			else
				itemUtils.setProperty @, key, optVal

		_super.call @, val

	utils.defProp @::, 'states', 'e', ->
		utils.defProp @, 'states', 'e', val = {}
		val
	, null

	signal.createLazy @::, Dict.getPropertySignalName 'margin'

	utils.defProp @::, 'margin', 'e', ->
		utils.defProp @, 'margin', 'e', val = new Margin(@)
		val
	, null

	utils.defProp @::, 'anchors', 'e', ->
		utils.defProp @, 'anchors', 'e', val = new Anchors(@)
		val
	, null

	utils.defProp @::, 'animations', 'e', ->
		utils.defProp @, 'animations', 'e', val = new Animations(@)
		val
	, null

	defineProperty: (propName, defVal=null) ->
		itemUtils.defineProperty @, propName
		@_data[propName] = defVal
		@

	clear: ->
		for child in @children
			child.parent = null
		@

	clone: ->
		# TODO
		# expect(scope).toBe.any Renderer

		# clone = scope.create @constructor, @_opts
		# clone.parent = if scope is @scope then @parent else null

		# clone

	cloneDeep: ->
		# TODO
		# clone = @clone scope

		# for child, i in @children
		# 	child = child.cloneDeep scope
		# 	child.parent = clone

		# clone