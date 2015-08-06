'use strict'

module.exports = (impl) ->
	{Types, items} = impl

	# t: current time, b: begInnIng value, c: change In value, d: duration
	# http://gsgd.co.uk/sandbox/jquery/easing/jquery.easing.1.3.js
	EASINGS =
		Linear: (t, b, c, d) ->
			c * (t/d) + b
		InQuad: (t, b, c, d) ->
			c*(t/=d)*t + b
		OutQuad: (t, b, c, d) ->
			-c *(t/=d)*(t-2) + b
		InOutQuad: (t, b, c, d) ->
			if (t/=d/2) < 1
				c/2*t*t + b
			else
				-c/2 * ((--t)*(t-2) - 1) + b
		InCubic: (t, b, c, d) ->
			c*(t/=d)*t*t + b
		OutCubic: (t, b, c, d) ->
			c*((t=t/d-1)*t*t + 1) + b
		InOutCubic: (t, b, c, d) ->
			if (t/=d/2) < 1
				c/2*t*t*t + b
			else
				c/2*((t-=2)*t*t + 2) + b
		InQuart: (t, b, c, d) ->
			c*(t/=d)*t*t*t + b
		OutQuart: (t, b, c, d) ->
			-c * ((t=t/d-1)*t*t*t - 1) + b
		InOutQuart: (t, b, c, d) ->
			if (t/=d/2) < 1
				c/2*t*t*t*t + b
			else
				-c/2 * ((t-=2)*t*t*t - 2) + b
		InQuint: (t, b, c, d) ->
			c*(t/=d)*t*t*t*t + b
		OutQuint: (t, b, c, d) ->
			c*((t=t/d-1)*t*t*t*t + 1) + b
		InOutQuint: (t, b, c, d) ->
			if (t/=d/2) < 1
				c/2*t*t*t*t*t + b
			else
				c/2*((t-=2)*t*t*t*t + 2) + b
		InSine: (t, b, c, d) ->
			-c * Math.cos(t/d * (Math.PI/2)) + c + b
		OutSine: (t, b, c, d) ->
			c * Math.sin(t/d * (Math.PI/2)) + b
		InOutSine: (t, b, c, d) ->
			-c/2 * (Math.cos(Math.PI*t/d) - 1) + b
		InExpo: (t, b, c, d) ->
			if t is 0
				b
			else
				c * Math.pow(2, 10 * (t/d - 1)) + b
		OutExpo: (t, b, c, d) ->
			if t is d
				b+c
			else
				c * (-Math.pow(2, -10 * t/d) + 1) + b
		InOutExpo: (t, b, c, d) ->
			if t is 0
				b
			else if t is d
				b+c
			else if (t/=d/2) < 1
				c/2 * Math.pow(2, 10 * (t - 1)) + b
			else
				c/2 * (-Math.pow(2, -10 * --t) + 2) + b
		InCirc: (t, b, c, d) ->
			-c * (Math.sqrt(1 - (t/=d)*t) - 1) + b
		OutCirc: (t, b, c, d) ->
			c * Math.sqrt(1 - (t=t/d-1)*t) + b
		InOutCirc: (t, b, c, d) ->
			if (t/=d/2) < 1
				-c/2 * (Math.sqrt(1 - t*t) - 1) + b
			else
				c/2 * (Math.sqrt(1 - (t-=2)*t) + 1) + b
		InElastic: (t, b, c, d) ->
			s=1.70158
			p=0
			a=c
			if t is 0
				b
			else if (t/=d) is 1
				b+c
			else
				p||=d*.3
				if a < Math.abs(c)
					a=c
					s=p/4
				else
					s = p/(2*Math.PI) * Math.asin(c/a)
				-(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b
		OutElastic: (t, b, c, d) ->
			s=1.70158
			p=0
			a=c
			if t is 0
				b
			else if (t/=d) is 1
				b+c
			else
				p||=d*.3
				if a < Math.abs(c)
					a=c
					s=p/4
				else
					s = p/(2*Math.PI) * Math.asin(c/a)
				a*Math.pow(2,-10*t) * Math.sin( (t*d-s)*(2*Math.PI)/p ) + c + b
		InOutElastic: (t, b, c, d) ->
			s=1.70158
			p=0
			a=c
			if t==0
				b
			else if (t/=d/2) is 2
				b+c
			else
				p||=d*(.3*1.5)
				if a < Math.abs(c)
					a=c
					s=p/4
				else
					s = p/(2*Math.PI) * Math.asin (c/a)
				if t < 1
					-.5*(a*Math.pow(2,10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )) + b
				else
					a*Math.pow(2,-10*(t-=1)) * Math.sin( (t*d-s)*(2*Math.PI)/p )*.5 + c + b
		InBack: (t, b, c, d, s=1.70158) ->
			c*(t/=d)*t*((s+1)*t - s) + b
		OutBack: (t, b, c, d, s=1.70158) ->
			c*((t=t/d-1)*t*((s+1)*t + s) + 1) + b
		InOutBack: (t, b, c, d, s=1.70158) ->
			if (t/=d/2) < 1
				c/2*(t*t*(((s*=(1.525))+1)*t - s)) + b
			else
				c/2*((t-=2)*t*(((s*=(1.525))+1)*t + s) + 2) + b
		InBounce: (t, b, c, d) ->
			c - EASINGS.outBounce(d-t, 0, c, d) + b
		OutBounce: (t, b, c, d) ->
			if (t/=d) < (1/2.75)
				c*(7.5625*t*t) + b
			else if t < (2/2.75)
				c*(7.5625*(t-=(1.5/2.75))*t + .75) + b
			else if t < (2.5/2.75)
				c*(7.5625*(t-=(2.25/2.75))*t + .9375) + b
			else
				c*(7.5625*(t-=(2.625/2.75))*t + .984375) + b
		InOutBounce: (t, b, c, d) ->
			if (t < d/2)
				EASINGS.inBounce(t*2, 0, c, d) * .5 + b
			else
				EASINGS.outBounce(t*2-d, 0, c, d) * .5 + c*.5 + b

	DATA =
		progress: 0
		internalPropertyName: ''
		propertySetter: null
		isIntegerProperty: false
		easing: null

	DATA: DATA

	createData: impl.utils.createDataCloner 'Animation', DATA

	create: (data) ->
		data.easing = EASINGS.Linear
		impl.Types.Animation.create.call @, data

	setPropertyAnimationTarget: (val) ->

	setPropertyAnimationProperty: (val) ->
		@_impl.internalPropertyName = "_#{val}"
		@_impl.propertySetter = impl.utils.SETTER_METHODS_NAMES[val]
		@_impl.isIntegerProperty = !!impl.utils.INTEGER_PROPERTIES[val]
		return

	setPropertyAnimationDuration: (val) ->

	setPropertyAnimationStartDelay: (val) ->

	setPropertyAnimationLoopDelay: (val) ->

	setPropertyAnimationFrom: (val) ->

	setPropertyAnimationTo: (val) ->

	setPropertyAnimationUpdateData: (val) ->

	setPropertyAnimationUpdateProperty: (val) ->

	setPropertyAnimationEasingType: (val) ->
		@_impl.easing = EASINGS[val] or EASINGS.Linear

	getPropertyAnimationProgress: ->
		@_impl.progress
