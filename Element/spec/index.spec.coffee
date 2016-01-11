'use strict'

unit = require 'unit'
utils = require 'utils'
assert = require 'neft-assert'

Element = require('../index')

{describe, it, beforeEach, whenChange} = unit

describe 'View Element', ->
	HTML = '<b><em>abc</em></b><u></u><p title="textTitle" class="a bb c2" data-custom="customValue"></p>'
	doc = null
	b = em = div = p = null

	describe 'parsed html', ->
		it 'is an Element', ->
			doc = Element.fromHTML HTML

			assert.instanceOf doc, Element

			b = doc.children[0]
			em = b.children[0]
			div = doc.children[1]
			p = doc.children[2]

		it 'has proper amount of children', ->
			assert.is doc.children.length, 3
			assert.is b.children.length, 1
			assert.is em.children.length, 1
			assert.is div.children.length, 0
			assert.is p.children.length, 0

		it 'has proper elements names', ->
			assert.is doc.name, 'neft:blank'
			assert.is b.name, 'b'
			assert.is em.name, 'em'
			assert.is div.name, 'u'

	it 'stringify to html', ->
		html = doc.stringify()

		assert.is html, HTML

	it 'hidden attrs are omitted in the stringified process', ->
		elem = Element.fromHTML '<span neft:if="a" neft:each="a"></span>'
		html = elem.stringify()

		assert.is html, '<span></span>'

	it 'stringify children to html', ->
		elem = Element.fromHTML '<span><b></b></span>'
		htmlOuter = elem.children[0].stringify()
		htmlInner = elem.children[0].stringifyChildren()

		assert.is htmlOuter, '<span><b></b></span>'
		assert.is htmlInner, '<b></b>'

	it 'change parents properly', ->
		em.parent = div
		p.parent = undefined

		assert.is em.parent, div
		assert.is b.children.length, 0
		assert.is div.children.length, 1
		assert.is div.children[0], em
		assert.is doc.stringify(), '<b></b><u><em>abc</em></u>'
		try
			em.parent = em
		catch err
		assert.isDefined err

		em.parent = b
		p.parent = doc

	describe 'text property', ->
		it 'is filled properly', ->
			assert.is b.text, undefined
			assert.is em.text, undefined
			assert.is em.children[0].text, 'abc'

		it 'can be changed', ->
			em.children[0].text = '123'
			assert.is em.children[0].text, '123'
			assert.is b.children[0], em
			assert.is b.stringify(), '<b><em>123</em></b>'

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

		assert.instanceOf clone, Element
		assert.isNot clone, b
		assert.instanceOf clone.children[0], Element
		assert.isNot clone.children[0], em
		assert.is clone.children[0].name, 'em'

	describe 'attrs', ->
		it 'are filled properly', ->
			assert.isEqual doc.attrs.item(0), [undefined, undefined]
			assert.isEqual div.attrs.item(0), [undefined, undefined]
			assert.isEqual p.attrs.item(0), ['title', 'textTitle']
			assert.isEqual p.attrs.item(1), ['class', 'a bb c2']
			assert.isEqual p.attrs.item(2), ['data-custom', 'customValue']

			assert.is p.attrs.get('title'), 'textTitle'

		it 'can be changed', ->
			elem = p.clone()

			assert.is elem.attrs.get('title'), 'textTitle'

			# change
			elem.attrs.set 'title', 'changed value'
			assert.is elem.attrs.get('title'), 'changed value'

		it 'can store references to the objects', ->
			elem = p.clone()
			title = elem.attrs.get 'title'
			obj = a: 1

			# change
			elem.attrs.set 'title', obj
			assert.is elem.attrs.get('title'), obj
			assert.is elem.stringify(), '<p title="[object Object]" class="a bb c2" data-custom="customValue"></p>'

			elem.attrs.set 'title', title

	describe 'index property', ->
		it 'returns child index in the parent', ->
			assert.is div.index, 1

		it 'change child index in the parent', ->
			elem = Element.fromHTML '<a></a><b></b>'
			[elemA, elemB] = elem.children

			elemB.index = 0

			assert.isEqual elem.children, [elemB, elemA], maxDeep: 1

	it 'replace() works properly', ->
		elem = Element.fromHTML '<b><em></em></b><u></u><p></p>'

		[elemB, elemDiv, elemP] = elem.children
		[elemEm] = b.children

		elem.replace elemB, elemP

		assert.is elem.children.length, 2
		assert.is elem.children[0], elemP
		assert.is elem.stringify(), '<p></p><u></u>'

		elem.replace elemP, elemB
		elemP.parent = elem

		assert.is elem.children.length, 3
		assert.is elem.children[0], elemB
		assert.is elem.children[1], elemDiv
		assert.is elem.children[2], elemP
		assert.is elem.stringify(), '<b><em></em></b><u></u><p></p>'

	describe 'queryAll() works with selector', ->
		doc2 = Element.fromHTML "<div><b class='first second'><u color='blue' attr='1'>text1<u></u></u></b></div><div attr='2'><neft:blank><em>text2</em></neft:blank><em></em></div>"
		doc2div1 = doc2.children[0]
		doc2b = doc2div1.children[0]
		doc2u = doc2b.children[0]
		doc2u2 = doc2u.children[1]
		doc2div2 = doc2.children[1]
		doc2em1 = doc2div2.children[0].children[0]
		doc2em2 = doc2div2.children[1]

		it 'E', ->
			assert.isEqual doc2.queryAll('div'), [doc2div1, doc2div2], maxDeep: 1
			assert.isEqual doc2.queryAll('u'), [doc2u, doc2u2], maxDeep: 1

		it 'E F', ->
			assert.isEqual doc2.queryAll('div u'), [doc2u, doc2u2], maxDeep: 1
			assert.isEqual doc2.queryAll('b u'), [doc2u, doc2u2], maxDeep: 1
			assert.isEqual doc2.queryAll('b div'), []

		it 'E > F', ->
			assert.isEqual doc2.queryAll('div > u'), []
			assert.isEqual doc2.queryAll('div > b'), [doc2b], maxDeep: 1
			assert.isEqual doc2.queryAll('b > u'), [doc2u], maxDeep: 1

		it '[foo]', ->
			assert.isEqual doc2.queryAll('[attr]'), [doc2u, doc2div2], maxDeep: 1
			assert.isEqual doc2.queryAll('[color]'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[width]'), []

		it '[foo=bar]', ->
			assert.isEqual doc2.queryAll('[attr=2]'), [doc2div2], maxDeep: 1
			assert.isEqual doc2.queryAll('[attr="2"]'), [doc2div2], maxDeep: 1
			assert.isEqual doc2.queryAll('[attr=\'2\']'), [doc2div2], maxDeep: 1
			assert.isEqual doc2.queryAll('[attr=3]'), []

		it '[foo^=bar]', ->
			assert.isEqual doc2.queryAll('[color^=bl]'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color^="b"]'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color^=\'blue\']'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color^=lue]'), []

		it '[foo$=bar]', ->
			assert.isEqual doc2.queryAll('[color$=ue]'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color$="e"]'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color$=\'blue\']'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color$=blu]'), []

		it '[foo*=bar]', ->
			assert.isEqual doc2.queryAll('[color*=bl]'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color*="lu"]'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color*=\'blue\']'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color*=bl][color*=lu]'), [doc2u], maxDeep: 1
			assert.isEqual doc2.queryAll('[color*=lue1]'), []

		it '.foo', ->
			assert.isEqual doc2.queryAll('.first'), [doc2b], maxDeep: 1
			assert.isEqual doc2.queryAll('.first.second'), [doc2b], maxDeep: 1
			assert.isEqual doc2.queryAll('.first.second.third'), []

		it 'E.foo', ->
			assert.isEqual doc2.queryAll('b.first'), [doc2b], maxDeep: 1
			assert.isEqual doc2.queryAll('b.first.second'), [doc2b], maxDeep: 1
			assert.isEqual doc2.queryAll('b.first.second.third'), []

		it '*', ->
			assert.isEqual doc2.queryAll('*'), [doc2div1, doc2b, doc2u, doc2u2, doc2div2, doc2em1, doc2em2], maxDeep: 1

		it '*[foo]', ->
			assert.isEqual doc2.queryAll('*[color]'), [doc2u], maxDeep: 1

		it 'E > * > F[foo]', ->
			assert.isEqual doc2.queryAll('div > * > u[color]'), [doc2u], maxDeep: 1

		it 'E > * > F[foo], F[foo]', ->
			assert.isEqual doc2.queryAll('div > * > u[color], div[attr]'), [doc2u, doc2div2], maxDeep: 1
			assert.isEqual doc2.queryAll('div > * > u[color],div[attr]'), [doc2u, doc2div2], maxDeep: 1

		it '#text', ->
			assert.isEqual doc2.queryAll('#text'), [doc2u.children[0], doc2em1.children[0]], maxDeep: 1

		it 'E #text', ->
			assert.isEqual doc2.queryAll('em #text'), [doc2em1.children[0]], maxDeep: 1

		it 'omits neft:blank', ->
			assert.isEqual doc2.queryAll('div > em'), [doc2em1, doc2em2], maxDeep: 1

	describe 'query() works with selector', ->
		doc2 = Element.fromHTML "<div><b><u color='blue' attr='1'></u></b></div><div attr='2'><neft:blank><em></em></neft:blank></div>"
		doc2div1 = doc2.children[0]
		doc2b = doc2div1.children[0]
		doc2u = doc2b.children[0]
		doc2div2 = doc2.children[1]
		doc2em = doc2div2.children[0].children[0]

		it 'E', ->
			assert.is doc2.query('div'), doc2div1
			assert.is doc2.query('u'), doc2u

		it '[foo]', ->
			assert.is doc2.query('[attr]'), doc2u
			assert.is doc2.query('[color]'), doc2u
			assert.is doc2.query('[width]'), null

		it 'omits neft:blank', ->
			assert.is doc2.query('div > em'), doc2em

	describe 'queryParents() works with selector', ->
		doc2 = Element.fromHTML "<div><b><u color='blue' attr='1'></u></b></div><div attr='2'><neft:blank><em></em></neft:blank></div>"
		doc2div1 = doc2.children[0]
		doc2b = doc2div1.children[0]
		doc2u = doc2b.children[0]
		doc2div2 = doc2.children[1]
		doc2em = doc2div2.children[0].children[0]

		it 'E', ->
			assert.is doc2u.queryParents('div'), doc2div1
			assert.is doc2b.queryParents('div'), doc2div1

		it 'E > F', ->
			assert.is doc2u.queryParents('div > b'), doc2div1
			assert.is doc2u.queryParents('div > b >'), doc2div1

	describe 'watch()', ->
		tags = doc2 = doc2div1 = doc2b = doc2u = doc2u2 = doc2div2 = doc2em1 = doc2em2 = null

		beforeEach ->
			tags = []
			doc2 = Element.fromHTML "<div><b><u color='blue' attr='1'><u></u></u></b></div><div attr='2'><neft:blank><em>text1</em></neft:blank><em></em></div>"
			doc2div1 = doc2.children[0]
			doc2b = doc2div1.children[0]
			doc2u = doc2b.children[0]
			doc2u2 = doc2b.children[0].children[0]
			doc2div2 = doc2.children[1]
			doc2em1 = doc2div2.children[0].children[0]
			doc2em2 = doc2div2.children[1]

		it 'is a function', ->
			assert.instanceOf doc2.watch, Function

		describe 'works with selector', ->
			it 'E', (done) ->
				doc2b.parent = null
				watcher = doc2.watch 'b'
				watcher.onAdd (tag) ->
					tags.push tag
				doc2b.parent = doc2div1
				whenChange tags, ->
					assert.isEqual tags, [doc2b], maxDeep: 1
					done()

			it 'E F', (done) ->
				doc2u.parent = null
				watcher = doc2.watch 'b u'
				watcher.onAdd (tag) ->
					tags.push tag
				doc2u.parent = doc2b
				whenChange tags, ->
					assert.isEqual tags, [doc2u, doc2u2], maxDeep: 1
					done()

			it 'E > F', (done) ->
				doc2u.parent = null
				watcher = doc2div1.watch '> u'
				watcher.onAdd (tag) ->
					tags.push tag
				doc2u.parent = doc2div1
				whenChange tags, ->
					assert.isEqual tags, [doc2u], maxDeep: 1
					done()

			it '[foo]', (done) ->
				watcher = doc2div1.watch '[attr2]'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2u.attrs.set 'attr2', '2'
				whenChange tags, ->
					assert.isEqual tags, [doc2u], maxDeep: 1
					doc2u.attrs.set 'attr2', undefined
					whenChange tags, ->
						assert.isEqual tags, []
						done()

			it '[foo=bar]', (done) ->
				watcher = doc2div1.watch '[attr=2]'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2u.attrs.set 'attr', '2'
				whenChange tags, ->
					assert.isEqual tags, [doc2u], maxDeep: 1
					doc2u.attrs.set 'attr', '1'
					whenChange tags, ->
						assert.isEqual tags, []
						done()

			it '[foo^=bar]', (done) ->
				watcher = doc2div1.watch '[color^=re]'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2u.attrs.set 'color', 'red'
				whenChange tags, ->
					assert.isEqual tags, [doc2u], maxDeep: 1
					doc2u.attrs.set 'color', 'blue'
					whenChange tags, ->
						assert.isEqual tags, []
						done()

			it '[foo$=bar]', (done) ->
				watcher = doc2div1.watch '[color$=ed]'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2u.attrs.set 'color', 'red'
				whenChange tags, ->
					assert.isEqual tags, [doc2u], maxDeep: 1
					doc2u.attrs.set 'color', 'blue'
					whenChange tags, ->
						assert.isEqual tags, []
						done()

			it '[foo*=bar]', (done) ->
				watcher = doc2div1.watch '[color*=rang]'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2u.attrs.set 'color', 'orange'
				whenChange tags, ->
					assert.isEqual tags, [doc2u], maxDeep: 1
					doc2u.attrs.set 'color', 'blue'
					whenChange tags, ->
						assert.isEqual tags, []
						done()

			it '*', (done) ->
				doc2u.parent = null
				watcher = doc2div1.watch '*'
				for node in watcher.nodes
					tags.push node
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2u.parent = doc2div1
				whenChange tags, ->
					assert.isEqual tags, [doc2b, doc2u, doc2u2], maxDeep: 1
					doc2u.parent = null
					whenChange tags, ->
						assert.isEqual tags, [doc2b], maxDeep: 1
						done()

			it '*[foo]', (done) ->
				watcher = doc2div1.watch '*[attr2]'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2u.attrs.set 'attr2', '2'
				whenChange tags, ->
					assert.isEqual tags, [doc2u], maxDeep: 1
					doc2u.attrs.set 'attr2', undefined
					whenChange tags, ->
						assert.isEqual tags, []
						done()

			it 'E > * > F[foo]', (done) ->
				doc2u.parent = null
				watcher = doc2.watch 'div > * > u[color]'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2u.parent = doc2b
				whenChange tags, ->
					assert.isEqual tags, [doc2u], maxDeep: 1
					doc2u.parent = null
					whenChange tags, ->
						assert.isEqual tags, []
						done()

			it 'E > * > F[foo], F[foo]', (done) ->
				doc2div1.parent = null
				doc2div2.parent = null
				watcher = doc2.watch 'div > * > u[color], div[attr]'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2div1.parent = doc2
				doc2div2.parent = doc2
				whenChange tags, ->
					assert.isEqual tags, [doc2u, doc2div2], maxDeep: 1
					doc2div1.parent = null
					doc2div2.parent = null
					whenChange tags, ->
						assert.isEqual tags, []
						done()

			it '&[foo]', (done) ->
				doc2u.parent = null
				watcher = doc2u.watch '&[color]'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				doc2u.parent = doc2b
				whenChange tags, ->
					assert.isEqual tags, [doc2u], maxDeep: 1
					doc2u.attrs.set 'color', undefined
					whenChange tags, ->
						assert.isEqual tags, []
						done()

			it '#text', (done) ->
				watcher = doc2.watch '#text'
				watcher.onAdd (tag) ->
					tags.push tag
				watcher.onRemove (tag) ->
					utils.remove tags, tag
				whenChange tags, ->
					assert.isEqual tags, [doc2em1.children[0]], maxDeep: 1
					newText = new Element.Text
					newText.parent = doc2em2
					whenChange tags, ->
						assert.isEqual tags, [doc2em1.children[0], newText], maxDeep: 1
						done()

	it 'visible property is editable', ->
		assert.ok p.visible
		p.visible = false
		assert.notOk p.visible
		p.visible = true

	describe 'Observer', ->
		it 'observing attr changes works properly', ->
			value = args = null
			elem = Element.fromHTML('<b a="1"></b>').cloneDeep()
			tag = elem.children[0]

			tag.onAttrsChange (name, oldVal) ->
				value = @attrs.get name
				args = [@, arguments...]

			tag.attrs.set 'a', 2

			assert.isEqual args, [tag, 'a', '1'], maxDeep: 1
			assert.is value, 2

		it 'observing visibility changes works properly', ->
			value = args = null
			elem = Element.fromHTML('<b></b>').cloneDeep()
			tag = elem.children[0]

			tag.onVisibleChange ->
				value = @visible
				args = [@, arguments...]

			tag.visible = false

			assert.isEqual args, [tag, true, undefined], maxDeep: 1
			assert.is value, false

		it 'observing text changes works properly', ->
			text = args = null
			elem = Element.fromHTML('<b>a</b>').cloneDeep()
			tag = elem.children[0].children[0]

			tag.onTextChange ->
				text = @text
				args = [@, arguments...]

			tag.text = 'b'

			assert.isEqual args, [tag, 'a', undefined], maxDeep: 1
			assert.is text, 'b'

		it 'observing parent changes works properly', ->
			value = args = null
			elem = Element.fromHTML('<a></a><b></b>').cloneDeep()
			tag1 = elem.children[0]
			tag2 = elem.children[1]

			tag2.onParentChange ->
				value = @parent
				args = [@, arguments...]

			tag2.parent = tag1

			assert.isEqual args, [tag2, elem, undefined], maxDeep: 1
			assert.is value, tag1

		it 'disconnect() works as expected', ->
			ok = true
			elem = Element.fromHTML('<b></b>').cloneDeep()
			tag = elem.children[0]

			listener = -> ok = false
			tag.onVisibleChange listener
			tag.onVisibleChange.disconnect listener

			tag.visible = false

			assert.ok ok
