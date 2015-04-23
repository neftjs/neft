String Interpolation @learn
=========================

Any XML text and attribute value can use string interpolation.

```
<h1>Welcome ${name}!</h1>
```

In the [neft:fragment][] you can refers to the:
- *neft:fragment* tag attributes,
- [neft:use][] tag attributes.

Global data object ([DocumentGlobalData][] if you use [App][]) is checked as the last.
.

```
<neft:fragment neft:name="user">${name}</neft:fragment>

<neft:use neft:fragment="user" name="${ownerName}" />
```

	'use strict'

	attr = [null, null]

	module.exports = (File) ->

		{Input} = File
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
						funcBody = Input.parse text
						func = Input.createFunction funcBody
						input = new Input.Text elem, func
						`//<development>`
						input.text = text
						`//</development>`
						input.funcBody = funcBody
						inputs.push input

				# attrs
				i = 0
				loop
					break unless elem.attrs
					elem.attrs.item i, attr
					break unless attr[0]

					if Input.test attr[1]
						funcBody = Input.parse attr[1]
						func = Input.createFunction funcBody
						input = new Input.Attr elem, func
						`//<development>`
						input.text = attr[1]
						`//</development>`
						input.funcBody = funcBody
						input.attrName = attr[0]
						inputs.push input

					i++

				elem.children?.forEach forNode

			forNode node
