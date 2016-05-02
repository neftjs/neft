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
    {attrs} = elem
    for attrName, attrValue of attrs
        if not attrs.hasOwnProperty(attrName)
            continue
        if not attrValue? or typeof attrValue is 'function' or not isPublic(attrName)
            continue

        ret += " " + attrName + "=\"" + attrValue + "\""

    innerHTML = getInnerHTML elem, replacements
    if not innerHTML and SINGLE_TAG[name]
        ret + " />"
    else
        ret + ">" + innerHTML + "</" + name + ">"

module.exports =
    getInnerHTML: getInnerHTML
    getOuterHTML: getOuterHTML
