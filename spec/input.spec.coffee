'use strict'

View = require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{renderParse, uid} = require './utils'
Dict = require 'neft-dict'
List = require 'neft-list'

describe 'string interpolation', ->
	describe '`attrs`', ->
		it 'lookup neft:fragment', ->
			source = View.fromHTML uid(), """
				<neft:fragment neft:name="a" x="2">${attrs.x}</neft:fragment>
				<neft:use neft:fragment="a" />
			"""
			View.parse source
			view = source.clone()

			renderParse view
			assert.is view.node.stringify(), '2'

		it 'lookup neft:use', ->
			source = View.fromHTML uid(), """
				<neft:fragment neft:name="a" x="1">${attrs.x}</neft:fragment>
				<neft:use neft:fragment="a" x="2" />
			"""
			View.parse source
			view = source.clone()

			renderParse view
			assert.is view.node.stringify(), '2'

		it 'lookup neft:use deeply', ->
			source = View.fromHTML uid(), """
				<neft:fragment neft:name="a" x="1">
					<neft:fragment neft:name="b" x="1">
						${attrs.x}
					</neft:fragment>
					<neft:use neft:fragment="b" />
				</neft:fragment>
				<neft:use neft:fragment="a" x="2" />
			"""
			View.parse source
			view = source.clone()

			renderParse view
			assert.is view.node.stringify(), '2'

		it 'updates neft:use deeply lookup', ->
			source = View.fromHTML uid(), """
				<neft:fragment neft:name="a" x="1">
					<neft:fragment neft:name="b" x="1">
						${attrs.x}
					</neft:fragment>
					<neft:use neft:fragment="b" />
				</neft:fragment>
				<neft:use neft:fragment="a" x="2" />
			"""
			View.parse source
			view = source.clone()
			child = view.node.children[0]

			renderParse view
			assert.is view.node.stringify(), '2'
			child.attrs.set 'x', 3
			assert.is view.node.stringify(), '3'

		it 'always keeps proper sources order', ->
			source = View.fromHTML uid(), """
				<neft:fragment neft:name="a" x="1">
					<neft:fragment neft:name="b" x="1">
						${attrs.x}
					</neft:fragment>
					<neft:use neft:fragment="b" x="4" />
				</neft:fragment>
				<neft:use neft:fragment="a" x="3" />
			"""
			View.parse source
			view = source.clone()

			renderParse view,
				storage: storage = new Dict x: 2

			useA = view.node.children[0]
			fragmentA = useA.children[0]
			useB = fragmentA.children[0]
			fragmentB = useB.children[0]
			assert.is view.node.stringify(), '4'

			storage.set 'x', -1
			fragmentA.attrs.set 'x', -1
			useA.attrs.set 'x', -1
			fragmentB.attrs.set 'x', -1
			assert.is view.node.stringify(), '4'

			storage.set 'x', 2
			fragmentA.attrs.set 'x', 1
			useA.attrs.set 'x', 3
			fragmentB.attrs.set 'x', 1

			useB.attrs.set 'x', undefined
			assert.is view.node.stringify(), '3'

			useA.attrs.set 'x', undefined
			assert.is view.node.stringify(), '2'

			storage.pop 'x'
			assert.is view.node.stringify(), '1'

			fragmentB.attrs.set 'x', 2
			assert.is view.node.stringify(), '1'

			fragmentA.attrs.set 'x', 3
			assert.is view.node.stringify(), '3'

			fragmentA.attrs.set 'x', undefined
			assert.is view.node.stringify(), '2'

	it '`ids` refers to nodes', ->
		source = View.fromHTML uid(), """
			<a id="first" label="12" visible="false" />
			${ids.first.attrs.label}
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '12'

		view.node.children[0].attrs.set 'label', 23
		assert.is view.node.stringify(), '23'

	it 'file `ids` are accessed in fragments', ->
		source = View.fromHTML uid(), """
			<a id="first" label="12" visible="false" />
			<neft:fragment neft:name="a">
				${ids.first.attrs.label}
			</neft:fragment>
			<neft:use neft:fragment="a" />
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '12'

		view.node.children[0].attrs.set 'label', 23
		assert.is view.node.stringify(), '23'

	it '`funcs` refers to neft:functions', ->
		source = View.fromHTML uid(), """
			<neft:function neft:name="pow" arguments="num">
				return num * num;
			</neft:function>
			${funcs.pow(3)}
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '9'

	it 'file `funcs` are accessed in neft:functions', ->
		source = View.fromHTML uid(), """
			<neft:function neft:name="pow" arguments="num">
				return num * num;
			</neft:function>
			<neft:fragment neft:name="a">
				${funcs.pow(3)}
			</neft:fragment>
			<neft:use neft:fragment="a" />
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '9'

	it 'fragment neft:functions are accessed in this fragment', ->
		source = View.fromHTML uid(), """
			<neft:fragment neft:name="a">
				<neft:function neft:name="pow" arguments="num">
					return num * num;
				</neft:function>

				${funcs.pow(3)}
			</neft:fragment>
			<neft:use neft:fragment="a" />
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '9'

	it 'handler is called on signal', ->
		source = View.fromHTML uid(), """
			<span x="1" onAttrsChange="${attrs.onAttrsChange(2)}" />
		"""
		View.parse source
		view = source.clone()

		calls = 0
		renderParse view,
			storage:
				onAttrsChange: (val) ->
					calls += 1
					assert.is val, 2

		view.node.children[0].attrs.set 'x', 2
		assert.is calls, 1

	it 'returned handler is called on signal with context and parameters', ->
		source = View.fromHTML uid(), """
			<span x="1" onAttrsChange="${attrs.onAttrsChange}" />
		"""
		View.parse source
		view = source.clone()

		calls = 0
		renderParse view,
			storage:
				onAttrsChange: (prop, oldVal) ->
					calls += 1
					assert.is this, view.node.children[0]
					assert.is prop, 'x'
					assert.is oldVal, 1

		view.node.children[0].attrs.set 'x', 2
		assert.is calls, 1

	it 'attribute handler is called with proper context and parameters', ->
		source = View.fromHTML uid(), """
			<neft:attr name="y" value="3" />
			<span x="1" id="a1" onAttrsChange="${attrs.onAttrsChange(ids.a1.attrs.x, attrs.y)}" />
		"""
		View.parse source
		view = source.clone()

		calls = 0
		renderParse view,
			storage:
				onAttrsChange: (x, y) ->
					calls += 1
					assert.is x, 2
					assert.is y, 3

		view.node.query('span').attrs.set 'x', 2
		assert.is calls, 1

	it 'attribute handler is not called if the document is not rendered', ->
		source = View.fromHTML uid(), """
			<neft:attr name="y" value="3" />
			<span x="1" id="a1" onAttrsChange="${this.onAttrsChange()}" />
		"""
		View.parse source
		view = source.clone()

		calls = 0
		renderParse view,
			storage:
				onAttrsChange: (x, y) ->
					calls += 1

		view.revert()
		view.node.query('span').attrs.set 'x', 2
		assert.is calls, 0

	describe 'support realtime changes', ->
		it 'on `attrs`', ->
			source = View.fromHTML uid(), """
				<neft:fragment neft:name="a">${attrs.x}</neft:fragment>
				<neft:use neft:fragment="a" x="2" y="1" />
			"""
			View.parse source
			view = source.clone()
			elem = view.node.children[0]

			renderParse view
			elem.attrs.set 'x', 1
			assert.is view.node.stringify(), '1'

		it 'on file `attrs`', ->
			source = View.fromHTML uid(), "${attrs.x}"
			View.parse source
			view = source.clone()

			storage = new Dict x: 1

			renderParse view,
				storage: storage
			assert.is view.node.stringify(), '1'

			storage.set 'x', 2
			assert.is view.node.stringify(), '2'

		it 'on file `attrs` deeply', ->
			source = View.fromHTML uid(), "${attrs.dict.x}"
			View.parse source
			view = source.clone()

			storage = dict: new Dict x: 1

			renderParse view,
				storage: storage
			assert.is view.node.stringify(), '1'

			storage.dict.set 'x', 2
			assert.is view.node.stringify(), '2'
