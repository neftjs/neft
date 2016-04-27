'use strict'

View = Neft?.Document or require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{createView, renderParse, uid} = require './utils'

describe 'neft:target', ->
	it 'is replaced by the neft:use body', ->
		source = createView """
			<neft:fragment neft:name="a">
				<neft:target />
			</neft:fragment>
			<neft:use neft:fragment="a"><b></b></neft:use>
		"""
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<b></b>'

	it 'can be hidden', ->
		source = createView """
			<neft:fragment neft:name="a">
				<neft:target neft:if="${attrs.x === 1}" />
			</neft:fragment>
			<neft:use neft:fragment="a" x="0"><b></b></neft:use>
		"""
		view = source.clone()
		elem = view.node.children[0]

		renderParse view
		assert.is view.node.stringify(), ''

		elem.attrs.set 'x', 1
		assert.is view.node.stringify(), '<b></b>'
