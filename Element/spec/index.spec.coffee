'use strict'

Element = require('../index')

describe 'View Element', ->

	HTML = '<b><em>abc</em></b><div></div><p title="textTitle" class="a bb c2" data-custom="customValue"></p>'
	doc = null
	b = em = div = p = null

	describe 'parsed html', ->

		it 'is an Element', ->

			doc = Element.fromHTML HTML

			expect(doc).toEqual jasmine.any Element

			b = doc.children[0]
			em = b.children[0]
			div = doc.children[1]
			p = doc.children[2]

		it 'has proper amount of children', ->

			expect(doc.children.length).toBe 3
			expect(b.children.length).toBe 1
			expect(em.children.length).toBe 1
			expect(div.children.length).toBe 0
			expect(p.children.length).toBe 0

		it 'has proper elements names', ->

			expect(doc.name).toBe ''
			expect(b.name).toBe 'b'
			expect(em.name).toBe 'em'
			expect(div.name).toBe 'div'

	it 'stringify to html', ->

		html = doc.stringify()

		expect(html).toBe HTML

	it 'hidden attrs are omitted in the stringified process', ->

		elem = Element.fromHTML '<span if="a" each="a"></span>'
		html = elem.stringify()

		expect(html).toBe '<span></span>'

	it 'stringify children to html', ->

		elem = Element.fromHTML '<span><b></b></span>'
		htmlOuter = elem.children[0].stringify()
		htmlInner = elem.children[0].stringifyChildren()

		expect(htmlOuter).toBe '<span><b></b></span>'
		expect(htmlInner).toBe '<b></b>'

	it 'change parents properly', ->

		em.parent = div
		p.parent = undefined

		expect(em.parent).toBe div
		expect(b.children.length).toBe 0
		expect(div.children.length).toBe 1
		expect(div.children[0]).toBe em
		expect(doc.stringify()).toBe '<b></b><div><em>abc</em></div>'
		expect(-> em.parent = em).toThrow()

		em.parent = b
		p.parent = doc

	describe 'text property', ->

		it 'is filled properly', ->

			expect(b.text).toBeUndefined()
			expect(em.text).toBeUndefined()
			expect(em.children[0].text).toBe 'abc'

		it 'can be changed', ->

			em.children[0].text = '123'
			expect(em.children[0].text).toBe '123'
			expect(b.children[0]).toBe em
			expect(b.stringify()).toBe '<b><em>123</em></b>'

			em.children[0].text = '123'

			# change text with elements in html
			# b.text = '<em>123</em>'
			# b.text = '<em>345</em>'
			# expect(b.children.length).toBe 1
			# expect(b.children[0].name).toBe 'em'
			# expect(b.children[0].children[0].text).toBe '345'
			# expect(b.children[0]).not.toBe em
			# expect(em.parent).toBeUndefined()

			# b.children[0].parent = undefined
			# em.parent = b
	
	it 'can be cloned deep', ->

		clone = b.cloneDeep()
		# clone.attrs.set 'a', 'a'

		expect(clone).toEqual jasmine.any Element
		expect(clone).not.toBe b
		# expect(b.attrs.get 'a').not.toBe 'a'
		expect(clone.children[0]).toEqual jasmine.any Element
		expect(clone.children[0]).not.toBe em
		expect(clone.children[0].name).toBe 'em'

		# clone.attrs.set 'a', undefined
		# expect(clone.stringify()).toBe b.stringify()

	describe 'attrs', ->

		it 'are filled properly', ->

			expect(doc.attrs.item(0)).toEqual [undefined, undefined]
			expect(div.attrs.item(0)).toEqual [undefined, undefined]
			expect(p.attrs.item(0)).toEqual ['title', 'textTitle']
			expect(p.attrs.item(1)).toEqual ['class', 'a bb c2']
			expect(p.attrs.item(2)).toEqual ['data-custom', 'customValue']

			expect(p.attrs.get('title')).toBe 'textTitle'

		it 'can be changed and removed', ->

			elem = p.clone()

			expect(elem.attrs.get 'title').toBe 'textTitle'

			# change
			elem.attrs.set 'title', 'changed value'
			expect(elem.attrs.get 'title').toBe 'changed value'

			# remove
			expect(elem.attrs.item 0).toEqual ['title', 'changed value']
			elem.attrs.set 'title', undefined
			expect(elem.attrs.item 0).toEqual ['class', 'a bb c2']

		it 'can store references to the objects', ->

			elem = p.clone()
			title = elem.attrs.get 'title'
			obj = a: 1

			# change
			elem.attrs.set 'title', obj
			expect(elem.attrs.get 'title').toBe obj
			expect(elem.stringify()).toBe '<p title="[object Object]" class="a bb c2" data-custom="customValue"></p>'

			elem.attrs.set 'title', title

	it 'replace() works properly', ->

		elem = Element.fromHTML '<b><em></em></b><div></div><p></p>'

		[elemB, elemDiv, elemP] = elem.children
		[elemEm] = b.children

		elem.replace elemB, elemP

		expect(elem.children.length).toBe 2
		expect(elem.children[0]).toBe elemP
		expect(elem.stringify()).toBe '<p></p><div></div>'

		elem.replace elemP, elemB
		elemP.parent = elem

		expect(elem.children.length).toBe 3
		expect(elem.children[0]).toBe elemB
		expect(elem.children[1]).toBe elemDiv
		expect(elem.children[2]).toBe elemP
		expect(elem.stringify()).toBe '<b><em></em></b><div></div><p></p>'

	it 'queryAll() returns proper list', ->

		expect(doc.queryAll('b')).toEqual [b]
		expect(doc.queryAll('[title]')).toEqual [p]
 
	it 'getting visible property works recursively', ->

		expect(b.visible).toBeTruthy()
		b.visible = false
		expect(b.visible).toBeFalsy()
		expect(em.visible).toBeFalsy()

		b.visible = true
		expect(b.visible).toBeTruthy()
		expect(em.visible).toBeTruthy()

	it 'visible property is editable', ->

		expect(p.visible).toBeTruthy()
		p.visible = false
		expect(p.visible).toBeFalsy()
		p.visible = true

	describe 'Observer', ->

		{Observer} = Element
		Element.OBSERVE = true

		it 'onAttrChanged works properly', ->

			value = args = null
			elem = Element.fromHTML('<b a="1"></b>').cloneDeep()
			tag = elem.children[0]

			tag.onAttrChanged.connect (node, name) ->
				value = node.attrs.get name
				args = [arguments...]

			tag.attrs.set 'a', 2

			expect(args).toEqual [tag, 'a', '1']
			expect(value).toBe 2

		it 'onVisibilityChanged works properly', ->

			value = args = null
			elem = Element.fromHTML('<b></b>').cloneDeep()
			tag = elem.children[0]

			tag.onVisibilityChanged.connect (node) ->
				value = node.visible
				args = [arguments...]

			tag.visible = false

			expect(args).toEqual [tag, true, undefined]
			expect(value).toBe false

		it 'onTextChanged works properly', ->

			text = args = null
			elem = Element.fromHTML('<b>a</b>').cloneDeep()
			tag = elem.children[0].children[0]

			tag.onTextChanged.connect (node) ->
				text = node.text
				args = [arguments...]

			tag.text = 'b'

			expect(args).toEqual [tag, 'a', undefined]
			expect(text).toBe 'b'

		it 'onParentChanged works properly', ->

			value = args = null
			elem = Element.fromHTML('<a></a><b></b>').cloneDeep()
			tag1 = elem.children[0]
			tag2 = elem.children[1]

			tag2.onParentChanged.connect (node) ->
				value = node.parent
				args = [arguments...]

			tag2.parent = tag1

			expect(args).toEqual [tag2, elem, undefined]
			expect(value).toBe tag1

		it 'disconnect() works as expected', ->

			ok = true
			elem = Element.fromHTML('<b></b>').cloneDeep()
			tag = elem.children[0]

			tag.onVisibilityChanged.connect listener = -> ok = false
			tag.onVisibilityChanged.disconnect listener

			tag.visible = false

			expect(ok).toBeTruthy()

		it 'doesn\'t work if `Element.OBSERVE` flag is `false`', ->

			OBSERVE = Element.OBSERVE
			Element.OBSERVE = false

			ok = true
			elem = b.clone()

			elem.onVisibilityChanged.connect -> ok = false

			elem.visible = false
			expect(ok).toBeTruthy()

			Element.OBSERVE = OBSERVE