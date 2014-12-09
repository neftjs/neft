String Interpolation @html
==========================

Any HTML text and attribute value can use string interpolation.

```
<h1>Welcome #{name}!</h1>
```

```
<neft:unit name="user">#{name}</neft:unit>

<neft:use:user name="#{ownerName}" />
```

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
				if text isnt undefined
					InputRE.lastIndex = 0
					if text and InputRE.test text
						inputs.push new Input.Text elem

				# attrs
				i = 0
				loop
					break unless elem.attrs
					elem.attrs.item i, attr
					break unless attr[0]

					if InputRE.test attr[1]
						inputs.push new Input.Attr elem, attr[0]

					i++

				elem.children?.forEach forNode

			forNode node
