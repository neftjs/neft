'use strict'

module.exports = (File) ->
	File::_clone = do (_super = File::_clone) -> ->
		clone = _super.call @

		# styles
		for style, i in @styles
			clone.styles.push style.clone @, clone

		clone
