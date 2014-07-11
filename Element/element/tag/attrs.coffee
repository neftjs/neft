'use strict'

[expect] = ['expect'].map require

{isArray} = Array

exports.tag = null

exports.item = (i, target=[]) ->

	expect(target).toBe.array()

	keys = exports.tag.attrsKeys
	values = exports.tag.attrsValues

	target[0] = target[1] = undefined

	unless values
		return target

	while target[1] is undefined and keys.length >= i
		target[0] = keys[i]
		target[1] = values[i]
		i++

	target

exports.get = (name) ->

	expect(name).toBe.truthy().string()

	i = exports.tag.attrsNames?[name]
	return if i is undefined

	exports.tag.attrsValues[i]

exports.set = (name, value) ->

	expect(name).toBe.truthy().string()

	{tag} = exports

	i = tag.attrsNames?[name]
	return if i is undefined

	old = tag.attrsValues[i]
	return if old is value

	# save change
	tag.attrsValues[i] = value

	# call observers
	tag.onAttrChanged name, old

