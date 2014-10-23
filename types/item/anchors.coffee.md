Item Anchors
============

`Item` provides simply but powerful way to describe
relationships between items: ***anchors***.

	'use strict'

	utils = require 'utils'
	expect = require 'expect'

	Impl = require '../../impl'

	{assert} = console

	H_LINE = 1<<0
	V_LINE = 1<<1

	LINE_REQ = 1<<0
	ONLY_TARGET_ALLOW = 1<<1
	H_LINE_REQ = 1<<2
	V_LINE_REQ = 1<<3
	FREE_H_LINE_REQ = 1<<4
	FREE_V_LINE_REQ = 1<<5

*Anchors* allows to *pin* one item into another using one of the 6 ***anchor lines***.

Three horizontal lines:
 * *top*
 * *bottom*
 * *verticalCenter*

	H_LINES =
		top: true
		verticalCenter: true
		bottom: true

And three vertical lines:
 * *left*
 * *right*
 * *horizontalCenter*

	V_LINES =
		left: true
		horizontalCenter: true
		right: true

	`//<development>`
	itemsAnchors = {}
	`//</development>`

	exports.currentItem = null

	exports.Anchors = Anchors = {}

	splitAnchorValue = (val) ->
		dot = val.indexOf '.'
		if dot is -1
			dot = val.length

		target = val.slice 0, dot
		line = val.slice dot+1

		[target, line]

```coffeescript
Renderer.Rectangle.create
    id: 'rect1'
    ...

Renderer.Rectangle.create
    id: 'rect2'
    anchors:
        left: 'rect1.right'
    ...
```

Left side of the *rect2* item now is anchored into the right side of the *rect1* item.

This connection is updated in realtime, so if the *rect1* will change a position,
*rect2* item will be automatically updated.

	createAnchorProp = (type, opts=0) ->
		utils.defProp Anchors, type, 'e', null, (val) ->
			id = exports.currentItem._uid

			if val?
				[target, line] = splitAnchorValue val

			`//<development>`
			if val?
				allowedLines = if H_LINES[type] then H_LINES else V_LINES
				itemsAnchors[id] ?= 0

				assert typeof val is 'string' and val.length
				, "`(##{id}).anchors.#{type}` expects a string (e.g. `'parent.left'`); " +
				  "`'#{val}'` given"

Item id in the anchor descriptor (*rect1* in *rect1.right*) is called a ***target***.

A *parent* is a special type of the *target*.
It refers always to the item parent.

```coffeescript
Renderer.Rectangle.create
    id: 'rect1'
    ...

Renderer.Rectangle.create
    id: 'rect2'
	parent: 'rect1'
    anchors:
        left: 'parent.right'
    ...
```

Such reference is automatically updated if the item parent change.

```coffeescript
rect2 = Renderer.Rectangle.open 'rect2'
rect2.parent = Renderer.window
rect2.close()
```

				assert target.length
				, "`(##{id}).anchors.#{type}` expects a target; `'#{val}'` given;\n" +
				  "specify an item id or `parent` (e.g `anchors.left = 'parent.right'`)"

For the peformance reasons, the *target* could be only a *parent* or a ***item sibling***.

Pointing to the *parent* by its id is not allowed, `parent` special *target* should be used.

				# TODO: we need know scope id here
				# setImmediate ->
				# 	if target isnt 'parent'
				# 		parentA = Impl.getItemParent id
				# 		isFamily = Impl.confirmItemChild parentA, target
				# 		assert isFamily
				# 		, "`(##{id}).anchors.#{type}` can be anchored only to the " +
				# 		  "parent or a sibling"

*Anchors* also provies two ***special anchors***: *centerIn* and *fill*.

*centerIn* is a shortcut for the *horizontalCenter* and *verticalCenter*.

*fill* changes the item position and its size to be always under the anchored target.

Such anchors doesn't require specifing the anchor line, so only the *target* is expected.

```coffeescript
Renderer.Rectangle.create
    id: 'rect1'
    ...

Renderer.Rectangle.create
    anchors:
        fill: 'rect1'
    ...
```

				if opts & ONLY_TARGET_ALLOW
					assert line.length is 0
					, "`(##{id}).anchors.#{type}` expects only a target to be defined; " +
					  "`'#{val}'` given;\npointing to the line is not required " +
					  "(e.g `anchors.centerIn = 'parent'`)"

				if opts & LINE_REQ
					assert H_LINES[line] or V_LINES[line]
					, "`(##{id}).anchors.#{type}` expects a anchor line to be defined; " +
					  "`'#{val}'` given;\nuse one of the `#{Object.keys allowedLines}`"

