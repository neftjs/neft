'use strict'

utils = require 'src/utils'

module.exports = (Document) ->
	{Element} = Document
	{Tag, Text} = Element

	###
	Sets the given linkUri on the styled node or it children.
	###
	setLinkUriForNode = (node, href) ->
		if (docStyle = node._documentStyle)
			docStyle.setLinkUri href
		else if node instanceof Tag
			for child in node.children
				if child instanceof Tag and child.name is 'a' and child.attrs.has('href')
					continue
				setLinkUriForNode child, href
		return

	###
	Override Element::parent setter.
	###
	utils.overrideProperty Element::, 'parent', null, (_super) ->
		updateLinkUri = (node, newParent) ->
			# find nearest 'a' tag
			tmp = newParent
			while tmp
				if tmp.name is 'a' and tmp.attrs.has('href')
					setLinkUriForNode node, tmp.attrs.href
					return true
				if tmp._documentStyle?
					break
				tmp = tmp.parent

			return false

		findItemParent = (node) ->
			tmp = node
			while tmp
				if (docStyle = tmp._documentStyle) and (item = docStyle.item)
					return item
				tmp = tmp.parent
			return null

		setItemParent = (node, newParent) ->
			if (docStyle = node._documentStyle)
				docStyle.setItemParent newParent
			else if node instanceof Tag
				for child in node.children
					setItemParent child, newParent
			return

		(val) ->
			unless _super.call(@, val)
				return false

			unless updateLinkUri(@, val)
				# no link parent found; make sure that node
				# doesn't have any linkUri from the old parent
				setLinkUriForNode @, ''

			newParent = findItemParent val
			setItemParent @, newParent

			true

	###
	Override Element::index setter.
	###
	utils.overrideProperty Element::, 'index', null, (_super) ->
		updateItemIndex = (node) ->
			if (docStyle = node._documentStyle)
				docStyle.findItemIndex()
			else if node instanceof Tag
				for child in node.children
					updateItemIndex child
			return

		(val) ->
			unless _super.call(@, val)
				return false
			updateItemIndex @
			true

	###
	Override Element::index setter.
	###
	utils.overrideProperty Element::, 'index', null, (_super) ->
		(val) ->
			unless _super.call(@, val)
				return false
			true

	###
	Override Element::visible setter.
	###
	utils.overrideProperty Element::, 'visible', null, (_super) ->
		setVisibleForNode = (node, val) ->
			if (docStyle = node._documentStyle)
				docStyle.setVisibility val
			else if node instanceof Tag
				for child in node.children
					setVisibleForNode child, val
			return

		updateTextNode = (node) ->
			while node
				if (docStyle = node._documentStyle)
					if docStyle.textObject
						docStyle.updateText()
					break
				node = node.parent
			return

		(val) ->
			unless _super.call(@, val)
				return false
			setVisibleForNode @, val
			updateTextNode @
			true

	###
	Override Element::text setter.
	###
	utils.overrideProperty Text::, 'text', null, (_super) ->
		updateTextNode = (node) ->
			while node
				if (docStyle = node._documentStyle) and docStyle.textObject
					docStyle.updateText()
					break
				node = node.parent
			return

		(val) ->
			unless _super.call(@, val)
				return false
			updateTextNode @
			true

	###
	Override Tag.Attrs::set method.
	###
	utils.overrideProperty Tag.Attrs::, 'set', (_super) ->
		(name, val) ->
			if docStyle = @_ref._documentStyle
				oldVal = @[name]

			unless _super.call(@, name, val)
				return false

			# update linkUri for this node (if styled) or all styled children
			if name is 'href' and @_ref.name is 'a'
				setLinkUriForNode @_ref, val, oldVal

			if docStyle
				# update style attrs
				if docStyle.attrs?[name]
					docStyle.setAttr name, val, oldVal

				# update classes
				if name is 'class'
					docStyle.syncClassAttr val, oldVal

			true

	return
