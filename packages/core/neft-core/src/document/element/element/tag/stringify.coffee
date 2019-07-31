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

isPublicTag = (name) ->
    name isnt '' and name isnt 'blank' and not /^(?:[A-Z]|n-)/.test(name)

isPublicProp = (name) ->
    not /^(?:n-|style:)/.test(name)

getInnerHTML = (elem, opts) ->
    if elem.children
        r = ''
        for child in elem.children
            r += getOuterHTML child, opts
        r
    else
        ''

getOuterHTML = (elem, opts) ->
    {includeInternals} = opts

    if elem._visible is false
        return ''

    if elem._text isnt undefined
        return elem._text

    {name} = elem
    skipTag = not name
    unless includeInternals
        skipTag or= not isPublicTag(name)
    if skipTag
        return getInnerHTML elem, opts

    ret = '<' + name
    {props} = elem
    for propName, propValue of props
        skipProp = not props.hasOwnProperty(propName)
        skipProp or= not propValue?
        skipProp or= typeof propValue is 'function'
        unless includeInternals
            skipProp or= not isPublicProp(propName)
        if skipProp
            continue

        ret += ' ' + propName + '="' + propValue + '"'

    innerHTML = getInnerHTML elem, opts
    if not innerHTML and SINGLE_TAG[name]
        ret + ' />'
    else
        ret + '>' + innerHTML + '</' + name + '>'

module.exports =
    getInnerHTML: getInnerHTML
    getOuterHTML: getOuterHTML
