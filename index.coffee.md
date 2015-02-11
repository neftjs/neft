Styles
======

**How to present informations?**

In *Neft* we have two important modules: `View` and `Renderer` which are using to
respectively organising data and visualize graphics.

This module is used to connect this two modules and render needed things with no
data and logic duplications.

```nml,include(Place)
Column {
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
\		Column {
\			id: stats
\		}
\	}
}
```

```nml,include(PlaceInformation)
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
\		font.color: '#444'
\	}
}
```

```view,example
<neft:fragment name="information" neft:style="PlaceInformation">
  <name neft:style="name">#{name}</name>
  <value neft:style="value">#{value}</value>
</neft:fragment>

<city neft:style="Place">
  <name neft:style="heading">Paris</name>
  <informations neft:style="stats">
    <neft:use neft:fragment="information" name="population" value="2,234,105" />
  </informations>
</city>
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
