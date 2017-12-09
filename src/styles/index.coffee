'use strict'

utils = require 'src/utils'
Document = require 'src/document'

require('./file/element') Document
Style = require('./style')

PROP_RESOURCES = module.exports.PROP_RESOURCES =
    img: ['src']

module.exports = (data) ->
    Document.Style = Style Document, data

    # support resources when stringifying
    {resources} = data
    replacements = Document.Element.Tag.DEFAULT_STRINGIFY_REPLACEMENTS

    for tagName, props of PROP_RESOURCES
        for prop in props
            _super = replacements[tagName] or utils.NOP
            replacements[tagName] = do (_super, prop) -> (elem) ->
                elem = _super(elem) or elem

                propVal = elem.props[prop]
                if propVal and rsc = resources.resolve(propVal)
                    elem.props.set prop, rsc

                elem

    Document.Style
