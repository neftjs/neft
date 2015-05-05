'use strict'

SINGLE_TAG =
	__proto__: null
	area: true
	base: true
	basefont: true
	br: true
	col: true
	command: true
	embed: true
	frame: true
	hr: true
	img: true
	input: true
	isindex: true
	keygen: true
	link: true
	meta: true
	param: true
	source: true
	track: true
	wbr: true

isPublic = (name) ->
	name.indexOf('neft:') isnt 0

getInnerHTML = (elem) ->
	if elem.children
		r = ""
		for child in elem.children
			r += getOuterHTML child
		r
	else
		""

getOuterHTML = (elem) ->
	if elem._visible is false
		return ""

	if elem._text isnt undefined
		return elem._text

	name = elem.name

	if not name or not isPublic(name)
		return getInnerHTML elem

	nameRet = ret = "<" + name
	for attrName, attrValue of elem._attrs
		if ///^neft:///.test(attrName)
			continue

		ret += " " + attrName
		unless attrValue?
			ret += "=\"\"" unless booleanAttribs[attrName]
		else
			ret += "=\"" + attrValue + "\""

	if name is 'div' and ret is nameRet
		return getInnerHTML elem

	if SINGLE_TAG[name]
		ret + ">"
	else
		ret + ">" + getInnerHTML(elem) + "</" + name + ">"

module.exports =
	getInnerHTML: getInnerHTML
	getOuterHTML: getOuterHTML

booleanAttribs =
	__proto__: null
	async: true
	autofocus: true
	autoplay: true
	checked: true
	controls: true
	defer: true
	disabled: true
	hidden: true
	loop: true
	multiple: true
	open: true
	readonly: true
	required: true
	scoped: true
	selected: true