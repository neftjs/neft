'use strict'

utils = require 'src/utils'
Dict = require 'src/dict'
List = require 'src/list'

evalFunc = new Function 'val', 'Dict', 'List', 'try { return eval(\'(\'+val+\')\'); } catch(err){}'

module.exports = (File) -> (file) ->
    {Tag} = File.Element
    {propsToParse} = file

    forNode = (elem) ->
        for name, val of elem.props when elem.props.hasOwnProperty(name)
            jsVal = evalFunc val, Dict, List
            if utils.isObject(jsVal)
                # create object each time the component is rendered
                propsToParse.push elem, name
            else if jsVal isnt undefined and String(jsVal).length is val.length
                # save parsed string values as literals;
                # e.g. 'true' -> true or '-2' -> -2
                # '+2' will not be parsed into 2 because both objects have different string length
                elem.props.set name, jsVal

        for child in elem.children
            if child instanceof Tag
                forNode child
        return

    forNode file.node
