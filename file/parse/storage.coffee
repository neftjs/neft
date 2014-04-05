'use strict'

attr = [null, null]

module.exports = (File) ->

	Input = File.Input
	InputRE = Input.RE

	(file) ->

		{node} = file

		# get inputs
		inputs = file.inputs = []

		forNode = (elem) ->

			# text
			text = elem.text
			InputRE.lastIndex = 0
			if text and InputRE.test text
				inputs.push new Input.Text elem

			# attrs
			i = 0
			loop
				elem.attrs.item i, attr
				unless attr[0] then break

				if InputRE.test attr[1]
					inputs.push new Input.Attr elem, attr[0]

				i++

			elem.children?.forEach forNode

		forNode node
