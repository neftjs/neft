'use strict'

View = require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{renderParse, uid} = require './utils'

describe 'neft:function', ->
	it 'can contains XML text', ->
		source = View.fromHTML uid(), """
			<neft:function neft:name="abc"><![CDATA[
				return '</div>';
			]]></neft:function>
			${funcs.abc()}
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '</div>'

	it 'has arguments global variable', ->
		source = View.fromHTML uid(), """
			<neft:function neft:name="abc"><![CDATA[
				return arguments[0];
			]]></neft:function>
			${funcs.abc(1)}
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '1'

	it 'works with named arguments', ->
		source = View.fromHTML uid(), """
			<neft:function neft:name="abc" arguments="x, y"><![CDATA[
				return x + y;
			]]></neft:function>
			${funcs.abc('x', 1)}
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), 'x1'

	it 'can require neft modules', ->
		source = View.fromHTML uid(), """
			<neft:function neft:name="abc"><![CDATA[
				var utils = require('neft-utils');
				return typeof utils.tryFunction === 'function';
			]]></neft:function>
			${funcs.abc()}
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), 'true'

	it 'can call other function with custom context and arguments', ->
		source = View.fromHTML uid(), """
			<neft:function neft:name="test" arguments="val, attrs"><![CDATA[
				return this.x + arguments[0] + attrs.x;
			]]></neft:function>
			<neft:function neft:name="abc" arguments="funcs, attrs"><![CDATA[
				return funcs.test.call({x: 1}, 1, attrs);
			]]></neft:function>
			<neft:attr name="x" value="1" />
			${funcs.abc(funcs, attrs)}
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '3'
