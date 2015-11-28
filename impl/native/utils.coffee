'use strict'

assert = require 'assert'
log = require 'log'
utils = require 'utils'

log = log.scope 'Renderer'

exports.colorToHex = do ->
	NAMED_COLORS =
		'': 'ffffffff'
		transparent: 'ffffffff'
		black: '00000000'
		silver: 'c0c0c000'
		gray: '80808000'
		white: 'ffffff00'
		maroon: '80000000'
		red: 'ff000000'
		purple: '80008000'
		fuchsia: 'ff00ff00'
		green: '00800000'
		lime: '00ff0000'
		olive: '80800000'
		yellow: 'ffff0000'
		navy: '00008000'
		blue: '0000ff00'
		teal: '00808000'
		aqua: '00ffff00'
		antiquewhite: 'faebd700'
		aquamarine: '7fffd400'
		azure: 'f0ffff00'
		beige: 'f5f5dc00'
		bisque: 'ffe4c400'
		blanchedalmond: 'ffe4c400'
		blueviolet: '8a2be200'
		brown: 'a52a2a00'
		burlywood: 'deb88700'
		cadetblue: '5f9ea000'
		chartreuse: '7fff0000'
		chocolate: 'd2691e00'
		coral: 'ff7f5000'
		cornflowerblue: '6495ed00'
		cornsilk: 'fff8dc00'
		crimson: 'dc143c00'
		darkblue: '00008b00'
		darkcyan: '008b8b00'
		darkgoldenrod: 'b8860b00'
		darkgray: 'a9a9a900'
		darkgreen: '00640000'
		darkgrey: 'a9a9a900'
		darkkhaki: 'bdb76b00'
		darkmagenta: '8b008b00'
		darkolivegreen: '556b2f00'
		darkorange: 'ff8c0000'
		darkorchid: '9932cc00'
		darkred: '8b000000'
		darksalmon: 'e9967a00'
		darkseagreen: '8fbc8f00'
		darkslateblue: '483d8b00'
		darkslategray: '2f4f4f00'
		darkslategrey: '2f4f4f00'
		darkturquoise: '00ced100'
		darkviolet: '9400d300'
		deeppink: 'ff149300'
		deepskyblue: '00bfff00'
		dimgray: '69696900'
		dimgrey: '69696900'
		dodgerblue: '1e90ff00'
		firebrick: 'b2222200'
		floralwhite: 'fffaf000'
		forestgreen: '228b2200'
		gainsboro: 'dcdcdc00'
		ghostwhite: 'f8f8ff00'
		gold: 'ffd70000'
		goldenrod: 'daa52000'
		greenyellow: 'adff2f00'
		grey: '80808000'
		honeydew: 'f0fff000'
		hotpink: 'ff69b400'
		indianred: 'cd5c5c00'
		indigo: '4b008200'
		ivory: 'fffff000'
		khaki: 'f0e68c00'
		lavender: 'e6e6fa00'
		lavenderblush: 'fff0f500'
		lawngreen: '7cfc0000'
		lemonchiffon: 'fffacd00'
		lightblue: 'add8e600'
		lightcoral: 'f0808000'
		lightcyan: 'e0ffff00'
		lightgoldenrodyellow: 'fafad200'
		lightgray: 'd3d3d300'
		lightgreen: '90ee9000'
		lightgrey: 'd3d3d300'
		lightpink: 'ffb6c100'
		lightsalmon: 'ffa07a00'
		lightseagreen: '20b2aa00'
		lightskyblue: '87cefa00'
		lightslategray: '77889900'
		lightslategrey: '77889900'
		lightsteelblue: 'b0c4de00'
		lightyellow: 'ffffe000'
		limegreen: '32cd3200'
		linen: 'faf0e600'
		mediumaquamarine: '66cdaa00'
		mediumblue: '0000cd00'
		mediumorchid: 'ba55d300'
		mediumpurple: '9370db00'
		mediumseagreen: '3cb37100'
		mediumslateblue: '7b68ee00'
		mediumspringgreen: '00fa9a00'
		mediumturquoise: '48d1cc00'
		mediumvioletred: 'c7158500'
		midnightblue: '19197000'
		mintcream: 'f5fffa00'
		mistyrose: 'ffe4e100'
		moccasin: 'ffe4b500'
		navajowhite: 'ffdead00'
		oldlace: 'fdf5e600'
		olivedrab: '6b8e2300'
		orangered: 'ff450000'
		orchid: 'da70d600'
		palegoldenrod: 'eee8aa00'
		palegreen: '98fb9800'
		paleturquoise: 'afeeee00'
		palevioletred: 'db709300'
		papayawhip: 'ffefd500'
		peachpuff: 'ffdab900'
		peru: 'cd853f00'
		pink: 'ffc0cb00'
		plum: 'dda0dd00'
		powderblue: 'b0e0e600'
		rosybrown: 'bc8f8f00'
		royalblue: '4169e100'
		saddlebrown: '8b451300'
		salmon: 'fa807200'
		sandybrown: 'f4a46000'
		seagreen: '2e8b5700'
		seashell: 'fff5ee00'
		sienna: 'a0522d00'
		skyblue: '87ceeb00'
		slateblue: '6a5acd00'
		slategray: '70809000'
		slategrey: '70809000'
		snow: 'fffafa00'
		springgreen: '00ff7f00'
		steelblue: '4682b400'
		tan: 'd2b48c00'
		thistle: 'd8bfd800'
		tomato: 'ff634700'
		turquoise: '40e0d000'
		violet: 'ee82ee00'
		wheat: 'f5deb300'
		whitesmoke: 'f5f5f500'
		yellowgreen: '9acd3200'
		rebeccapurple: '66339900'

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

	(color) ->
		assert.isString color

		if result = NAMED_COLORS[color]
			return result

		# 3-digit hexadecimal
		if /^#[0-9a-f]{3}$/.test(color)
			return "#{color[1]}#{color[1]}#{color[2]}#{color[2]}#{color[3]}#{color[3]}00"

		# 6-digit hexadecimal
		if /^#[0-9a-f]{6}$/.test(color)
			return "#{color.slice(1)}00"

		# rgb
		if match = /^rgb\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*,\s*([0-9.]+)\s*\)$/.exec(color)
			return '' +
				numberToHex(match[1]) +
				numberToHex(match[2]) +
				numberToHex(match[3]) +
				'00'

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
				'00'

		# hsla
		if match = /^hsla\s*\(\s*([0-9.]+)\s*,\s*([0-9.]+)\s*%\s*,\s*([0-9.]+)\s*%\s*,\s*([0-9.]+)\s*\)$/.exec(color)
			return '' +
				hslToRgb(match[1], match[2], match[3]) +
				alphaToHex(match[4])

		log.error "Unknown color '#{color}'"

		return NAMED_COLORS.transparent
