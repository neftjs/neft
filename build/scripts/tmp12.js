var Ctor = module.exports = function(){
		this.aa = 1;
	};
	Ctor.prototype.a = 1;
	Ctor.prototype.doA = function(){
		this.doACalledOnA = true;
	};