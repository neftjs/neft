'use strict'

View = require('../index.coffee.md')
[utils, signal, Dict, List] = ['utils', 'signal', 'dict', 'list'].map require

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
		expect(view).toEqual jasmine.any View

	it 'clears got HTML', ->

		view = View.fromHTML uid(), '<!--comment--><div>   </div>'
		expect(view.node.stringify()).toBe '<div></div>'

	it 'finds units', ->

		view = View.fromHTML uid(), '<x:unit name="a"></x:unit>'
		expect(view.units).not.toEqual {}

	it 'finds elems', ->

		view = View.fromHTML uid(), '<x:unit name="a"><b></b></x:unit><x:a></x:a>'
		expect(view.elems).not.toEqual {}

	describe 'requires', ->

		it 'finds properly', ->

			first = uid()
			View.fromHTML first, '<b></b>'
			view = View.fromHTML uid(), '<x:require rel="view" href="'+first+'">'
			expect(view.links.length).toBe 1

		describe 'shares units', ->

			it 'without namespace', ->

				first = 'namespace/'+uid()
				View.fromHTML first, '<x:unit name="a"></x:unit>'
				view = View.fromHTML uid(), '<x:require rel="view" href="'+first+'">'
				expect(Object.keys(view.units).length).toBe 1
				expect(Object.keys(view.units)[0]).toBe 'a'

			it 'with namespace', ->

				first = uid()
				View.fromHTML first, '<x:unit name="a"></x:unit>'
				view = View.fromHTML uid(), '<x:require rel="view" href="'+first+'" as="ns">'
				expect(Object.keys(view.units).length).toBe 1
				expect(Object.keys(view.units)[0]).toBe 'ns-a'

	it 'can be cloned and destroyed', ->

		view = View.fromHTML uid(), '<b></b>'
		clone = view.clone()

		expect(view).not.toBe clone
		expect(view.node).not.toBe clone.node
		expect(view.node.stringify()).toBe clone.node.stringify()

	it 'is pooled on factory', ->

		path = uid()
		view_start = View.fromHTML path, '<b></b>'
		view_factored = View.factory path
		view_factored.destroy()
		view_refactored = View.factory path

		expect(view_factored).not.toBe view_start
		expect(view_factored).toBe view_refactored

	it 'can replace elems by units', ->

		view = View.fromHTML uid(), '<x:unit name="a"><b></b></x:unit><x:a></x:a>'
		view = view.clone()

		renderParse view
		expect(view.node.stringify()).toBe '<b></b>'
		view.revert()
		expect(view.node.children[0].name).toBe 'x:a'

	it 'can replace elems by units in units', ->

		source = View.fromHTML uid(), '<x:unit name="b">1</x:unit><x:unit name="a"><x:b></x:b></x:unit><x:a></x:a>'
		view = source.clone();

		renderParse view
		expect(source.node.children[0].name).toBe 'x:a'
		expect(view.node.stringify()).toBe '1'

	it 'can render clone separately', ->

		source = View.fromHTML uid(), '<x:unit name="a"><b></b></x:unit><x:a></x:a>'
		view = source.clone()

		renderParse view
		expect(view.node.stringify()).toBe '<b></b>'
		expect(source.node.children[0].name).toBe 'x:a'

	it 'can put elem body in unit', ->

		source = View.fromHTML uid(), '
			<x:unit name="a"><x:source></x:source></x:unit>
			<x:a><b></b></x:a>'
		view = source.clone()

		renderParse view
		expect(source.node.children[0].name).toBe 'x:a'
		expect(view.node.stringify()).toBe '<b></b>'

	it '`source` element supports updates', ->

		source = View.fromHTML uid(), '
			<x:unit name="a"><x:source x:if="#{x} == 1"></x:source></x:unit>
			<x:a x="0"><b></b></x:a>'
		view = source.clone()
		elem = view.node.children[0]

		renderParse view
		expect(view.node.stringify()).toBe ''

		elem.attrs.set 'x', 1
		expect(view.node.stringify()).toBe '<b></b>'

	it 'reverted view is identical as before render', ->

		view = View.fromHTML uid(), '
			<x:unit name="b"><ul x:each="#{data}"><div x:if="#{each[i]} > 0">1</div></ul></x:unit>
			<x:unit name="a"><x:b data="#{data}"></x:b></x:unit>
			<x:a data="[0,1]"></x:a>'
		view = view.clone()

		ver1 = utils.simplify view
		view.render()
		view.revert()
		ver2 = utils.simplify view

		expect(JSON.stringify(ver1)).toBe JSON.stringify(ver2)

		expect(view.render.bind(view)).not.toThrow()

	it 'parses object in attrs into Object instance', ->

		data = a: 1
		json = JSON.stringify data
		view = View.fromHTML uid(), "<a data='#{json}'></a>"
		[elem] = view.node.children

		expect(elem.attrs.get 'data').toEqual data

	it 'parses array in attrs into Array instance', ->

		data = [1, 2]
		json = JSON.stringify data
		view = View.fromHTML uid(), "<a data='#{json}'></a>"
		[elem] = view.node.children

		expect(elem.attrs.get 'data').toEqual data

	it 'parses dict in attrs into Dict instance', ->

		data = Dict a: 1
		json = "Dict a: 1"
		view = View.fromHTML uid(), "<a data='#{json}'></a>"
		[elem] = view.node.children

		attrValue = elem.attrs.get 'data'
		expect(attrValue).toEqual jasmine.any Dict
		expect(attrValue.items()).toEqual data.items()

	it 'parses list in attrs into List instance', ->

		data = List 1, 2
		json = "List 1, 2"
		view = View.fromHTML uid(), "<a data='#{json}'></a>"
		[elem] = view.node.children

		attrValue = elem.attrs.get 'data'
		expect(attrValue).toEqual jasmine.any List
		expect(attrValue.items()).toEqual data.items()

