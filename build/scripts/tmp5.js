var Ctor = module.exports = function(){
		this.proto = this;
		this.protoA = this.a;
	};
	Ctor.prototype = { a: 1 };