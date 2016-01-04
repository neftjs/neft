Renderer integration
====================

To connect your view with the [Rendering][] engine, you need to use a [neft:style][]
attribute.

Using it, you can create style files or point to the id's from them.

Let's consider an example below.

```
// styles/place.js
Column {
\	Text {
\		id: heading
\		font.weight: 1
\		color: 'blue'
\	}
\
\	Rectangle {
\		margin.top: 15
\		width: parent.width
\		height: stats.height
\		color: 'gray'
\
\		Column {
\			id: stats
\		}
\	}
}

// styles/place/information.js
Row {
\	margin: 10
\
\	Text {
\		id: name
\		width: 50
\		font.weight: 0.8
\	}
\
\	Text {
\		id: value
\		color: '#444'
\	}
}

// documents/index.html
<neft:fragment neft:name="information" neft:style="styles:place/information">
  <dt neft:style="name">${name}</dt>
  <dd neft:style="value">${value}</dd>
</neft:fragment>

<article neft:style="styles:place">
  <h2 neft:style="heading">Paris</h2>
  <dl neft:style="stats">
    <neft:use neft:fragment="information" name="population" value="2,234,105" />
  </dl>
</article>
```

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

					attrVal = elem.attrs.get attr
					if attrVal and rsc = resources.resolve(attrVal)
						elem.attrs.set attr, rsc

					elem

		return
