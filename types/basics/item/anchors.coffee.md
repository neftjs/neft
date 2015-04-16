Item/Anchors @extension
============

[Renderer.Item][] provides simply but powerful way to describe
relationships between items: **anchors**.

	'use strict'

	utils = require 'utils'
	log = require 'log'
	assert = require 'assert'
	signal = require 'signal'

	log = log.scope 'Renderer'

	H_LINE = 1<<0
	V_LINE = 1<<1

	LINE_REQ = 1<<0
	ONLY_TARGET_ALLOW = 1<<1
	H_LINE_REQ = 1<<2
	V_LINE_REQ = 1<<3
	FREE_H_LINE_REQ = 1<<4
	FREE_V_LINE_REQ = 1<<5

*Anchors* Anchors()
-------------------

*Anchors* allows to *pin* one item into another using one of the six anchor lines and two
special targets.

You can *stick* one item line into another.

```style
Item {
\  height: 100
\
\  Rectangle {
\    id: rect1
\    width: 100
\    height: 100
\    color: 'green'
\  }
\  
\  Rectangle {
\    width: 40
\    height: 40
\    color: 'red'
\    anchors.left: rect1.right
\  }
}
```

Left side of the *rect2* item now is anchored into the right side of the *rect1* item.

This connection is solid, so if the *rect1* will change a position,
*rect2* item will be automatically updated.

	H_LINES =
		top: true
		bottom: true
		verticalCenter: true

	V_LINES =
		left: true
		right: true
		horizontalCenter: true

	module.exports = (Renderer, Impl, itemUtils, Item) ->

		class Anchors extends itemUtils.DeepObject
			@__name__ = 'Anchors'

			constructor: (ref) ->
				@_top = null
				@_bottom = null
				@_verticalCenter = null
				@_left = null
				@_right = null
				@_horizontalCenter = null
				@_centerIn = null
				@_fill = null
				super ref

			createAnchorProp = (type, opts=0) ->
				setter = (_super) -> (val) ->
					if val?
						`//<development>`
						allowedLines = if H_LINES[type] then H_LINES else V_LINES

						unless Array.isArray(val) and val.length > 0 and val.length < 3
							log.error "`anchors.#{type}` expects an array; `'#{val}'` given"

						[target, line] = val

Item id in the anchor descriptor (*rect1* in *rect1.right*) is called a **target**.

A **parent** is a special type of the *target*.
It always refers to the item parent.

```style
Rectangle {
\  width: 100
\  height: 100
\  color: 'green'
\
\  Rectangle {
\    width: 40
\    height: 40
\    color: 'red'
\    anchors.left: parent.right
\  }
}
```

Such reference is also automatically updated if the item parent change.

						unless target is 'parent' or target is 'this' or target instanceof Item
							log.error "`anchors.#{type}` expects an item; `'#{val}'` given"

For the peformance reasons, the *target* could be only a *parent* or a *item sibling*.

Pointing to the *parent* by its id is not allowed, *parent* target should be used.

						# TODO: we need know scope id here
						# setImmediate ->
						# 	if target isnt 'parent'
						# 		parentA = Impl.getItemParent id
						# 		isFamily = Impl.confirmItemChild parentA, target
						# 		assert isFamily
						# 		, "`anchors.#{type}` can be anchored only to the " +
						# 		  "parent or a sibling"

						if opts & ONLY_TARGET_ALLOW
							unless line is undefined
								log.error "`anchors.#{type}` expects only a target to be defined; " +
								  "`'#{val}'` given;\npointing to the line is not required " +
								  "(e.g `anchors.centerIn = parent`)"

						if opts & LINE_REQ
							unless H_LINES[line] or V_LINES[line]
								log.error "`anchors.#{type}` expects a anchor line to be defined; " +
								  "`'#{val}'` given;\nuse one of the `#{Object.keys allowedLines}`"

Horizontal anchors can't point to the vertical lines (and vice versa),
so *anchors.top = parent.left* is not allowed.

						if opts & H_LINE_REQ
							unless H_LINES[line]
								log.error "`anchors.#{type}` can't be anchored to a vertical edge; " +
								  "`'#{val}'` given;\nuse one of the `#{Object.keys H_LINES}`"

						if opts & V_LINE_REQ
							unless V_LINES[line]
								log.error "`anchors.#{type}` can't be anchored to a horizontal edge; " +
								  "`'#{val}'` given;\nuse one of the `#{Object.keys V_LINES}`"
						`//</development>`

						if val[0] is 'this'
							val[0] = @

					_super.call @, val

