Rendering
=========

**Make things visible!**

In opposite to the [Document Modeling](/docs/document) (which is only the logical part),
this module defines how to render and interact with elements.

#### Item

Everything what is visible is an [Renderer.Item][].

#### Neft Meta Language

We introduced new language for describing styles and relationships between items: **NML**.

It looks very simple (very similar to the *QML*) and can be mixed with
**JavaScript**.

Why we do this? Let's say we need something more dynamic than **CSS** and less
restrictive than **JavaScript**.

Let's take a look at the example below:

```style
var RECT_SIZE = 50;

Rectangle {
\  width: 400
\  height: 200
\  border.width: 5
\  border.color: 'red'
\  onPointerMove: function(e){
\    greenRect.x = e.x - greenRect.width / 2;
\    greenRect.y = e.y - greenRect.height / 2;
\  }
\
\  Rectangle {
\    id: greenRect
\    width: RECT_SIZE
\    height: RECT_SIZE
\    color: 'green'
\  }
}
```

You can mix **JavaScript** with **NML** in the same file, you can access to the nested
properties just by using a dot (e.g. *border.width*) and items nesting looks intuitive
(rectangle with red border is a parent for the green one).

#### Bindings

One of the most important features in **NML** are **bindings**.

You can bind any [Renderer.Item][] property into the another using it's **id** or using
special target **parent**.

```style
Row {
  x: 10

  Rectangle {
    id: redRect
    color: 'red'
    width: 100
    height: 100
    rotation: 30 * Math.PI/180
  }

  Rectangle {
  	id: greenRect
    color: 'green'
    width: 100
    height: 100
    rotation: redRect.rotation / 2
  }

  Rectangle {
    color: 'yellow'
    width: 50
    height: 50
    rotation: Math.min(Math.PI / 8, Math.random() * Math.PI) // just a function
    x: parent.x // parent here refers to the column
  }
}
```

#### Working with styles

Each file in the **/styles** folder, we call a **style**.

You can extends other styles by using the **Styles** namespace.

```
// styles/button.js
Rectangle {
  width: 100
  height: 100
}

// styles/button/red.js
Styles.button {
  color: 'red'
}

// styles/button/red/border.js
Styles.button/red {
  border.width: 10
  border.color: 'red'
}
```

	'use strict'

	utils = require 'utils'
	Impl = require './impl'

	itemUtils = require('./utils/item') exports, Impl

	exports.State = require('./types/state') exports, Impl, itemUtils

	exports.Item = require('./types/basics/item') exports, Impl, itemUtils
	exports.Image = require('./types/basics/item/types/image') exports, Impl, itemUtils
	exports.Text = require('./types/basics/item/types/text') exports, Impl, itemUtils

	exports.Rectangle = require('./types/shapes/rectangle') exports, Impl, itemUtils

	exports.Grid = require('./types/layout/grid') exports, Impl, itemUtils
	exports.Column = require('./types/layout/column') exports, Impl, itemUtils
	exports.Row = require('./types/layout/row') exports, Impl, itemUtils
	exports.Scrollable = require('./types/layout/scrollable') exports, Impl, itemUtils

	exports.Animation = require('./types/animation') exports, Impl, itemUtils
	exports.Transition = require('./types/transition') exports, Impl, itemUtils

	exports.Loader = require('./types/loader') exports, Impl, itemUtils

#### Main style - windowStyle

**/styles/window.js** file is always available as a **windowStyle**.

It's created automatically on the bootstrap.

```
// styles/window.js
Rectangle {
  color: 'green'
  // window and height are not necessary, because this item is automatically resizing
}

// styles/button.js
Rectangle {
  width: 100; height: 50
  color: windowStyle.color // this value is also a binding
}
```

#### Custom properties and signals

Each [Renderer.Item][] type supports custom properties and signals.

Such properties can be used to store data and can be binded as well.

```style
Column {
\  id: main
\  property isActive: true
\
\  signal hide
\  onHide: function(delay){
\    var self = this;
\    setTimeout(function(){
\      self.isActive = false;
\    }, delay || 0);
\  }
\
\  onPointerClicked: function(){
\    this.hide(100);
\  }
\
\  Rectangle {
\    width: 100; height: 100
\    color: main.isActive ? 'green' : 'red'
\  }
}
```

	utils.defineProperty exports, 'window', utils.CONFIGURABLE, null, (val) ->
		utils.defineProperty exports, 'window', utils.ENUMERABLE, val
		Impl.setWindow val

	exports.serverUrl = ''

	Object.preventExtensions exports
