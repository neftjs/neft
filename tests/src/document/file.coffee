'use strict'

{assert, unit, Document} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

describe 'src/document View', ->
	it 'can be created using HTML', ->
		view = createView '<b></b>'
		assert.instanceOf view, Document

	it 'clears got HTML', ->
		view = createView '<!--comment--><div>   </div>'
		assert.is view.node.stringify(), '<div></div>'

	it 'finds fragments', ->
		view = createView '<neft:fragment neft:name="a"></neft:fragment>'
		assert.is Object.keys(view.fragments).length, 1

	it 'finds uses', ->
		view = createView '<neft:fragment neft:name="a"><b></b></neft:fragment><neft:use neft:fragment="a" />'
		assert.is view.uses.length, 1

	it 'can be cloned and destroyed', ->
		view = createView '<b></b>'
		clone = view.clone()

		assert.isNot view, clone
		assert.isNot view.node, clone.node
		assert.is view.node.stringify(), clone.node.stringify()

	it 'is pooled on factory', ->
		path = uid()
		viewStart = createView '<b></b>', path

		viewFactored = Document.factory path
		viewFactored.destroy()
		viewRefactored = Document.factory path

		assert.isNot viewFactored, viewStart
		assert.is viewFactored, viewRefactored
