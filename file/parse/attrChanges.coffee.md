neft:attr @xml
==============

Special XML tag used to dynamically change attributes of the parent element.

By default, tag attributes can't be simply changed. This tag is commonly used with
the `neft:if` attribute, which makes this tag more dynamic.

Let's consider an example.

As you may to know from reading the `Styles` module, the `neft:style` attribute
refers to the `Renderer.Item` from your styles.

In this example we change the `Renderer.Item::state` dynamically, according to the
condition (`neft:if`).

```
<header neft:style="header">
  <neft:attr name="neft:style:state" value="active" neft:if="1 > 0" />
</header>
```

Now, if the condition is true (`1 > 0`), `header` state will be changed to `active`.

```
header.state = 'active'
```

Of course, we used really simply condition (`1 > 0`) to visualize the problem.
In pratice, you can refer to some data using the string interpolation.

```
<button neft:style="ButtonRed" neft:style:state="disabled">
  <neft:attr name="neft:style:state" value="active" neft:if="${user.order.length} > 0" />
  Proceed to checkout
</button>
```

#### See also

- `neft:style`
- `String Interpolation`

.

	'use strict'

	module.exports = (File) ->
		{AttrChange} = File

		(file) ->
			attrChanges = []

			nodes = file.node.queryAll "#{File.HTML_NS}:attr"

			for node in nodes
				target = node.parent
				name = node.attrs.get 'name'
				value = node.attrs.get 'value'

				if target.attrs.get(name) is undefined
					target.attrs.add name, value

				attrChanges.push new AttrChange
					self: file
					node: node
					target: target
					name: name
					value: value

			if attrChanges.length
				file.attrChanges = attrChanges

			null