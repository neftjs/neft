Rendering
=========

**Make things visible!**

This module is used to make things visible on the screen.

In opposite to the `View` module (which is only the logic part),
this module should define how to show and interact with elements.

Basic class used in this module is `Renderer.Item`.
It's a base for everything which can be rendered on the screen.

```nml,render
AppStructure {
	active: 'renderer'
}
```

.

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

	utils.defineProperty exports, 'window', utils.CONFIGURABLE, null, (val) ->
		utils.defineProperty exports, 'window', utils.ENUMERABLE, val
		Impl.setWindow val

	Object.preventExtensions exports
