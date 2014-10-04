'use strict'

module.exports = (impl) ->
	{Types, items, animations} = impl
	{Animation} = Types

	create: (id, target) ->
		Animation.create id, target

		target.target = ''
		target.property = ''
		target.duration = 1000
		target.from = null
		target.to = null

	getPropertyAnimationTarget: (id) ->
		animations[id].target

	setPropertyAnimationTarget: (id, val) ->
		animation = animations[id]
		animation.target = val
		if animation.from is null and animation.property
			animation.from = impl[impl.utils.GETTER_METHODS_NAMES[animation.property]] val

	getPropertyAnimationProperty: (id) ->
		animations[id].property

	setPropertyAnimationProperty: (id, val) ->
		animation = animations[id]
		animation.property = val
		if animation.from is null and animation.target
			animation.from = impl[impl.utils.GETTER_METHODS_NAMES[val]] animation.target

	getPropertyAnimationDuration: (id) ->
		animations[id].duration

	setPropertyAnimationDuration: (id, val) ->
		animations[id].duration = val

	getPropertyAnimationFrom: (id) ->
		animations[id].from

	setPropertyAnimationFrom: (id, val) ->
		animations[id].from = val

	getPropertyAnimationTo: (id) ->
		animations[id].to

	setPropertyAnimationTo: (id, val) ->
		animations[id].to = val
