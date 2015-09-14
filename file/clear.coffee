'use strict'

WHITE_SPACE_RE = ///^\s*$///
WHITE_SPACES_RE = ///^(\r?\n|\r)+\s+///gm
LINE_BREAKERS_RE = ///\r?\n|\r///g
PHRASING_ELEMENTS = ["a", "em", "strong", "small", "mark", "abbr", "dfn", "i", "b",
                     "s", "u", "code", "var", "samp", "kbd", "sup", "sub", "q", "cite",
                     "span", "bdo", "bdi", "br", "wbr", "ins", "del", "img", "embed",
                     "object", "iframe", "map", "area", "script", "noscript", "ruby",
                     "video", "audio", "input", "textarea", "select", "button", "label",
                     "output", "datalist", "keygen", "progress", "command", "canvas",
                     "time", "meter"]

isRemove = (node) ->
	if 'text' of node
		if WHITE_SPACE_RE.test(node.text)
			return true

		unless ~PHRASING_ELEMENTS.indexOf(node.parent.name)
			node.text = node.text
				.replace(WHITE_SPACES_RE, '')

	false

removeEmptyTexts = (node) ->
	nodes = node.children
	return unless nodes
	length = nodes.length
	j = 0
	for i in [0..length] by 1

		elem = nodes[j]
		unless elem then break

		if isRemove elem
			elem.parent = undefined
			j--

		j++

	# check nodes recursively
	for elem, i in node.children
		if elem.name isnt 'script'
			removeEmptyTexts elem

	null

module.exports = (File) -> removeEmptyTexts
