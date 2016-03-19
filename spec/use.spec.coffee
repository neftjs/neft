'use strict'

View = require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{renderParse, uid} = require './utils'

describe 'neft:use', ->
	it 'is replaced by neft:fragment', ->
		view = View.fromHTML uid(), """
			<neft:fragment neft:name="a"><b></b></neft:fragment>
			<neft:use neft:fragment="a" />
		"""
		View.parse view
		view = view.clone()

		renderParse view
		assert.is view.node.stringify(), '<b></b>'

	it 'is replaced in neft:fragment', ->
		source = View.fromHTML uid(), """
			<neft:fragment neft:name="b">1</neft:fragment>
			<neft:fragment neft:name="a"><neft:use neft:fragment="b" /></neft:fragment>
			<neft:use neft:fragment="a" />
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '1'

	it 'can be rendered recursively', ->
		source = View.fromHTML uid(), """
			<neft:fragment neft:name="a">
				1
				<neft:use neft:fragment="a" neft:if="${attrs.loops > 0}" loops="${attrs.loops - 1}" />
			</neft:fragment>
			<neft:use neft:fragment="a" loops="3" />
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '1111'
