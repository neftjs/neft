'use strict'

Element = require('../index.coffee.md') 'htmlparser'

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

			expect(doc.name).toBeUndefined()
			expect(b.name).toBe 'b'
			expect(em.name).toBe 'em'
			expect(div.name).toBe 'div'

	it 'stringify to html', ->

		html = doc.stringify()

		expect(html).toBe HTML

	it 'change parents properly', ->

		em.parent = div
		p.parent = undefined

		expect(em.parent).toBe div
		expect(b.children.length).toBe 0
		expect(div.children.length).toBe 1
		expect(div.children[0]).toBe em
		expect(doc.stringify()).toBe '<b></b><div><em>abc</em></div>'
		expect(-> em.parent = em).toThrow 'false == true'

		em.parent = b
		p.parent = doc

	describe 'text property', ->

		it 'is filled properly', ->

			expect(b.text).toBeUndefined()
			expect(em.text).toBeUndefined()
			expect(em.children[0].text).toBe 'abc'

		it 'can be changed', ->

			em.text = 123
			expect(em.children[0].text).toBe '123'
			expect(b.children[0]).toBe em
			expect(b.stringify()).toBe '<em>123</em>'

			em.text = 'abc'

			# change text with elements in html
			b.text = '<em>123</em>'
			b.text = '<em>345</em>'
			expect(b.children.length).toBe 1
			expect(b.children[0].name).toBe 'em'
			expect(b.children[0].children[0].text).toBe '345'
			expect(b.children[0]).not.toBe em
			expect(em.parent).toBeUndefined()

			b.children[0].parent = undefined
			em.parent = b
	
	it 'can be cloned deep', ->

		clone = b.cloneDeep()
		clone.attrs.set 'a', 'a'

		expect(clone).toEqual jasmine.any Element
		expect(clone).not.toBe b
		expect(b.attrs.get 'a').not.toBe 'a'
		expect(clone.children[0]).toEqual jasmine.any Element
		expect(clone.children[0]).not.toBe em
		expect(clone.children[0].name).toBe 'em'
		expect(clone.stringify()).toBe b.stringify()

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

			# append new
			expect(elem.attrs.item(2)).toEqual [undefined, undefined]
			elem.attrs.set 'b', 'c'
			expect(elem.attrs.item(2)).toEqual ['b', 'c']

	describe 'index', ->

		it 'is filled properly', ->

			expect(doc.index).toBeUndefined()
			expect(b.index).toBe 0
			expect(em.index).toBe 0
			expect(div.index).toBe 1
			expect(p.index).toBe 2

		it 'can be changed', ->

			div.index = 0

			expect(div.index).toBe 0
			expect(b.index).toBe 1

			b.index = 0

			expect(div.index).toBe 1
			expect(b.index).toBe 0

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

		expect(doc.queryAll('>*')).toEqual [b, div, p]
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