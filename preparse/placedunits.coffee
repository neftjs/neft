'use strict'

push = Array::push

COLON = ///:///g

module.exports = (file, declarations) ->

	result = []

	for name, declaration of declarations

		name = name.replace COLON, '-'
		r = file.querySelectorAll name
		if r? then push.apply result, r

	result