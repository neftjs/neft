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