'use strict'

View = require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{renderParse, uid} = require './utils'
Dict = require 'neft-dict'
List = require 'neft-list'

describe 'neft:each', ->
	it 'loops expected times', ->
		source = View.fromHTML uid(), '<ul neft:each="[0,0]">1</ul>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>11</ul>'

	it 'provides `attrs.item` property', ->
		source = View.fromHTML uid(), '<ul neft:each="[1,2]">${attrs.item}</ul>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>12</ul>'

	it 'provides `attrs.index` property', ->
		source = View.fromHTML uid(), '<ul neft:each="[1,2]">${attrs.index}</ul>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>01</ul>'

	it 'provides `attrs.each` property', ->
		source = View.fromHTML uid(), '<ul neft:each="[1,2]">${attrs.each}</ul>'
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>1,21,2</ul>'

	it 'supports runtime updates', ->
		source = View.fromHTML uid(), '<ul neft:each="${attrs.arr}">${attrs.each[attrs.index]}</ul>'
		View.parse source
		view = source.clone()

		attrs = arr: arr = new List [1, 2]

		renderParse view, attrs: attrs
		assert.is view.node.stringify(), '<ul>12</ul>'

		arr.insert 1, 'a'
		assert.is view.node.stringify(), '<ul>1a2</ul>'

		arr.pop 1
		assert.is view.node.stringify(), '<ul>12</ul>'

		arr.append 3
		assert.is view.node.stringify(), '<ul>123</ul>'

	it 'access global `attrs`', ->
		source = View.fromHTML uid(), '<ul neft:each="[1,2]">${attrs.a}</ul>'
		View.parse source
		view = source.clone()

		renderParse view,
			attrs: a: 'a'
		assert.is view.node.stringify(), '<ul>aa</ul>'

	it 'access `ids`', ->
		source = View.fromHTML uid(), """
			<div id="a" prop="a" visible="false" />
			<ul neft:each="[1,2]">${ids.a.attrs.prop}</ul>
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>aa</ul>'

	it 'access neft:fragment `attrs`', ->
		source = View.fromHTML uid(), """
			<neft:fragment neft:name="a" a="a">
				<ul neft:each="[1,2]">${attrs.a}${attrs.b}</ul>
			</neft:fragment>
			<neft:use neft:fragment="a" b="b" />
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>abab</ul>'

	it 'uses parent `this` context', ->
		source = View.fromHTML uid(), """
			<neft:fragment neft:name="a">
				<neft:script>
					module.exports = function(){
						this.x = 1;
					}
				</neft:script>
				<ul neft:each="[1,2]">${this.x}</ul>
			</neft:fragment>
			${this.x}
			<neft:use neft:fragment="a" />
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<ul>11</ul>'
