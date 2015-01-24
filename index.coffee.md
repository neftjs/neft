Renderer
========

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

#### TODO

- Loader.Font
- Loader.Image
- UI.Column ...
- UI.Button
- Animation.Number
- Form.Select, Form.Input, Form.Textarea

.

	'use strict'

	utils = require 'utils'
	Impl = require './impl'

	itemUtils = require('./utils/item') exports, Impl

	exports.State = require('./types/state') exports, Impl, itemUtils

	exports.Item = require('./types/item') exports, Impl, itemUtils
	exports.Image = require('./types/item/types/image') exports, Impl, itemUtils
	exports.Text = require('./types/item/types/text') exports, Impl, itemUtils
	exports.Rectangle = require('./types/item/types/rectangle') exports, Impl, itemUtils

	exports.UI = require('./types/item/types/ui') exports, Impl, itemUtils

	exports.Animation = require('./types/animation') exports, Impl, itemUtils
	exports.PropertyAnimation = require('./types/animation/types/property') exports, Impl, itemUtils
	exports.NumberAnimation = require('./types/animation/types/property/types/number') exports, Impl, itemUtils

	exports.Transition = require('./types/transition') exports, Impl, itemUtils

	exports.FontLoader = require('./types/fontLoader') exports, Impl, itemUtils

	utils.defineProperty exports, 'window', utils.CONFIGURABLE, null, (val) ->
		utils.defineProperty exports, 'window', utils.ENUMERABLE, val
		Impl.setWindow val

	Object.preventExtensions exports
