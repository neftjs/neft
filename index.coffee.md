Styles
======

**Connect document and renderer**

In *Neft* we have two important modules: `View` and `Renderer` which are using to
respectively organising data and visualize graphics.

This module is used to connect this two modules and render needed things with no
data and logic duplications.

```
// styles/place.js
UI.Column {
\	Text {
\		id: heading
\		font.weight: 1
\		font.color: 'blue'
\	}
\
\	Rectangle {
\		margin.top: 15
\		width: parent.width
\		height: stats.height
\		color: 'gray'
\
\		UI.Column {
\			id: stats
\		}
\	}
}

// styles/place/information.js
UI.Row {
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
<neft:fragment neft:name="information" neft:style="styles.place/information">
  <dt neft:style="name">${name}</dt>
  <dd neft:style="value">${value}</dd>
</neft:fragment>

<article neft:style="styles.place">
  <h2 neft:style="heading">Paris</h2>
  <dl neft:style="stats">
    <neft:use neft:fragment="information" name="population" value="2,234,105" />
  </dl>
</article>
```

	'use strict'

	expect = require 'expect'
	Document = require 'document'

	stylesFuncs = require('./file/funcs')
	stylesStyles = require('./file/styles')
	stylesRender = require('./file/render')
	stylesStyle = require('./style')

	expect(Document).toBe.function()

	module.exports = (data) ->
		stylesFuncs Document
		stylesStyles Document
		stylesRender Document

		Document.Style = stylesStyle Document, data
