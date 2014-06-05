'use strict'

WHITE_SPACE_RE = ///^\s*$///
WHITE_SPACES_RE = ///^\s*|\s*$///gm
LINE_BREAKERS_RE = ///\r?\n|\r///g
PHRASING_ELEMENTS = ["A", "EM", "STRONG", "SMALL", "MARK", "ABBR",
                     "DFN", "I", "B", "S", "U", "CODE", "VAR", "SAMP",
                     "KBD", "SUP", "SUB", "Q", "CITE", "SPAN", "BDO",
                     "BDI", "BR", "WBR", "INS", "DEL", "IMG", "EMBED",
                     "OBJECT", "IFRAME", "MAP", "AREA", "SCRIPT",
                     "NOSCRIPT", "RUBY", "VIDEO", "AUDIO", "INPUT",
                     "TEXTAREA", "SELECT", "BUTTON", "LABEL", "OUTPUT",
                     "DATALIST", "KEYGEN", "PROGRESS", "COMMAND",
                     "CANVAS", "TIME", "METER"]

isRemove = (node) ->

	switch node.name

		when '#comment'

			true

		when '#text'

			if WHITE_SPACE_RE.test node.text then return true

			unless ~PHRASING_ELEMENTS.indexOf node.parent.name
				node.text = node.text
					.replace(WHITE_SPACES_RE, '')
					.replace(LINE_BREAKERS_RE, '')

			false

		else

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

module.exports = (File) -> removeEmptyTexts