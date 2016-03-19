'use strict'

View = require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{renderParse, uid} = require './utils'

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
