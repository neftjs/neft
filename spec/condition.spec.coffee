'use strict'

View = require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{renderParse, uid} = require './utils'

describe 'neft:if', ->
	it 'works with positive expression', ->
		source = View.fromHTML uid(), '<div><b neft:if="${2 > 1}">1</b></div>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<div><b>1</b></div>'

	it 'works with negative expression', ->
		source = View.fromHTML uid(), '<div><b neft:if="${1 > 2}">1</b></div>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<div></div>'

	it 'supports runtime updates', ->
		source = View.fromHTML uid(), """
			<neft:fragment neft:name="a">
				<b neft:if="${attrs.x > 1}">OK</b>
				<b neft:if="${attrs.x === 1}">FAIL</b>
			</neft:fragment>
			<neft:use neft:fragment="a" x="1" />
		"""
		View.parse source
		view = source.clone()
		elem = view.node.children[0]

		renderParse view
		assert.is view.node.stringify(), '<b>FAIL</b>'
		elem.attrs.set 'x', 2
		assert.is view.node.stringify(), '<b>OK</b>'
