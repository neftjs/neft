'use strict'

utils = require 'utils'
Document = require 'document'

styles = require('./file/styles')
Style = require('./style')

ATTR_RESOURCES = module.exports.ATTR_RESOURCES =
	img: ['src']

module.exports = (data) ->
	styles Document

	Document.Style = Style Document, data

	# support resources when stringifying
	{resources} = data
	replacements = Document.Element.Tag.DEFAULT_STRINGIFY_REPLACEMENTS

	for tagName, attrs of ATTR_RESOURCES
		for attr in attrs
			_super = replacements[tagName] or utils.NOP
			replacements[tagName] = do (_super, attr) -> (elem) ->
				elem = _super(elem) or elem

				attrVal = elem.getAttr attr
				if attrVal and rsc = resources.resolve(attrVal)
					elem.setAttr attr, rsc

				elem

	return
