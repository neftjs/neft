Rendering @engine
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
    y: parent.y // parent here refers to the column
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
	signal = require 'signal'
	Impl = require './impl'
	Impl.Renderer = exports

	itemUtils = require('./utils/item') exports, Impl
	signal.create exports, 'ready'

	exports.Screen = require('./types/namespace/screen') exports, Impl, itemUtils
	exports.Device = require('./types/namespace/device') exports, Impl, itemUtils
	exports.Navigator = require('./types/namespace/navigator') exports, Impl, itemUtils
	exports.RotationSensor = require('./types/namespace/sensor/rotation') exports, Impl, itemUtils

	exports.Extension = require('./types/extension') exports, Impl, itemUtils
	exports.Source = require('./types/extensions/source') exports, Impl, itemUtils
	exports.Class = require('./types/extensions/class') exports, Impl, itemUtils
	exports.Animation = require('./types/extensions/animation') exports, Impl, itemUtils
	exports.PropertyAnimation = require('./types/extensions/animation/types/property') exports, Impl, itemUtils
	exports.NumberAnimation = require('./types/extensions/animation/types/property/types/number') exports, Impl, itemUtils
	exports.Transition = require('./types/extensions/transition') exports, Impl, itemUtils

	exports.Item = require('./types/basics/item') exports, Impl, itemUtils
	exports.Image = require('./types/basics/item/types/image') exports, Impl, itemUtils
	exports.Text = require('./types/basics/item/types/text') exports, Impl, itemUtils
	exports.TextInput = require('./types/basics/item/types/text/input') exports, Impl, itemUtils

	exports.Rectangle = require('./types/shapes/rectangle') exports, Impl, itemUtils

	exports.Grid = require('./types/layout/grid') exports, Impl, itemUtils
	exports.Column = require('./types/layout/column') exports, Impl, itemUtils
	exports.Row = require('./types/layout/row') exports, Impl, itemUtils
	exports.Flow = require('./types/layout/flow') exports, Impl, itemUtils
	exports.Scrollable = require('./types/layout/scrollable') exports, Impl, itemUtils

	exports.Button = require('./types/complex/button') exports, Impl, itemUtils

	exports.AmbientSound = require('./types/sound/ambient') exports, Impl, itemUtils

	exports.ResourcesLoader = require('./types/loader/resources') exports, Impl, itemUtils
	exports.FontLoader = require('./types/loader/font') exports, Impl, itemUtils

#### Main style - view

**/styles/view.js** file is always available as a **view**.

It's created automatically on the bootstrap.

```
// styles/view.js
Rectangle {
  color: 'green'
  // width and height are not necessary, because this item is automatically resizing
}

// styles/button.js
Rectangle {
  width: 100; height: 50
  color: view.color // this value is also a binding
}
```

#### Custom properties and signals

Each [Renderer.Item][] type supports custom properties and signals.

Such properties can be used to store data and can be binded as well.

```style
Column {
\  id: main
\  property $.isActive: true
\
\  signal $.hide
\  $.onHide: function(delay){
\    var self = this;
\    setTimeout(function(){
\      self.$.isActive = false;
\    }, delay || 0);
\  }
\
\  pointer.onClicked: function(){
\    this.$.hide(100);
\  }
\
\  Rectangle {
\    width: 100; height: 100
\    color: main.$.isActive ? 'green' : 'red'
\  }
}
```

	utils.defineProperty exports, 'window', utils.CONFIGURABLE, null, (val) ->
		utils.defineProperty exports, 'window', utils.ENUMERABLE, val
		Impl.setWindow val

	utils.defineProperty exports, 'serverUrl', utils.WRITABLE, ''
	utils.defineProperty exports, 'resources', utils.WRITABLE, null

	exports.ready()

	Object.preventExtensions exports
