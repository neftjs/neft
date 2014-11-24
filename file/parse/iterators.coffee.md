neft:each @html
===============

Special HTML attribute using to create new `File.Iterator`s.

```
<ul neft:each="[1, 2]">
  <li>#{item}</li>
</ul>
```

	'use strict'

	module.exports = (File) -> (file) ->
		# get iterators
		iterators = file.iterators = []

		forNode = (elem) ->

			unless elem.attrs?.get "#{File.HTML_NS}:each"
				return elem.children?.forEach forNode

			# get iterator
			iterators.push new File.Iterator file, elem

		forNode file.node