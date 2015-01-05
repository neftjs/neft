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
<neft:unit name="user">#{name}</neft:unit>

<neft:use:user name="#{ownerName}" />
```

### See also

- `Attributes evaluating`
- `neft:unit`
- `neft:use`

.

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

					InputRE.lastIndex = 0
					if InputRE.test attr[1]
						inputs.push new Input.Attr elem, attr[0]

					i++

				elem.children?.forEach forNode

			forNode node
