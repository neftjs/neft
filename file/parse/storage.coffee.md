String Interpolation @learn
===========================

[Text][document/Text] and [Tag][document/Tag] attribute value can use string interpolation.

```xml
<h1>Welcome ${name}!</h1>
```

	'use strict'

	module.exports = (File) ->
		{Input} = File
		{Tag, Text} = File.Element
		InputRE = Input.RE

		(file) ->
			{node} = file

			# get inputs
			{inputs} = file

			forNode = (elem) ->
				# text
				if elem instanceof Text
					{text} = elem
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
				else if elem instanceof Tag
					for name, val of elem.attrs._data
						if Input.test(val)
							if funcBody = Input.parse(val)
								func = Input.createFunction funcBody
								text = ''
								`//<development>`
								text = val
								`//</development>`
								input = new Input.Attr file, elem, text, funcBody, name
								elem.attrs.set name, null
								inputs.push input

					for child in elem.children
						forNode child
				return

			forNode node
