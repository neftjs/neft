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
    name isnt 'blank' and not /^(?:n-|style:)/.test(name)

getInnerHTML = (elem) ->
    if elem.children
        r = ''
        for child in elem.children
            r += getOuterHTML child
        r
    else
        ''

getOuterHTML = (elem) ->
    if elem._visible is false
        return ''

    if elem._text isnt undefined
        return elem._text

    {name} = elem
    if not name or not isPublic(name)
        return getInnerHTML elem

    ret = '<' + name
    {props} = elem
    for propName, propValue of props
        if not props.hasOwnProperty(propName)
            continue
        if not propValue? or typeof propValue is 'function' or not isPublic(propName)
            continue

        ret += ' ' + propName + '="' + propValue + '"'

    innerHTML = getInnerHTML elem
    if not innerHTML and SINGLE_TAG[name]
        ret + ' />'
    else
        ret + '>' + innerHTML + '</' + name + '>'

module.exports =
    getInnerHTML: getInnerHTML
    getOuterHTML: getOuterHTML
