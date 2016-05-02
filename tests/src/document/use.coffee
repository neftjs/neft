'use strict'

{assert, unit} = Neft
{describe, it} = unit
{createView, renderParse, uid} = require './utils'

describe 'neft:use', ->
	it 'is replaced by neft:fragment', ->
		view = createView """
			<neft:fragment neft:name="a"><b></b></neft:fragment>
			<neft:use neft:fragment="a" />
		"""
		view = view.clone()

		renderParse view
		assert.is view.node.stringify(), '<b></b>'

	it 'is replaced in neft:fragment', ->
		source = createView """
			<neft:fragment neft:name="b">1</neft:fragment>
			<neft:fragment neft:name="a"><neft:use neft:fragment="b" /></neft:fragment>
			<neft:use neft:fragment="a" />
		"""
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '1'

	it 'can be rendered recursively', ->
		source = createView """
			<neft:fragment neft:name="a">
				1
				<neft:use neft:fragment="a" neft:if="${attrs.loops > 0}" loops="${attrs.loops - 1}" />
			</neft:fragment>
			<neft:use neft:fragment="a" loops="3" />
		"""
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '1111'

	it 'can be rendered using short use: syntax', ->
		view = createView """
			<neft:fragment neft:name="a-b"><b></b></neft:fragment>
			<use:a-b />
		"""
		view = view.clone()

		renderParse view
		assert.is view.node.stringify(), '<b></b>'
