'use strict'

assert = require 'assert'
log = require 'log'
utils = require 'utils'

log = log.scope 'Renderer'

###
Parse 3-digit hex, 6-digit hex, rgb, rgba, hsl, hsla, or named color into RGBA hex.
###
exports.colorToHex = do ->
	NAMED_COLORS =
		'': '00000000'
		transparent: '00000000'
		black: '000000ff'
		silver: 'c0c0c0ff'
		gray: '808080ff'
		white: 'ffffffff'
		maroon: '800000ff'
		red: 'ff0000ff'
		purple: '800080ff'
		fuchsia: 'ff00ffff'
		green: '008000ff'
		lime: '00ff00ff'
		olive: '808000ff'
		yellow: 'ffff00ff'
		navy: '000080ff'
		blue: '0000ffff'
		teal: '008080ff'
		aqua: '00ffffff'
		antiquewhite: 'faebd7ff'
		aquamarine: '7fffd4ff'
		azure: 'f0ffffff'
		beige: 'f5f5dcff'
		bisque: 'ffe4c4ff'
		blanchedalmond: 'ffe4c4ff'
		blueviolet: '8a2be2ff'
		brown: 'a52a2aff'
		burlywood: 'deb887ff'
		cadetblue: '5f9ea0ff'
		chartreuse: '7fff00ff'
		chocolate: 'd2691eff'
		coral: 'ff7f50ff'
		cornflowerblue: '6495edff'
		cornsilk: 'fff8dcff'
		crimson: 'dc143cff'
		darkblue: '00008bff'
		darkcyan: '008b8bff'
		darkgoldenrod: 'b8860bff'
		darkgray: 'a9a9a9ff'
		darkgreen: '006400ff'
		darkgrey: 'a9a9a9ff'
		darkkhaki: 'bdb76bff'
		darkmagenta: '8b008bff'
		darkolivegreen: '556b2fff'
		darkorange: 'ff8c00ff'
		darkorchid: '9932ccff'
		darkred: '8b0000ff'
		darksalmon: 'e9967aff'
		darkseagreen: '8fbc8fff'
		darkslateblue: '483d8bff'
		darkslategray: '2f4f4fff'
		darkslategrey: '2f4f4fff'
		darkturquoise: '00ced1ff'
		darkviolet: '9400d3ff'
		deeppink: 'ff1493ff'
		deepskyblue: '00bfffff'
		dimgray: '696969ff'
		dimgrey: '696969ff'
		dodgerblue: '1e90ffff'
		firebrick: 'b22222ff'
		floralwhite: 'fffaf0ff'
		forestgreen: '228b22ff'
		gainsboro: 'dcdcdcff'
		ghostwhite: 'f8f8ffff'
		gold: 'ffd700ff'
		goldenrod: 'daa520ff'
		greenyellow: 'adff2fff'
		grey: '808080ff'
		honeydew: 'f0fff0ff'
		hotpink: 'ff69b4ff'
		indianred: 'cd5c5cff'
		indigo: '4b0082ff'
		ivory: 'fffff0ff'
		khaki: 'f0e68cff'
		lavender: 'e6e6faff'
		lavenderblush: 'fff0f5ff'
		lawngreen: '7cfc00ff'
		lemonchiffon: 'fffacdff'
		lightblue: 'add8e6ff'
		lightcoral: 'f08080ff'
		lightcyan: 'e0ffffff'
		lightgoldenrodyellow: 'fafad2ff'
		lightgray: 'd3d3d3ff'
		lightgreen: '90ee90ff'
		lightgrey: 'd3d3d3ff'
		lightpink: 'ffb6c1ff'
		lightsalmon: 'ffa07aff'
		lightseagreen: '20b2aaff'
		lightskyblue: '87cefaff'
		lightslategray: '778899ff'
		lightslategrey: '778899ff'
		lightsteelblue: 'b0c4deff'
		lightyellow: 'ffffe0ff'
		limegreen: '32cd32ff'
		linen: 'faf0e6ff'
		mediumaquamarine: '66cdaaff'
		mediumblue: '0000cdff'
		mediumorchid: 'ba55d3ff'
		mediumpurple: '9370dbff'
		mediumseagreen: '3cb371ff'
		mediumslateblue: '7b68eeff'
		mediumspringgreen: '00fa9aff'
		mediumturquoise: '48d1ccff'
		mediumvioletred: 'c71585ff'
		midnightblue: '191970ff'
		mintcream: 'f5fffaff'
		mistyrose: 'ffe4e1ff'
		moccasin: 'ffe4b5ff'
		navajowhite: 'ffdeadff'
		oldlace: 'fdf5e6ff'
		olivedrab: '6b8e23ff'
		orangered: 'ff4500ff'
		orchid: 'da70d6ff'
		palegoldenrod: 'eee8aaff'
		palegreen: '98fb98ff'
		paleturquoise: 'afeeeeff'
		palevioletred: 'db7093ff'
		papayawhip: 'ffefd5ff'
		peachpuff: 'ffdab9ff'
		peru: 'cd853fff'
		pink: 'ffc0cbff'
		plum: 'dda0ddff'
		powderblue: 'b0e0e6ff'
		rosybrown: 'bc8f8fff'
		royalblue: '4169e1ff'
		saddlebrown: '8b4513ff'
		salmon: 'fa8072ff'
		sandybrown: 'f4a460ff'
		seagreen: '2e8b57ff'
		seashell: 'fff5eeff'
		sienna: 'a0522dff'
		skyblue: '87ceebff'
		slateblue: '6a5acdff'
		slategray: '708090ff'
		slategrey: '708090ff'
		snow: 'fffafaff'
		springgreen: '00ff7fff'
		steelblue: '4682b4ff'
		tan: 'd2b48cff'
		thistle: 'd8bfd8ff'
		tomato: 'ff6347ff'
		turquoise: '40e0d0ff'
		violet: 'ee82eeff'
		wheat: 'f5deb3ff'
		whitesmoke: 'f5f5f5ff'
		yellowgreen: '9acd32ff'
		rebeccapurple: '663399ff'

	numberToHex = (val) ->
		val = parseFloat val
		if val < 0
			val = 0
		else if val > 255
			val = 255
		hex = Math.round(val).toString 16
		if hex.length is 1
			"0#{hex}"
		else
			hex

	alphaToHex = (val) ->
		numberToHex Math.round(parseFloat(val) * 255)

	# http://www.w3.org/TR/2011/REC-css3-color-20110607/#hsl-color
	hslToRgb = do ->
		hueToRgb = (p, q, t) ->
			if t < 0
				t += 1
			if t > 1
				t -= 1
			if t * 6 < 1
				return p + (q - p) * t * 6
			if t * 2 < 1
				return q
			if t * 3 < 2
				return p + (q - p) * (2/3 - t) * 6
			return p

		(hStr, sStr, lStr) ->
			p = q = h = s = l = 0.0

			h = (parseFloat(hStr) % 360) / 360
			s = parseFloat(sStr) / 100
			l = parseFloat(lStr) / 100

			if s is 0
				red = green = blue = l
			else
				if l <= 0.5
					q = l * (s + 1)
				else
					q = l + s - l * s
				p = l * 2 - q

				red = hueToRgb p, q, h + 1/3
				green = hueToRgb p, q, h
				blue = hueToRgb p, q, h - 1/3

			return '' +
				numberToHex(red * 255) +
				numberToHex(green * 255) +
				numberToHex(blue * 255)

	(color, defaultColor='transparent') ->
		assert.isString color

		if result = NAMED_COLORS[color]
			return result

		# 3-digit hexadecimal
		if /^#[0-9a-fA-F]{3}$/.test(color)
			return "#{color[1]}#{color[1]}#{color[2]}#{color[2]}#{color[3]}#{color[3]}ff"

		# 6-digit hexadecimal
		if /^#[0-9a-fA-F]{6}$/i.test(color)
			return "#{color.slice(1)}ff"

		# rgb
		if match = /^rgb\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*\)$/.exec(color)
			return '' +
				numberToHex(match[1]) +
				numberToHex(match[2]) +
				numberToHex(match[3]) +
				'ff'

		# rgba
		if match = /^rgba\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*\)$/.exec(color)
			return '' +
				numberToHex(match[1]) +
				numberToHex(match[2]) +
				numberToHex(match[3]) +
				alphaToHex(match[4])

		# hsl
		if match = /^hsl\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*%\s*,\s*([0-9.]+)\s*%\s*\)$/.exec(color)
			return '' +
				hslToRgb(match[1], match[2], match[3]) +
				'ff'

		# hsla
		if match = /^hsla\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*%\s*,\s*([0-9.]+)\s*%\s*,\s*([0-9.]+)\s*\)$/.exec(color)
			return '' +
				hslToRgb(match[1], match[2], match[3]) +
				alphaToHex(match[4])

		return exports.colorToHex(defaultColor)
