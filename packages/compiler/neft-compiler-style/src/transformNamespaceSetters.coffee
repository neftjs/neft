{ ATTRIBUTE_TYPE, forEachLeaf } = require './nmlAst'

NAMESPACES =
    margin: ['left', 'right', 'top', 'bottom']
    padding: ['left', 'right', 'top', 'bottom']
    alignment: ['horizontal', 'vertical']

isStringValue = (value) ->
    isString = value.startsWith("'") and value.endsWith("'")
    isString ||= value.startsWith('"') and value.endsWith('"')
    isString

transformMargin = (elem) ->
    isString = isStringValue(elem.value)
    isNumber = not isNaN(elem.value)

    if isString
        parts = elem.value.slice(1, -1).split(' ')
        if parts.every((str) -> not isNaN(str))
            parts = parts.map((str) -> parseFloat(str) || 0)
            switch parts.length
                when 1
                    left = top = right = bottom = parts[0]
                when 2
                    top = bottom = parts[0]
                    left = right = parts[1]
                when 3
                    top = parts[0]
                    left = right = parts[1]
                    bottom = parts[2]
                else
                    top = parts[0]
                    right = parts[1]
                    bottom = parts[2]
                    left = parts[3]
        else
            return []
    else if isNumber
        left = top = right = bottom = parseFloat(elem.value) || 0
    else
        top = elem.value
        left = right = bottom = "this.#{elem.name}.left"

    [
        { type: ATTRIBUTE_TYPE, name: "#{elem.name}.top", value: top },
        { type: ATTRIBUTE_TYPE, name: "#{elem.name}.right", value: right },
        { type: ATTRIBUTE_TYPE, name: "#{elem.name}.bottom", value: bottom },
        { type: ATTRIBUTE_TYPE, name: "#{elem.name}.left", value: left },
    ]

transformAlignment = (elem) ->
    isString = isStringValue(elem.value)

    if isString
        horizontal = vertical = elem.value
    else
        horizontal = elem.value
        vertical = 'this.alignment.horizontal'

    [
        { type: ATTRIBUTE_TYPE, name: "#{elem.name}.horizontal", value: horizontal },
        { type: ATTRIBUTE_TYPE, name: "#{elem.name}.vertical", value: vertical },
    ]

TRANSFORM_FUNCTIONS =
    margin: transformMargin
    padding: transformMargin
    alignment: transformAlignment

exports.transform = (ast) ->
    modify = []

    forEachLeaf
        ast: ast
        onlyType: ATTRIBUTE_TYPE
        includeValues: true
        deeply: true
    , (elem, parent) ->
        func = TRANSFORM_FUNCTIONS[elem.name]
        if func
            modify.push
                elem: elem
                parent: parent
        return

    modify.forEach ({ elem, parent }) ->
        func = TRANSFORM_FUNCTIONS[elem.name]
        elemIndex = parent.body.indexOf elem
        parent.body.splice elemIndex, 1, func(elem)...

    return
