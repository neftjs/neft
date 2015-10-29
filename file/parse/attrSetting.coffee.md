Setting attributes @learn
=========================

	'use strict'

	module.exports = (File) ->
		{AttrsToSet} = File

		(file) ->
			attrsToSet = []

			forEachNodeRec = (node) ->
				for child in node.children
					unless child instanceof File.Element.Tag
						continue

					forEachNodeRec child

					nodeProps = null
					for prop of child._attrs
						if prop in ['name', 'children', 'attrs']
							continue
						unless prop of child
							continue
						nodeProps ?= {}
						nodeProps[prop] = true

					if nodeProps
						attrsToSet.push new AttrsToSet child, nodeProps
				return

			forEachNodeRec file.node

			if attrsToSet.length
				file.attrsToSet = attrsToSet

			return
