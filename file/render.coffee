'use strict'

[utils, log] = ['utils', 'log'].map require

log = log.scope 'Styles'

module.exports = (File) ->

	File::revert = do (_super = File::revert) -> ->
		r = _super.apply @, arguments

		# off listeners
		@updateStylesParent null

		r

	File::updateStylesParent = do ->
		findStyleByNode = (styles, node) ->
			for style in styles
				if style.node is node
					return style

			for style in styles
				if r = findStyleByNode style.children, node
					return r

			null

		(elem) ->
			@_watchedFile?.replacedByElem.disconnect @updateStylesParent
			@_watchedFile = null

			return unless elem

			parentStyles = elem.self.styles

			# keep looking if no styles found
			unless parentStyles.length
				@_watchedFile = elem.self
				elem.self.onReplacedByElem @updateStylesParent
				return

			# find styles parent walking by the tree
			parentNode = @node._parent
			while parentNode
				parentStyle = findStyleByNode parentStyles, parentNode

				if parentStyle
					for style in @styles
						style.render parentStyle

					return

				parentNode = parentNode._parent

			null

	File::clone = do (_super = File::clone) -> ->

		clone = _super.call @

		# check whether listening is necessary
		proceed = false
		for style in clone.styles
			if style.isAutoParent
				proceed = true
				break

		if proceed
			desc = utils.ENUMERABLE | utils.WRITABLE
			utils.defineProperty clone, '_watchedFile', desc, null

			clone.updateStylesParent = @updateStylesParent.bind clone
			clone.onReplacedByElem clone.updateStylesParent

		clone