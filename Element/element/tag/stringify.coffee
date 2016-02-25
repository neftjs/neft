'use strict'

isPublic = (name) ->
	not /^(?:neft:|style:)/.test name

getInnerHTML = (elem, replacements) ->
	if elem.children
		r = ""
		for child in elem.children
			r += getOuterHTML child, replacements
		r
	else
		""

getOuterHTML = (elem, replacements) ->
	if elem._visible is false
		return ""

	if elem._text isnt undefined
		return elem._text

	if replacements and replacer = replacements[elem.name]
		elem = replacer(elem) or elem

	name = elem.name

	if not name or not isPublic(name)
		return getInnerHTML elem, replacements

	ret = "<" + name
	for attrName, attrValue of elem.attrs._data
		if not attrValue? or typeof attrValue is 'function' or not isPublic(attrName)
			continue

		ret += " " + attrName + "=\"" + attrValue + "\""

	if innerHTML = getInnerHTML(elem, replacements)
		ret + ">" + innerHTML + "</" + name + ">"
	else
		ret + " />"

module.exports =
	getInnerHTML: getInnerHTML
	getOuterHTML: getOuterHTML