describe 'View Storage', ->

	describe 'inputs are replaced', ->

		it 'by elem attrs', ->

			source = View.fromHTML uid(), '<x:unit name="a">#{x}</x:unit><x:a x="2"></x:a>'
			view = source.clone()

			renderParse view
			expect(source.node.children[0].name).toBe 'x:a'
			expect(view.node.stringify()).toBe '2'

		it 'by passed storage', ->

			source = View.fromHTML uid(), '<x:unit name="a">#{x}, #{b.a}</x:unit><x:a/>'
			view = source.clone()

			renderParse view,
				storage: x: 2, b: {a: 1}
			expect(source.node.children[0].name).toBe 'x:a'
			expect(view.node.stringify()).toBe '2, 1'

	describe 'supports realtime changes', ->

		it 'on attrs', ->

			source = View.fromHTML uid(), '<x:unit name="a">#{x}</x:unit><x:a x="2" y="1"></x:a>'
			view = source.clone()
			elem = view.node.children[0]

			renderParse view
			elem.attrs.set 'x', 1
			waits 4
			runs ->
				expect(view.node.stringify()).toBe '1'
				view.revert()
				expect(elem.attrs.get('x')).toBe '2'

		it 'on storage', ->

			source = View.fromHTML uid(), '#{x}'
			view = source.clone()

			storage = Dict x: 1

			renderParse view,
				storage: storage
			expect(view.node.stringify()).toBe '1'

			storage.set 'x', 2
			waits 4
			runs ->
				expect(view.node.stringify()).toBe '2'

			waits 4
			runs ->
				view.revert()
				storage.set 'x', 1
				renderParse view,
					storage: storage
				expect(view.node.stringify()).toBe '1'

		it 'on storage deep', ->

			source = View.fromHTML uid(), '#{dict.get \'x\'}'
			view = source.clone()

			storage = dict: Dict x: 1

			renderParse view,
				storage: storage
			expect(view.node.stringify()).toBe '1'

			storage.dict.set 'x', 2
			waits 4
			runs ->
				expect(view.node.stringify()).toBe '2'

