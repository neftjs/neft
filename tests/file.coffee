'use strict'

View = require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{renderParse, uid} = require './utils'

describe 'View', ->
	it 'can be created using HTML', ->
		view = View.fromHTML uid(), '<b></b>'
		View.parse view
		assert.instanceOf view, View

	it 'clears got HTML', ->
		view = View.fromHTML uid(), '<!--comment--><div>   </div>'
		View.parse view
		assert.is view.node.stringify(), '<div></div>'

	it 'finds fragments', ->
		view = View.fromHTML uid(), '<neft:fragment neft:name="a"></neft:fragment>'
		View.parse view
		assert.is Object.keys(view.fragments).length, 1

	it 'finds uses', ->
		view = View.fromHTML uid(), '<neft:fragment neft:name="a"><b></b></neft:fragment><neft:use neft:fragment="a" />'
		View.parse view
		assert.is view.uses.length, 1

	it 'can be cloned and destroyed', ->
		view = View.fromHTML uid(), '<b></b>'
		View.parse view
		clone = view.clone()

		assert.isNot view, clone
		assert.isNot view.node, clone.node
		assert.is view.node.stringify(), clone.node.stringify()

	it 'is pooled on factory', ->
		path = uid()
		viewStart = View.fromHTML path, '<b></b>'
		View.parse viewStart

		viewFactored = View.factory path
		viewFactored.destroy()
		viewRefactored = View.factory path

		assert.isNot viewFactored, viewStart
		assert.is viewFactored, viewRefactored
