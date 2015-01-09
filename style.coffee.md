	'use strict'

	assert = require 'assert'
	utils = require 'utils'
	signal = require 'signal'
	log = require 'log'
	Renderer = require 'renderer'

	log = log.scope 'Styles'

	module.exports = (File, data) ->
		{windowStyle, styles} = data

		class Style
			@__name__ = 'Style'
			@__path__ = 'File.Style'

			@Clone = StyleClone

			@HTML_ATTR = "#{File.HTML_NS}:style"
			@HTML_DEEP_ATTR = "#{Style.HTML_ATTR}:"

			constructor: (opts) ->
				assert.isPlainObject opts
				assert.instanceOf opts.file, File
				assert.instanceOf opts.node, File.Element
				assert.isString opts.id
				assert.isBoolean opts.isRepeat
				assert.isBoolean opts.isScope
				assert.instanceOf opts.parent, Style if opts.parent?
				assert.isPlainObject opts.attrs if opts.attrs?

				{@file, @node, @id, @isRepeat, @isScope, @parent, @attrs} = opts
				@children = []
				@parent?.children.push @

				Object.freeze @

			clone: (originalFile, file, scope) ->
				new StyleClone @, originalFile, file, scope

		class StyleClone
			@__name__ = 'StyleClone'
			@__path__ = 'File.Style.Clone'

			listenRecursive = (node, event, listener) ->
				assert.instanceOf node, File.Element

				node[event] listener

				if node.children
					for child in node.children
						listenRecursive child, event, listener

				null

			constructor: (formula, originalFile, file, scope) ->
				self = @

				assert.instanceOf formula, Style
				assert.instanceOf originalFile, File
				assert.instanceOf file, File

				@formula = formula
				@file = file
				@node = originalFile.node.getCopiedElement formula.node, file.node
				@parent = null
				@children = []
				@isAutoParent = false
				@item = null

				Object.seal @

				# break for the abstract
				unless utils.isClient
					return @

				# get scope
				if formula.isScope
					scope = styles[formula.id]?.withStructure()
					unless scope
						log.warn "Style file `#{formula.id}` can't be find. Operation aborted"
						return @
					else
						@item = scope.mainItem

				unless scope
					scope = windowStyle
					unless scope
						log.warn "Style item `#{formula.id}` doesn't have any style file and `Window` " +
						         "is not defined. Operation aborted."
						return @

				# clone children
				for child in formula.children
					child = child.clone originalFile, file, scope
					child.parent = @
					@children.push child

				# get item
				if @item ?= scope.ids[formula.id]
					if formula.isRepeat
						@item = @item.cloneDeep()

				unless @item
					log.error "Can't find `#{formula.id}` style item"
					return @
				else
					@isAutoParent = !@item.parent

				# attach attrs
				if formula.attrs
					for name, val of formula.attrs when val?
						val = file.funcs?[val] or val
						@setAttr name, val

					# listen on attr change
					@node.onAttrChanged (e) ->
						return unless self.formula.attrs.hasOwnProperty(e.name)
						value = @attrs.get e.name
						if self.file.funcs?[value]
							log.warn "Dynamic listening on Renderer events is not supported"
							return
						self.setAttr e.name, value

				# support HTML anchors
				if @node.name is 'a' and not formula.attrs?.hasOwnProperty("#{Style.HTML_DEEP_ATTR}onPointerClicked")
					@item.onPointerClicked ->
						url = self.node.attrs.get 'href'
						unless url
							return

						self.file.storage.global?.uri = url

				# listen on node changes
				@node.onVisibilityChanged ->
					if self.file.isRendered
						self.updateVisibility()

				if 'text' of @item
					listenRecursive @node, 'onTextChanged', ->
						if self.file.isRendered
							self.updateText()

			render: (parent=@parent) ->
				assert.instanceOf parent, StyleClone if parent?

				if not @item or not @node.visible
					return

				if @isAutoParent and @item isnt parent?.item
					@item.parent = if parent then parent.item else null

				for child in @children
					child.render()

				if 'text' of @item
					@updateText()

				@updateVisibility()

			revert: ->
				unless @item
					return

				if @isAutoParent
					@item.parent = null

				for child in @children
					child.revert()

				null

			updateText: ->
				@item.text = @node.stringifyChildren()

			updateVisibility: ->
				@item.visible = @node.visible

			setAttr: (name, val) ->
				assert.instanceOf @, StyleClone
				assert.ok @formula.attrs.hasOwnProperty(name)

				name = name.slice Style.HTML_DEEP_ATTR.length
				props = name.split ':'
				obj = @item
				for prop, i in props
					if i is props.length - 1
						if typeof obj[prop] is 'function'
							obj[prop] val
						else
							obj[prop] = val
					obj = obj[prop]
				return

		Style
			