describe 'View Condition', ->

	describe 'works in file', ->

		it 'with positive expression', ->

			source = View.fromHTML uid(), '<div><b x:if="2 > 1">1</b></div>'
			view = source.clone()

			renderParse view
			expect(view.node.stringify()).toBe '<div><b>1</b></div>'

		it 'with negative expression', ->

			source = View.fromHTML uid(), '<div><b x:if="1 > 2">1</b></div>'
			view = source.clone()

			renderParse view
			expect(view.node.stringify()).toBe '<div></div>'

	it 'works in units', ->

		source = View.fromHTML uid(), '<x:unit name="a"><b x:if="1 > 2">1</b></x:unit><x:a></x:a>'
		view = source.clone()

		renderParse view
		expect(source.node.children[0].name).toBe 'x:a'
		expect(view.node.stringify()).toBe ''

	it 'can be declared using storage input', ->

		source = View.fromHTML uid(), '<div><b x:if="#{x} > 1">1</b></div>'
		view = source.clone()

		renderParse view, storage: x: 1
		expect(view.node.stringify()).toBe '<div></div>'

		view.revert()
		renderParse view, storage: x: 2
		expect(view.node.stringify()).toBe '<div><b>1</b></div>'

	describe 'supports storage observer', ->

		it 'in changing visibility', ->

			source = View.fromHTML uid(), '<x:unit name="a">' +
			                              '    <b x:if="#{x} > 1">OK</b>' +
			                              '    <b x:if="#{x} == 1">FAIL</b>' +
			                              '</x:unit>' +
			                              '<x:a x="1"></x:a>'
			view = source.clone()
			elem = view.node.children[0]

			renderParse view
			elem.attrs.set 'x', 2
			waits 4
			runs ->
				expect(view.node.stringify()).toBe '<b>OK</b>'
				view.revert()
				expect(view.node.children[0].name).toBe 'x:a'

		it 'in replacing elems', ->

			source = View.fromHTML uid(), '<x:unit name="a">OK</x:unit>' +
			                              '<x:a x:if="#{x} == 1"></x:a>'
			view = source.clone()

			storage = Dict x: 0

			renderParse view, storage: storage
			expect(view.node.stringify()).toBe ''

			storage.set 'x', 1
			waits 4
			runs ->
				expect(view.node.stringify()).toBe 'OK'

describe 'View Iterator', ->

	it 'loops expected times', ->

		source = View.fromHTML uid(), '<ul x:each="[0,0]">1</ul>'
		view = source.clone()

		renderParse view
		expect(view.node.stringify()).toBe '<ul>11</ul>'

	it 'provides `item` property', ->

		source = View.fromHTML uid(), '<ul x:each="[1,2]">#{item}</ul>'
		view = source.clone()

		renderParse view
		expect(view.node.stringify()).toBe '<ul>12</ul>'

	it 'render data in loops', ->

		view = View.fromHTML uid(), '<ul x:each="[{v:1},{v:2}]">#{each[i].v}</ul>'
		view = view.clone()

		renderParse view
		expect(view.node.stringify()).toBe '<ul>12</ul>'

	it 'works with cloned files', ->

		source = View.fromHTML uid(), '<ul x:each="[1,2]">#{each[i]}</ul>'
		view = source.clone()

		renderParse view
		expect(source.node.stringify()).toBe '<ul></ul>'
		expect(view.node.stringify()).toBe '<ul>12</ul>'

	it 'works in units with elems', ->

		source = View.fromHTML uid(), '<x:unit name="b">#{data}</x:unit>
			<x:unit name="a"><ul x:each="#{data}"><x:b data="#{each[i]}"/></ul></x:unit>
			<x:a data="[1,2]"></x:a>'
		view = source.clone()

		renderParse view
		expect(source.node.children[0].name).toBe 'x:a'
		expect(view.node.stringify()).toBe '' +
			'<ul>12</ul>'

	it 'supports updates', ->

		source = View.fromHTML uid(), '<ul x:each="#{arr}">#{each[i]}</ul>'
		view = source.clone()

		storage = arr: arr = List [1, 2]

		renderParse view, storage: storage
		expect(view.node.stringify()).toBe '<ul>12</ul>'

		arr.insert 1, 'a'
		expect(view.node.stringify()).toBe '<ul>1a2</ul>'

		arr.pop 1
		expect(view.node.stringify()).toBe '<ul>12</ul>'

		arr.append 3
		expect(view.node.stringify()).toBe '<ul>123</ul>'

