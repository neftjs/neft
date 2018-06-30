module.exports = (args) ->
    valueToString = (value) ->
        if typeof value is 'object' and value isnt null and not (value instanceof RegExp)
            result = try JSON.stringify(value)
        result or String value

    strings = (valueToString arg for arg in args)
    Array::join.call strings, ' '
