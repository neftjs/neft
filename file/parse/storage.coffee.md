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

	module.exports = (File) ->
		{Input} = File
		InputRE = Input.RE

		(file) ->
			{node} = file

			# get inputs
			{inputs} = file

			forNode = (elem) ->
				# text
				text = elem.text
				if text isnt undefined
					InputRE.lastIndex = 0
					if text and InputRE.test(text)
						if funcBody = Input.parse(text)
							`//<production>`
							text = ''
							`//</production>`
							input = new Input.Text file, elem, text, funcBody
							elem.text = ''
							inputs.push input

				# attrs
				if elem._attrs
					for name, val of elem._attrs
						if Input.test(val)
							if funcBody = Input.parse(val)
								func = Input.createFunction funcBody
								text = ''
								`//<development>`
								text = val
								`//</development>`
								input = new Input.Attr file, elem, text, funcBody, name
								elem.setAttr name, null
								inputs.push input

				elem.children?.forEach forNode

			forNode node
