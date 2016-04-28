var Ctor = module.exports = function(){
		this.bb = 1;
		this.bbaa = this.aa;
	};
	Ctor.prototype.b = 1;
	Ctor.prototype.doA = function(){
		this.doACalledOnB = true;
	};