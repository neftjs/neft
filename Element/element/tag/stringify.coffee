'use strict'

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

	if not elem.name or elem.name is 'unit'
		return getInnerHTML elem

	ret = "<" + elem.name
	if elem.attrsNames
		for attrName, i in elem.attrsKeys
			attrValue = elem.attrsValues[i]
			continue if attrValue is undefined

			ret += " " + attrName
			unless attrValue?
				ret += "=\"\"" unless attrName of booleanAttribs
			else
				ret += "=\"" + attrValue + "\""
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