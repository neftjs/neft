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
	if elem.visible and elem.children
		elem.children.map(getOuterHTML).join("")
	else
		""

getOuterHTML = (elem) ->
	if elem.visible is false
		return

	if elem._text isnt undefined
		return elem._text

	if not elem.name or not isPublic(elem.name)
		return getInnerHTML elem

	nameRet = ret = "<" + elem.name
	if elem.attrsNames
		for attrName, i in elem.attrsKeys
			continue unless isPublic attrName
			attrValue = elem.attrsValues[i]
			continue if attrValue is undefined

			ret += " " + attrName
			unless attrValue?
				ret += "=\"\"" unless booleanAttribs[attrName]
			else
				ret += "=\"" + attrValue + "\""

	if elem.name is 'div' and ret is nameRet
		return getInnerHTML elem

	if SINGLE_TAG[elem.name]
		ret + ">"
	else
		ret + ">" + getInnerHTML(elem) + "</" + elem.name + ">"

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