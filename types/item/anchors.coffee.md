Item Anchors
============

`Item` provides simply but powerful way to describe
relationships between items: ***anchors***.

	'use strict'

	utils = require 'utils'
	expect = require 'expect'
	Dict = require 'dict'

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

	module.exports = (Renderer, Impl) ->

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

		class Margin extends Dict
			@DATA =
				left: 0
				top: 0
				right: 0
				bottom: 0

			constructor: (item) ->
				expect(item).toBe.any Renderer.Item

				utils.defProp @, '_item', '', item

				super Object.create Margin.DATA

			createMarginProp = (type) ->
				Dict.defineProperty Margin::, type

				utils.defProp Margin::, type, 'e', utils.lookupGetter(Margin::, type)
				, do (_super = utils.lookupSetter Margin::, type) -> (val) ->
					`//<development>`
					id = @_item.__hash__
					assert typeof val is 'number' and isFinite(val)
					, "(##{id}).anchors.margin.#{type} expects a finite number; `#{val}` given"
					`//</development>`

					_super.call @, val
					Impl.setItemAnchorMargin.call @_item, type, val

			createMarginProp 'left'
			createMarginProp 'top'
			createMarginProp 'right'
			createMarginProp 'bottom'

Anchors
-------

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

		class Anchors extends Dict

			@DATA =
				top: null
				verticalCenter: null
				bottom: null
				left: null
				horizontalCenter: null
				right: null
				margin: Margin.DATA

			createAnchorProp = (type, opts=0) ->
				Dict.defineProperty Anchors::, type

				utils.defProp Anchors::, type, 'e', utils.lookupGetter(Anchors::, type)
				, do (_super = utils.lookupSetter Anchors::, type) -> (val) ->
					`//<development>`
					if val?
						id = @_item.__hash__
						allowedLines = if H_LINES[type] then H_LINES else V_LINES

						assert Array.isArray(val) and val.length > 0 and val.length < 3
						, "`(##{id}).anchors.#{type}` expects an array; `'#{val}'` given"

						[target, line] = val

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

						assert target is 'parent' or target is 'this' or target instanceof Renderer.Item
						, "`(##{id}).anchors.#{type}` expects an item; `'#{val}'` given"

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
							assert line is undefined
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

					`//</development>`

					if val?
						if val[0] is 'this'
							val[0] = @

					_super.call @, val
					Impl.setItemAnchor.call @_item, type, val

			constructor: (item) ->
				expect(item).toBe.any Renderer.Item

				utils.defProp @, '_item', '', item

				super Object.create Anchors.DATA

			createAnchorProp 'left', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ
			createAnchorProp 'right', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ
			createAnchorProp 'verticalCenter', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ
			createAnchorProp 'top', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ
			createAnchorProp 'bottom', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ
			createAnchorProp 'horizontalCenter', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ
			createAnchorProp 'centerIn', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ
			createAnchorProp 'fill', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ

			utils.defProp @::, 'margin', 'e', ->
				utils.defProp @, 'margin', 'e', val = new Margin(@_item)
				val
			, null

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

		utils.defProp Anchors::, 'margins', '', null, (val) ->
			`//<development>`
			id = @_item.__hash__
			assert typeof val is 'number' and isFinite(val)
			, "(##{id}).anchors.margins expects a finite number; `#{val}` given"
			`//</development>`

			{margin} = @_item.anchors

			margin.left = val
			margin.top = val
			margin.right = val
			margin.bottom = val

		Anchors