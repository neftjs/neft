'use strict'

[utils, log] = ['utils', 'log'].map require
# [Styles] = ['styles'].map require

log = log.scope 'Styles'

module.exports = (File) ->

	return;

	master = null

	setMaster = (file) ->
		item = file?.rootStyle._stylesItem

		Styles.setMaster item
		master = file

	File::render = do (_super = File::render) -> ->
		r = _super.apply @, arguments

		# set master style
		if @constructor is File and not master
			setMaster @

		r

	File::revert = do (_super = File::revert) -> ->
		r = _super.apply @, arguments

		# off listeners
		if @_stylesItem
			@updateStylesParent null

		if @rootStyle
			# remove styles
			@rootStyle._stylesItem?.parent = null

			# unbind master style
			if @ is master
				setMaster null

		r

	File::updateStylesParent = (elem) ->
		@_watchedFile?.replacedByElem.disconnect @updateStylesParent
		@_watchedFile = null

		return unless elem

		styles = elem.self.styles

		unless styles.length
			@_watchedFile = elem.self
			elem.self.onReplacedByElem @updateStylesParent
			return

		# find styles parent in element styles
		# for style in styles
		# 	continue unless style._stylesItem instanceof Styles.Node

		# 	@_stylesItem.parent = style._stylesItem
		# 	return

		# find styles parent walking by the tree
		# TODO: optimize it
		parent = @node._parent
		while parent
			for style in styles
				continue if parent isnt style.node
				continue unless style._stylesItem instanceof Styles.Node

				@_stylesItem.parent = style._stylesItem
				return

			parent = parent._parent

		log.error "Can't find styles parent for `#{@id}` view; ended at `#{elem.name}` element"

		null

	File::clone = do (_super = File::clone) -> ->

		clone = _super.call @

		if clone._stylesItem
			utils.defProp clone, '_watchedFile', 'cw', null

			clone.updateStylesParent = (arg1) => @updateStylesParent.call clone, arg1
			clone.onReplacedByElem clone.updateStylesParent

		clone