*Signal* Item::anchorsChanged(*Anchors* anchors)
------------------------------------------------

This signal is called on the [Renderer.Item][] if one of it's anchors changed.

				itemUtils.defineProperty
					constructor: Anchors
					name: type
					defaultValue: null
					implementation: (val) ->
						Impl.setItemAnchor.call @, type, val
					namespace: 'anchors'
					parentConstructor: Item
					setter: setter

*Array* Anchors::left = null
----------------------------

			createAnchorProp 'left', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ

### *Signal* Anchors::leftChanged(*Array* oldValue)

*Array* Anchors::right = null
-----------------------------

			createAnchorProp 'right', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ

### *Signal* Anchors::rightChanged(*Array* oldValue)

*Array* Anchors::horizontalCenter = null
----------------------------------------

#### Anchor two items @snippet

```style
Item {
\  height: 100
\
\  Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
\  Rectangle {
\    color: 'red'; width: 40; height: 40
\    anchors.horizontalCenter: rect1.horizontalCenter
\  }
}
```

			createAnchorProp 'verticalCenter', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ

### *Signal* Anchors::horizontalCenterChanged(*Array* oldValue)

*Array* Anchors::top = null
---------------------------

```style
Item {
\  height: 100
\
\  Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
\  Rectangle {
\    color: 'red'; width: 40; height: 40
\    anchors.top: rect1.verticalCenter
\  }
}
```

			createAnchorProp 'top', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ

### *Signal* Anchors::topChanged(*Array* oldValue)

*Array* Anchors::bottom = null
------------------------------

			createAnchorProp 'bottom', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ

### *Signal* Anchors::bottomChanged(*Array* oldValue)

*Array* Anchors::verticalCenter = null
--------------------------------------

```style
Item {
\  height: 100
\
\  Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
\  Rectangle {
\    color: 'red'; width: 40; height: 40
\    anchors.verticalCenter: rect1.verticalCenter
\  }
}
```

			createAnchorProp 'horizontalCenter', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ

### *Signal* Anchors::verticalCenterChanged(*Array* oldValue)

*Array* Anchors::centerIn = null
--------------------------------

It's a shortcut for the *horizontalCenter* and *verticalCenter*.

Not target line is required.

#### Place a rectangle in the center of another @snippet

```style
Rectangle {
\  id: rect1
\  width: 100
\  height: 100
\  color: 'green'
\
\  Rectangle {
\    width: 40
\    height: 40
\    color: 'red'
\    anchors.centerIn: parent
\  }
}
```

### *Signal* Anchors::centerInChanged(*Array* oldValue)

*Array* Anchors::fill = null
----------------------------

Changes item position and its size to be always under the anchored target.

Not target line is required.

```style
Item {
\  height: 100
\
\  Rectangle { id: rect1; color: 'green'; width: 100; height: 100; }
\  Rectangle {
\    color: 'red'
\    opacity: 0.5
\    anchors.fill: rect1
\  }
}
```

### *Signal* Anchors::fillChanged(*Array* oldValue)

			createAnchorProp 'centerIn', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ
			createAnchorProp 'fill', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ

*Item* Item()
-------------

*Item.Anchors* Item::anchors
----------------------------

### *Signal* Item::anchorsChanged(*Item.Anchors* anchors)

		itemUtils.defineProperty
			constructor: Item
			name: 'anchors'
			valueConstructor: Anchors
			developmentSetter: (val) ->
				assert.isObject val
			setter: (_super) -> (val) ->
				{anchors} = @
				anchors.left = val.left if val.left?
				anchors.right = val.right if val.right?
				anchors.horizontalCenter = val.horizontalCenter if val.horizontalCenter?
				anchors.top = val.top if val.top?
				anchors.bottom = val.bottom if val.bottom?
				anchors.verticalCenter = val.verticalCenter if val.verticalCenter?
				anchors.centerIn = val.centerIn if val.centerIn?
				anchors.fill = val.fill if val.fill?
				_super.call @, val
				return

		Item::clone = do (_super = Item::clone) -> ->
			clone = _super.call @
			if @_anchors
				clone.anchors = @anchors
			clone

		Anchors
