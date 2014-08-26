'use strict'

module.exports = (File) -> (file) ->

	# get iterators
	iterators = file.iterators = []

	forNode = (elem) ->

		unless elem.attrs?.get 'x:each'
			return elem.children?.forEach forNode

		# get iterator
		iterators.push new File.Iterator file, elem

	forNode file.node