Horizontal anchors can't point to the vertical lines (and vice versa),
so `anchors.top = 'parent.left'` is not allowed.

				if opts & H_LINE_REQ
					assert H_LINES[line]
					, "`(##{id}).anchors.#{type}` can't be anchored to a vertical edge; " +
					  "`'#{val}'` given;\nuse one of the `#{Object.keys H_LINES}`"

				if opts & V_LINE_REQ
					assert V_LINES[line]
					, "`(##{id}).anchors.#{type}` can't be anchored to a horizontal edge; " +
					  "`'#{val}'` given;\nuse one of the `#{Object.keys V_LINES}`"

Second, and the last restriction says that only one *horizontal* and one *vertical anchor*
can be set in the *item*.

```coffeescript
Renderer.Rectangle.create
    id: 'rect1'
    ...

Renderer.Rectangle.create
    anchors:
        left: 'rect1.left'
        right: 'rect1.right' # ERROR!
        # horizontal line is currently occupied by the left anchor;
        # custom binding on a `width` property should be used instead
        # (`width: 'rect1.width'`)
    ...
```

				if opts & FREE_H_LINE_REQ
					assert not (itemsAnchors[id] & H_LINE)
					, "`(##{id}).anchors.#{type}` can't be set, because some other " +
					  "horizontal anchor is currently set; `'#{val}'` given"

					itemsAnchors[id] |= H_LINE

				if opts & FREE_V_LINE_REQ
					assert not (itemsAnchors[id] & V_LINE)
					, "`(##{id}).anchors.#{type}` can't be set, because some other " +
					  "vertical anchor is currently set; `'#{val}'` given"

					itemsAnchors[id] |= V_LINE

			unless val?
				if opts & FREE_V_LINE_REQ
					itemsAnchors[id] &= ~V_LINE
				if opts & FREE_H_LINE_REQ
					itemsAnchors[id] &= ~H_LINE
			`//</development>`

			# change local id to uid
			if val? and target isnt 'parent'
				target = exports.currentItem.scope.items[target]._uid

			Impl.setItemAnchor id, type, val

	createAnchorProp 'left', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ
	createAnchorProp 'right', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ
	createAnchorProp 'verticalCenter', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ
	createAnchorProp 'top', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ
	createAnchorProp 'bottom', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ
	createAnchorProp 'horizontalCenter', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ
	createAnchorProp 'centerIn', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ
	createAnchorProp 'fill', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ

Margins
-------

*Anchors* object also provides a way to set *left*, *top*, *right* and *bottom* margins.

```coffeescript
Renderer.Rectangle.create
    id: 'rect1'
    ...

Renderer.Rectangle.create
    id: 'rect2'
    anchors:
        left: 'rect1.right'
        margin:
            left: 20
    ...
```

*Margins* doesn't have any effect for the *horizontalCenter* and *verticalCenter* anchors.

	Anchors.margin = {}

	createMarginProp = (type) ->
		utils.defProp Anchors.margin, type, 'e', null, (val) ->
			id = exports.currentItem._uid

			`//<development>`
			assert typeof val is 'number' and isFinite(val)
			, "(##{id}).anchors.margin.#{type} expects a finite number; `#{val}` given"
			`//</development>`

			Impl.setItemAnchorMargin id, type, val

	createMarginProp 'left'
	createMarginProp 'top'
	createMarginProp 'right'
	createMarginProp 'bottom'

***margins*** property can be used to set the same margin from all sides.

```coffeescript
Renderer.Rectangle.create
    id: 'rect1'
    ...

Renderer.Rectangle.create
    id: 'rect2'
    anchors:
        fill: 'rect1'
        margins: 10
    ...
```

	utils.defProp Anchors, 'margins', 'e', null, (val) ->
		`//<development>`
		id = exports.currentItem._uid

		assert typeof val is 'number' and isFinite(val)
		, "(##{id}).anchors.margins expects a finite number; `#{val}` given"
		`//</development>`

		{margin} = Anchors

		margin.left = val
		margin.top = val
		margin.right = val
		margin.bottom = val

	Object.freeze Anchors.margin
	Object.freeze Anchors
