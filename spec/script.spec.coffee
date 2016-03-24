'use strict'

View = require '../index.coffee.md'
{describe, it} = require 'neft-unit'
assert = require 'neft-assert'
{renderParse, uid} = require './utils'

describe 'neft:script', ->
	it 'is not rendered', ->
		view = View.fromHTML uid(), """
			<neft:script>
				module.exports = function(){};
			</neft:script>
		"""
		View.parse view
		view = view.clone()

		renderParse view
		assert.is view.node.stringify(), ''

	it 'must exports a function', ->
		view = View.fromHTML uid(), """
			<neft:script>
				module.exports = {};
			</neft:script>
		"""
		View.parse view

		try
			view.render()
		catch err
		assert.isDefined err

	describe 'returned function', ->
		it 'prototype is shared between rendered views', ->
			view = View.fromHTML uid(), """
				<neft:script>
					var Ctor = module.exports = function(){};
					Ctor.prototype = { a: 1 };
				</neft:script>
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
				<neft:script>
					var Ctor = module.exports = function(){
						this.b = 2;
					};
					Ctor.prototype = { a: 1 };
				</neft:script>
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
				<neft:script>
					var Ctor = module.exports = function(){
						this.proto = this;
						this.protoA = this.a;
					};
					Ctor.prototype = { a: 1 };
				</neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.proto, view.storage
			assert.is view.storage.protoA, 1

		it 'is called with attrs in context', ->
			view = View.fromHTML uid(), """
				<neft:script>
					var Ctor = module.exports = function(){
						this.a = this.attrs.a;
					};
				</neft:script>
				<neft:attr name="a" value="1" />
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.a, 1

		it 'is called with ids in context', ->
			view = View.fromHTML uid(), """
				<neft:script>
					var Ctor = module.exports = function(){
						this.a = this.ids.x.attrs.a;
					};
				</neft:script>
				<b id="x" a="1" />
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.a, 1

		it 'is called with funcs in context', ->
			view = View.fromHTML uid(), """
				<neft:function neft:name="abc">
					return 1;
				</neft:function>
				<neft:script>
					var Ctor = module.exports = function(){
						this.a = this.funcs.abc();
					};
				</neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.a, 1

		it 'is called with node in context', ->
			view = View.fromHTML uid(), """
				<neft:script>
					var Ctor = module.exports = function(){
						this.aNode = this.node;
					};
				</neft:script>
			"""
			View.parse view
			view = view.clone()

			renderParse view
			assert.is view.storage.aNode, view.node

	it 'further tags are merged in a proper order', ->
		view = View.fromHTML uid(), """
			<neft:script>
				var Ctor = module.exports = function(){
					this.aa = 1;
				};
				Ctor.prototype.a = 1;
				Ctor.prototype.doA = function(){
					this.doACalledOnA = true;
				};
			</neft:script>
			<neft:script>
				var Ctor = module.exports = function(){
					this.bb = 1;
					this.bbaa = this.aa;
				};
				Ctor.prototype.b = 1;
				Ctor.prototype.doA = function(){
					this.doACalledOnB = true;
				};
			</neft:script>
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

	it 'properly calls events', ->
		view = View.fromHTML uid(), """
			<neft:script>
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
			</neft:script>
		"""
		View.parse view
		view = view.clone()

		{events} = view.storage
		assert.isEqual events, []

		view.render()
		assert.isEqual events, ['onBeforeRender', 'onRender']

		view.revert()
		assert.isEqual events, ['onBeforeRender', 'onRender', 'onBeforeRevert', 'onRevert']
