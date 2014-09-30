'use strict'

utils = require 'utils'
expect = require 'expect'

Impl = require '../impl'

{assert} = console

H_LINE = 1<<0
V_LINE = 1<<1

LINE_REQ = 1<<0
ONLY_TARGET_ALLOW = 1<<1
H_LINE_REQ = 1<<2
V_LINE_REQ = 1<<3
FREE_H_LINE_REQ = 1<<4
FREE_V_LINE_REQ = 1<<5

H_LINES =
	left: true
	horizontalCenter: true
	right: true

V_LINES =
	top: true
	verticalCenter: true
	bottom: true

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

createAnchorProp = (type, opts=0) ->
	utils.defProp Anchors, type, 'e', null, (val) ->
		id = exports.currentItem._id

		`//<development>`
		[target, line] = splitAnchorValue val
		allowedLines = if H_LINES[type] then H_LINES else V_LINES
		itemsAnchors[id] ?= 0

		assert typeof val is 'string' and val.length
		, "`(##{id}).anchors.#{type}` expects a string (e.g. `'parent.left'`); " +
		  "`'#{val}'` given"

		assert target.length
		, "`(##{id}).anchors.#{type}` expects a target; `'#{val}'` given;\n" +
		  "specify an item id or `parent` (e.g `anchors.left = 'parent.right'`)"

		setImmediate ->
			if target isnt 'parent' and target isnt 'this'
				isFamily = Impl.confirmItemChild id, target
				assert isFamily
				, "`(##{id}).anchors.#{type}` can be anchored only to a parent or sibling"

		if opts & ONLY_TARGET_ALLOW
			assert line.length is 0
			, "`(##{id}).anchors.#{type}` expects only a target to be defined; " +
			  "`'#{val}'` given;\npointing to the line is not required " +
			  "(e.g `anchors.centerIn = 'parent'`)"

		if opts & LINE_REQ
			assert H_LINES[line] or V_LINES[line]
			, "`(##{id}).anchors.#{type}` expects a anchor line to be defined; " +
			  "`'#{val}'` given;\nuse one of the `#{Object.keys allowedLines}`"

		if opts & H_LINE_REQ
			assert H_LINES[line]
			, "`(##{id}).anchors.#{type}` can't be anchored to a vertical edge; " +
			  "`'#{val}'` given;\nuse one of the `#{Object.keys H_LINES}`"

		if opts & V_LINE_REQ
			assert V_LINES[line]
			, "`(##{id}).anchors.#{type}` can't be anchored to a horizontal edge; " +
			  "`'#{val}'` given;\nuse one of the `#{Object.keys V_LINES}`"

		if opts & FREE_H_LINE_REQ
			assert not (itemsAnchors[id] & H_LINE)
			, "`(##{id}).anchors.#{type}` can't be set, because some other horizontal " +
			  "anchor is currently set; `'#{val}'` given"

			itemsAnchors[id] |= H_LINE

		if opts & FREE_V_LINE_REQ
			assert not (itemsAnchors[id] & V_LINE)
			, "`(##{id}).anchors.#{type}` can't be set, because some other vertical " +
			  "anchor is currently set; `'#{val}'` given"

			itemsAnchors[id] |= V_LINE
		`//</development>`

		Impl.setItemAnchor id, type, val

createAnchorProp 'left', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ
createAnchorProp 'right', LINE_REQ | H_LINE_REQ | FREE_H_LINE_REQ
createAnchorProp 'top', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ
createAnchorProp 'bottom', LINE_REQ | V_LINE_REQ | FREE_V_LINE_REQ
createAnchorProp 'centerIn', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ
createAnchorProp 'fill', ONLY_TARGET_ALLOW | FREE_H_LINE_REQ | FREE_V_LINE_REQ

Anchors.margin = {}

createMarginProp = (type) ->
	utils.defProp Anchors.margin, type, 'e', null, (val) ->
		id = exports.currentItem._id

		`//<development>`
		assert typeof val is 'number' and isFinite(val)
		, "(##{id}).anchors.margin.#{type} expects a finite number; `#{val}` given"
		`//</development>`

		Impl.setItemAnchorMargin id, type, val

createMarginProp 'left'
createMarginProp 'top'
createMarginProp 'right'
createMarginProp 'bottom'

utils.defProp Anchors, 'margins', 'e', null, (val) ->
	`//<development>`
	id = exports.currentItem._id

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
