neft:attr @xml
=========

This special *XML* tag is used to dynamically change attributes of the parent element.

By default, tag attributes can't be simply changed.
This tag is commonly used with the `neft:if` attribute, which makes it more dynamic.

Let's consider an example.

In the [Renderer integration][] article, you will find new attribute [neft:style][], which
refers to the [Renderer.Item][] from your styles.

In this example we change the [Renderer.Item::states][] dynamically, according to the
condition ([neft:if][]).

```
<header neft:style="header">
  <neft:attr name="neft:style:states" value="active" neft:if="1 > 0" />
</header>
```

Now, if the condition is true (**1 > 0**), *header* states will be changed to *active*.

Of course, we used really simply condition (**1 > 0**) to visualize the problem.
In practice, you can refer to some data using the string interpolation.

```
<button neft:style="ButtonRed" neft:style:state="disabled">
  <neft:attr name="neft:style:states" value="active" neft:if="user.order.length > 0" />
  Proceed to checkout
</button>
```

This tag can be also used to store commonly used expressions.

```
<neft:fragment neft:name="navItem">
  <neft:attr name="isActive" value="1" neft:if="global.uri.get('path') === data.path" />
  <neft:attr name="neft:style:states" value="active" neft:if="isActive" />

  <div neft:if="isActive">
    <neft:use neft:fragment="subnav" />
  </div>
</neft:fragment>
```

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
					target.attrs.set name, ''

				attrChanges.push new AttrChange
					self: file
					node: node
					target: target
					name: name

			if attrChanges.length
				file.attrChanges = attrChanges

			return
