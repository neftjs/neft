Rendering
=========

**Make things visible!**

In opposite to the [Document Modeling](/docs/document) (which is only the logical part),
this module defines how to render and interact with elements.

Access it with:
```
var Renderer = require('renderer');
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

	utils.defineProperty exports, 'window', utils.CONFIGURABLE, null, (val) ->
		utils.defineProperty exports, 'window', utils.ENUMERABLE, val
		Impl.setWindow val

	Object.preventExtensions exports
