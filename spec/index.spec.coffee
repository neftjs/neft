'use strict'

View = require '../index.coffee.md'
utils = require 'neft-utils'
signal = require 'neft-signal'
Dict = require 'neft-dict'
List = require 'neft-list'
unit = require 'neft-unit'
assert = require 'neft-assert'

{describe, it} = unit

uid = do (i = 0) -> -> "index_#{i++}.html"

renderParse = (view, opts) ->
	view.storage = opts?.storage
	view.render opts?.source

	view.revert()

	view.storage = opts?.storage
	view.render opts?.source

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

describe 'neft:target', ->
	it 'is replaced by the neft:use body', ->
		source = View.fromHTML uid(), """
			<neft:fragment neft:name="a">
				<neft:target />
			</neft:fragment>
			<neft:use neft:fragment="a"><b></b></neft:use>
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<b></b>'

	it 'can be hidden', ->
		source = View.fromHTML uid(), """
			<neft:fragment neft:name="a">
				<neft:target neft:if="${attrs.x === 1}" />
			</neft:fragment>
			<neft:use neft:fragment="a" x="0"><b></b></neft:use>
		"""
		View.parse source
		view = source.clone()
		elem = view.node.children[0]

		renderParse view
		assert.is view.node.stringify(), ''

		elem.attrs.set 'x', 1
		assert.is view.node.stringify(), '<b></b>'

describe 'attributes', ->
	it 'are parsed to objects', ->
		data = a: 1
		json = JSON.stringify data
		view = View.fromHTML uid(), "<a data='#{json}'></a>"
		View.parse view

		assert.isEqual view.render().node.children[0].attrs.data, data

	it 'are parsed to arrays', ->
		data = [1, 2]
		json = JSON.stringify data
		view = View.fromHTML uid(), "<a data='#{json}'></a>"
		View.parse view

		assert.isEqual view.render().node.children[0].attrs.data, data

	it 'are parsed to Dicts', ->
		data = Dict a: 1
		json = "Dict({a: 1})"
		view = View.fromHTML uid(), "<a data='#{json}'></a>"
		View.parse view

		attrValue = view.render().node.children[0].attrs.data
		assert.instanceOf attrValue, Dict
		assert.isEqual attrValue, data

	it 'are parsed to Lists', ->
		data = List [1, 2]
		json = "List([1, 2])"
		view = View.fromHTML uid(), "<a data='#{json}'></a>"
		View.parse view

		attrValue = view.render().node.children[0].attrs.data
		assert.instanceOf attrValue, List
		assert.isEqual attrValue, data

describe 'neft:require', ->
	describe 'shares fragments', ->
		it 'without namespace', ->
			first = 'namespace/'+uid()
			view1 = View.fromHTML first, '<neft:fragment neft:name="a"></neft:fragment>'
			View.parse view1

			view2 = View.fromHTML uid(), '<neft:require href="'+first+'" />'
			View.parse view2

			assert.is Object.keys(view2.fragments).length, 1
			assert.is Object.keys(view2.fragments)[0], 'a'

		it 'with namespace', ->
			first = uid()
			view1 = View.fromHTML first, '<neft:fragment neft:name="a"></neft:fragment>'
			View.parse view1

			view2 = View.fromHTML uid(), '<neft:require href="'+first+'" as="ns">'
			View.parse view2

			assert.is Object.keys(view2.fragments).length, 1
			assert.is Object.keys(view2.fragments)[0], 'ns:a'


describe 'string interpolation', ->
	describe '`attrs`', ->
		it 'support neft:fragment', ->
			source = View.fromHTML uid(), """
				<neft:fragment neft:name="a" x="2">${attrs.x}</neft:fragment>
				<neft:use neft:fragment="a" />
			"""
			View.parse source
			view = source.clone()

			renderParse view
			assert.is view.node.stringify(), '2'

		it 'support neft:use', ->
			source = View.fromHTML uid(), """
				<neft:fragment neft:name="a" x="1">${attrs.x}</neft:fragment>
				<neft:use neft:fragment="a" x="2" />
			"""
			View.parse source
			view = source.clone()

			renderParse view
			assert.is view.node.stringify(), '2'

	it '`this` refers to the global storage', ->
		source = View.fromHTML uid(), """
			<neft:fragment neft:name="a">${this.x}, ${this.b.a}</neft:fragment>
			<neft:use neft:fragment="a" />
		"""
		View.parse source
		view = source.clone()

		renderParse view,
			storage: x: 2, b: {a: 1}
		assert.is view.node.stringify(), '2, 1'

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

	it 'handler is called on signal', ->
		source = View.fromHTML uid(), """
			<span x="1" onAttrsChange="${this.onAttrsChange(2)}" />
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
			<span x="1" onAttrsChange="${this.onAttrsChange}" />
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

		it 'on `this`', ->
			source = View.fromHTML uid(), "${this.x}"
			View.parse source
			view = source.clone()

			storage = new Dict x: 1

			renderParse view,
				storage: storage
			assert.is view.node.stringify(), '1'

			storage.set 'x', 2
			assert.is view.node.stringify(), '2'

		it 'on `this` deeply', ->
			source = View.fromHTML uid(), "${this.dict.x}"
			View.parse source
			view = source.clone()

			storage = dict: new Dict x: 1

			renderParse view,
				storage: storage
			assert.is view.node.stringify(), '1'

			storage.dict.set 'x', 2
			assert.is view.node.stringify(), '2'

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

describe 'neft:each', ->
	it 'loops expected times', ->
		source = View.fromHTML uid(), '<ul neft:each="[0,0]">1</ul>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>11</ul>'

	it 'provides `this.item` property', ->
		source = View.fromHTML uid(), '<ul neft:each="[1,2]">${this.item}</ul>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>12</ul>'

	it 'provides `this.i` property', ->
		source = View.fromHTML uid(), '<ul neft:each="[1,2]">${this.i}</ul>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>01</ul>'

	it 'provides `this.each` property', ->
		source = View.fromHTML uid(), '<ul neft:each="[1,2]">${this.each}</ul>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>1,21,2</ul>'

	it 'supports runtime updates', ->
		source = View.fromHTML uid(), '<ul neft:each="${this.arr}">${this.each[this.i]}</ul>'
		View.parse source
		view = source.clone()

		storage = arr: arr = new List [1, 2]

		renderParse view, storage: storage
		assert.is view.node.stringify(), '<ul>12</ul>'

		arr.insert 1, 'a'
		assert.is view.node.stringify(), '<ul>1a2</ul>'

		arr.pop 1
		assert.is view.node.stringify(), '<ul>12</ul>'

		arr.append 3
		assert.is view.node.stringify(), '<ul>123</ul>'
