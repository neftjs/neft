'use strict'

isFirefox = navigator.userAgent.indexOf('Firefox') isnt -1

exports.getFontWeight = (val) ->
	Math.round(val * 8) * 100 + 100

exports.prependElement = (parent, child) ->
	if first = parent.firstChild
		parent.insertBefore child, first
	else
		parent.appendChild child

exports.encodeImageSrc = do ->
	DATA_URI_RE = ///^data:([a-z+/]+),(.*)$///

	(val) ->
		if DATA_URI_RE.test(val)
			val.replace ///\#///g, encodeURIComponent('#')
		else
			val

exports.wheelEvent =
	eventName: do ->
		if 'onwheel' of document.createElement("div")
			'wheel'
		else if document.onmousewheel isnt undefined
			'mousewheel'
		else
			'MozMousePixelScroll'
	getDelta: do ->
		NORMALIZED_VALUE = 3

		isSlowContinuous = false

		getDeltas = (e) ->
			x = -e.deltaX*3 or e.wheelDeltaX ? 0
			y = -e.deltaY*3 or e.wheelDeltaY ? e.wheelDelta ? -e.detail*3 or 0

			if isFirefox and e.deltaMode is e.DOM_DELTA_LINE
				x *= 10
				y *= 10

			deltaX: x
			deltaY: y

		(e) ->
			deltas = getDeltas e

			# MAGIC!
			# It looks that Chrome on MacBook never gives values in range (-3, 3) as
			# it does Firefox which always sends lower values
			if not isSlowContinuous
				delta = deltas.x or deltas.y or 3

				if (delta > 0 and delta < 3) or (delta < 0 and delta > -3)
					isSlowContinuous = true

			if isSlowContinuous
				deltas.x *= NORMALIZED_VALUE
				deltas.y *= NORMALIZED_VALUE

			deltas