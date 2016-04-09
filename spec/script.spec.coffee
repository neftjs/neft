'use strict'

fs = require 'fs'
os = require 'os'
View = require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{renderParse, uid} = require './utils'

describe 'neft:script', ->
	it 'is not rendered', ->
		view = View.fromHTML uid(), """
			<neft:script><![CDATA[
				module.exports = function(){};
			]]></neft:script>
		"""
		View.parse view
		view = view.clone()

		renderParse view
		assert.is view.node.stringify(), ''

	it 'must exports a function', ->
		view = View.fromHTML uid(), """
			<neft:script><![CDATA[
				module.exports = {};
			]]></neft:script>
		"""
		View.parse view

		try
			view.render()
		catch err
		assert.isDefined err

	describe 'returned function', ->
		it 'prototype is shared between rendered views', ->
			view = View.fromHTML uid(), """
				<neft:script><![CDATA[
					var Ctor = module.exports = function(){};
					Ctor.prototype = { a: 1 };
				]]></neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view
			proto = view.storage.__proto__
			assert.is view.storage.a, 1

			view.revert()
			renderParse view
			assert.is view.storage.__proto__, proto
			view.revert()

			view2 = view.clone()
			renderParse view2
			assert.is view2.storage.__proto__, proto

		it 'is called on a view clone', ->
			view = View.fromHTML uid(), """
				<neft:attr name="x" value="1" />
				<neft:script><![CDATA[
					var Ctor = module.exports = function(){
						this.b = 2;
					};
					Ctor.prototype = { a: 1 };
				]]></neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view
			{storage} = view
			assert.is storage.b, 2
			assert.is storage.a, 1

			view.revert()
			renderParse view
			assert.is view.storage, storage

			view2 = view.clone()
			renderParse view2
			assert.isNot view2.storage, storage
			assert.is view2.storage.b, 2
			assert.is view2.storage.a, 1

		it 'is called with its prototype', ->
			view = View.fromHTML uid(), """
				<neft:script><![CDATA[
					var Ctor = module.exports = function(){
						this.proto = this;
						this.protoA = this.a;
					};
					Ctor.prototype = { a: 1 };
				]]></neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.proto, view.storage
			assert.is view.storage.protoA, 1

		it 'is called with attrs in context', ->
			view = View.fromHTML uid(), """
				<neft:script><![CDATA[
					var Ctor = module.exports = function(){
						this.a = this.attrs.a;
					};
				]]></neft:script>
				<neft:attr name="a" value="1" />
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.a, 1

		it 'is called with ids in context', ->
			view = View.fromHTML uid(), """
				<neft:script><![CDATA[
					var Ctor = module.exports = function(){
						this.a = this.ids.x.attrs.a;
					};
				]]></neft:script>
				<b id="x" a="1" />
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.a, 1

		it 'is called with funcs in context', ->
			view = View.fromHTML uid(), """
				<neft:function neft:name="abc"><![CDATA[
					return 1;
				]]></neft:function>
				<neft:script><![CDATA[
					var Ctor = module.exports = function(){
						this.a = this.funcs.abc();
					};
				]]></neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.a, 1

		it 'is called with scope in context', ->
			view = View.fromHTML uid(), """
				<neft:script><![CDATA[
					var Ctor = module.exports = function(){
					};
					Ctor.prototype.onRender = function(){
						this.a = this.scope.a;
					};
				]]></neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view, storage: a: 1
			assert.is view.storage.a, 1

		it 'is called with file node in context', ->
			view = View.fromHTML uid(), """
				<neft:script><![CDATA[
					var Ctor = module.exports = function(){
						this.aNode = this.node;
					};
				]]></neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.aNode, view.node

	describe '[filename]', ->
		it 'supports .coffee files', ->
			view = View.fromHTML uid(), """
				<neft:script filename="a.coffee"><![CDATA[
					module.exports = class A
						constructor: ->
							@a = 1
				]]></neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.a, 1

	it 'predefined context properties are not enumerable', ->
		view = View.fromHTML uid(), """
			<neft:script><![CDATA[
				var Ctor = module.exports = function(){
				};
				Ctor.prototype.onRender = function(){
					this.keys = Object.keys(this);
				};
			]]></neft:script>
		"""
		View.parse view
		view = view.clone()

		renderParse view
		assert.isEqual view.storage.keys, ['keys']

	it 'further tags are merged in a proper order', ->
		view = View.fromHTML uid(), """
			<neft:script><![CDATA[
				var Ctor = module.exports = function(){
					this.aa = 1;
				};
				Ctor.prototype.a = 1;
				Ctor.prototype.doA = function(){
					this.doACalledOnA = true;
				};
			]]></neft:script>
			<neft:script><![CDATA[
				var Ctor = module.exports = function(){
					this.bb = 1;
					this.bbaa = this.aa;
				};
				Ctor.prototype.b = 1;
				Ctor.prototype.doA = function(){
					this.doACalledOnB = true;
				};
			]]></neft:script>
		"""
		View.parse view
		view = view.clone()

		renderParse view
		{storage} = view
		assert.is storage.a, 1
		assert.is storage.aa, 1
		assert.is storage.b, 1
		assert.is storage.bb, 1
		assert.is storage.bbaa, 1

		storage.doA();
		assert.ok storage.doACalledOnA
		assert.ok storage.doACalledOnB

	it 'can contains XML text', ->
		source = View.fromHTML uid(), """
			<neft:script><![CDATA[
				var Ctor = module.exports = function(){};
					Ctor.prototype = { a: '<&&</neft:script>' };
			]]></neft:script>
			${this.a}
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '<&&</neft:script>'

	it 'accepts `src` attribute', ->
		filename = "tmp#{uid()}.js"
		path = "#{os.tmpdir()}/#{filename}"
		fs.writeFileSync path, "module.exports = function(){ this.a = 1; };", 'utf-8'

		source = View.fromHTML uid(), """
			<neft:script href="#{path}" />
			<neft:blank>${this.a}</neft:blank>
		"""
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '1'

	it 'accepts relative `src` attribute', ->
		scriptFilename = "tmp#{uid()}.js"
		scriptPath = "#{os.tmpdir()}/#{scriptFilename}"
		fs.writeFileSync scriptPath, "module.exports = function(){ this.a = 1; };", 'utf-8'

		viewFilename = "tmp#{uid()}"
		viewPath = "#{os.tmpdir()}/#{viewFilename}"
		fs.writeFileSync viewPath, viewStr = """
			<neft:script href="./#{scriptFilename}" />
			<neft:blank>${this.a}</neft:blank>
		"""

		source = View.fromHTML viewPath, viewStr
		View.parse source
		view = source.clone()

		renderParse view
		assert.is view.node.stringify(), '1'

	it 'properly calls events', ->
		view = View.fromHTML uid(), """
			<neft:script><![CDATA[
				var Ctor = module.exports = function(){
					this.events = [];
				};
				Ctor.prototype.onBeforeRender = function(){
					this.events.push('onBeforeRender');
				};
				Ctor.prototype.onRender = function(){
					this.events.push('onRender');
				};
				Ctor.prototype.onBeforeRevert = function(){
					this.events.push('onBeforeRevert');
				};
				Ctor.prototype.onRevert = function(){
					this.events.push('onRevert');
				};
			]]></neft:script>
		"""
		View.parse view
		view = view.clone()

		{events} = view.storage
		assert.isEqual events, []

		view.render()
		assert.isEqual events, ['onBeforeRender', 'onRender']

		view.revert()
		assert.isEqual events, ['onBeforeRender', 'onRender', 'onBeforeRevert', 'onRevert']

	it 'does not call events for foreign storage', ->
		view = View.fromHTML uid(), """
			<neft:script><![CDATA[
				var Ctor = module.exports = function(){
					this.events = [];
				};
				Ctor.prototype.onBeforeRender = function(){
					this.events.push('onBeforeRender');
				};
				Ctor.prototype.onRender = function(){
					this.events.push('onRender');
				};
				Ctor.prototype.onBeforeRevert = function(){
					this.events.push('onBeforeRevert');
				};
				Ctor.prototype.onRevert = function(){
					this.events.push('onRevert');
				};
			]]></neft:script>
			<ul neft:each="[1,2]">${attrs.item}</ul>
		"""
		View.parse view
		view = view.clone()

		{events} = view.storage
		assert.isEqual events, []

		view.render()
		assert.isEqual events, ['onBeforeRender', 'onRender']

		view.revert()
		assert.isEqual events, ['onBeforeRender', 'onRender', 'onBeforeRevert', 'onRevert']
