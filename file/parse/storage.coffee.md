String Interpolation @xml
=========================

Any XML text and attribute value can use string interpolation.

```
<h1>Welcome #{name}!</h1>
```

In `neft:unit`s you can use got attributes from the `neft:use`, like in the example below.
If no attribute with such name found, value from the global data will be used
(data from `App Controller` etc.).

```
<neft:unit neft:name="user">#{name}</neft:unit>

<neft:use neft:unit="user" name="#{ownerName}" />
```

#### See also

- `Attributes evaluating`
- `neft:unit`
- `neft:use`

.

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
						input.funcBody = funcBody
						input.attrName = attr[0]
						inputs.push input

					i++

				elem.children?.forEach forNode

			forNode node
