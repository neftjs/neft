'use strict'

expect = require 'expect'
utils = require 'utils'
signal = require 'signal'
Dict = require 'dict'
List = require 'list'

module.exports = (Scope, Impl) -> class Item extends Dict
	@__name__ = 'Item'

	@SIGNALS = ['pointerClicked', 'pointerPressed', 'pointerReleased',
	            'pointerEntered', 'pointerExited', 'pointerWheel', 'pointerMove']

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

	ALL_HANDLERS = utils.arrayToObject Item.SIGNALS, (_, val) ->
		signal.getHandlerName val
	, -> true
	ALL_HANDLERS.onReady = true

	Anchors = require('./item/anchors') Scope, Impl
	Animations = require('./item/animations') Scope, Impl

	constructor: (@scope, opts, children) ->
		expect(opts).toBe.simpleObject()
		expect().defined(children).toBe.array()

		utils.defProp @, '_opts', '', utils.clone(opts)
		utils.defProp @, '_impl', '', {}

		# custom properties
		for key, val of opts
			if key of @
				continue

			Dict.defineProperty @, key

		super Object.create(@constructor.DATA)

		Impl.createItem @, @constructor.__name__

		# fill
		for key, val of opts
			if typeof opts[key] is 'function'
				@[key] val
			else
				@[key] = val

		# append children
		if children
			for child in children
				child.parent = @

	createBindedSetter = (propName, setFunc) ->
		(val) ->
			if Array.isArray val
				Impl.setItemBinding.call @, propName, val
			else
				setFunc.call @, val

	utils.defProp @::, 'id', 'e', ->
		undefined
	, (val) ->
		expect(val).toBe.truthy().string()
		utils.defProp @, 'id', 'e', val

	utils.defProp @::, 'scope', 'e', null, (val) ->
		expect(val).toBe.any Scope
		utils.defProp @, 'scope', 'e', val

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

	utils.defProp @::, 'children', 'e', ->
		val = Object.create(null)
		utils.defProp val, 'length', 'w', 0
		utils.defProp @, 'children', 'e', val
		val
	, (val) ->
		expect(val).toBe.array()
		for item in val
			val.parent = @
		null

	Dict.defineProperty @::, 'parent'

	utils.defProp @::, 'parent', 'e', utils.lookupGetter(@::, 'parent')
	, do (_super = utils.lookupSetter @::, 'parent') -> (val) ->
		if val?
			expect(val).toBe.any Item
			Array::push.call val.children, @
			childrenSetter.call val, val.children

		if old = @parent
			index = Array::indexOf.call old.children
			Array::splice.call old.children, index, 1
			childrenSetter.call old, old.children

		_super.call @, val
		Impl.setItemParent.call @, val

	Dict.defineProperty @::, 'visible'

	utils.defProp @::, 'visible', 'e', utils.lookupGetter(@::, 'visible')
	, do (_super = utils.lookupSetter @::, 'visible') -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val
		Impl.setItemVisible.call @, val

	Dict.defineProperty @::, 'clip'

	utils.defProp @::, 'clip', 'e', utils.lookupGetter(@::, 'clip')
	, do (_super = utils.lookupSetter @::, 'clip') -> (val) ->
		expect(val).toBe.boolean()
		_super.call @, val
		Impl.setItemClip.call @, val

	Dict.defineProperty @::, 'width'

	utils.defProp @::, 'width', 'e', utils.lookupGetter(@::, 'width')
	, do (_super = utils.lookupSetter @::, 'width') ->
		createBindedSetter 'width', (val) ->
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			_super.call @, val
			Impl.setItemWidth.call @, val

	Dict.defineProperty @::, 'height'

	utils.defProp @::, 'height', 'e', utils.lookupGetter(@::, 'height')
	, do (_super = utils.lookupSetter @::, 'height') ->
		createBindedSetter 'height', (val) ->
			expect(val).toBe.float()
			expect(val).not().toBe.lessThan 0
			_super.call @, val
			Impl.setItemHeight.call @, val

	Dict.defineProperty @::, 'x'

	utils.defProp @::, 'x', 'e', utils.lookupGetter(@::, 'x')
	, do (_super = utils.lookupSetter @::, 'x') ->
		createBindedSetter 'x', (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemX.call @, val

	Dict.defineProperty @::, 'y'

	utils.defProp @::, 'y', 'e', utils.lookupGetter(@::, 'y')
	, do (_super = utils.lookupSetter @::, 'y') ->
		createBindedSetter 'y', (val) ->
			expect(val).toBe.float()
			_super.call @, val
			Impl.setItemY.call @, val

	Dict.defineProperty @::, 'z'

	utils.defProp @::, 'z', 'e', utils.lookupGetter(@::, 'z')
	, do (_super = utils.lookupSetter @::, 'z') -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemZ.call @, val

	Dict.defineProperty @::, 'scale'

	utils.defProp @::, 'scale', 'e', utils.lookupGetter(@::, 'scale')
	, do (_super = utils.lookupSetter @::, 'scale') -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemScale.call @, val

	Dict.defineProperty @::, 'rotation'

	utils.defProp @::, 'rotation', 'e', utils.lookupGetter(@::, 'rotation')
	, do (_super = utils.lookupSetter @::, 'rotation') -> (val) ->
		expect(val).toBe.float()
		_super.call @, val
		Impl.setItemRotation.call @, val

	Dict.defineProperty @::, 'opacity'

	utils.defProp @::, 'opacity', 'e', utils.lookupGetter(@::, 'opacity')
	, do (_super = utils.lookupSetter @::, 'opacity') -> (val) ->
		expect(val).toBe.float()
		expect(val).not().toBe.lessThan 0
		expect(val).not().toBe.greaterThan 1
		_super.call @, val
		Impl.setItemOpacity.call @, val

	utils.defProp @::, 'anchors', 'e', ->
		utils.defProp @, 'anchors', 'e', val = new Anchors(@)
		val
	, (val) ->
		expect(val).toBe.simpleObject()
		utils.mergeDeep @anchors, val

	utils.defProp @::, 'animations', 'e', ->
		utils.defProp @, 'animations', 'e', val = new Animations(@)
		val
	, (val) ->
		expect(val).toBe.array()
		throw "Not implemented"

	clear: ->
		for child in @children
			child.parent = null
		@

	clone: (scope=@scope) ->
		expect(scope).toBe.any Scope

		clone = scope.create @constructor, @_opts
		clone.parent = if scope is @scope then @parent else null

		clone

	cloneDeep: (scope) ->
		clone = @clone scope

		for child, i in @children
			child = child.cloneDeep scope
			child.parent = clone

		clone