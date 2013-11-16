// Forked https://github.com/fb55/DomHandler

function DomHandler(callback, options, elementCB){
	if(typeof callback === "object"){
		elementCB = options;
		options = callback;
		callback = null;
	} else if(typeof options === "function"){
		elementCB = options;
	}
	this._callback = callback;
	this._options = options;
	this._elementCB = elementCB;
	this.dom = [];
	this._done = false;
	this._tagStack = [];
}

function isTag(elem){
	return elem.type === "tag" || elem.type === "script" || elem.type === "style";
}

//Resets the handler back to starting state
DomHandler.prototype.onreset = function(){
	DomHandler.call(this, this._callback, this._options, this._elementCB);
};

//Signals the handler that parsing is done
DomHandler.prototype.onend = function(){
	if(this._done) return;
	this._done = true;
	this._handleCallback(null);
};

DomHandler.prototype._handleCallback =
DomHandler.prototype.onerror = function(error){
	if(typeof this._callback === "function"){
		this._callback(error, this.dom);
	} else {
		if(error) throw error;
	}
};

DomHandler.prototype.onclosetag = function(name){
	//if(this._tagStack.pop().name !== name) this._handleCallback(Error("Tagname didn't match!"));
	var elem = this._tagStack.pop();
	if(this._elementCB) this._elementCB(elem);
};

DomHandler.prototype._addDomElement = function(element){
	var lastTag = this._tagStack[this._tagStack.length - 1];

	if(lastTag){
		lastTag.children.push(element);
	} else { //There aren't parent elements
		this.dom.push(element);
	}
};

DomHandler.prototype.onopentag = function(name, attribs){
	var _tagStack = this._tagStack;
	var lastTag = _tagStack[_tagStack.length - 1];

	var element = {
		index: -1,
		type: name !== 'script' && name !== 'style' ? 'tag' : name,
		name: name,
		attribs: attribs,
		children: [],
		visible: true,
		_element: null
	};

	if(lastTag){
		lastTag.children.push(element);
	} else {
		this.dom.push(element);
	}

	_tagStack.push(element);
};

DomHandler.prototype.ontext = function(data){

	var lastTag, _tagStack = this._tagStack;

	if(!_tagStack.length && this.dom.length && (lastTag = this.dom[this.dom.length-1]).type === 'text'){
		lastTag.data += data;
	} else {
		if(
			_tagStack.length &&
			(lastTag = _tagStack[_tagStack.length - 1]) &&
			(lastTag = lastTag.children[lastTag.children.length - 1]) &&
			lastTag.type === 'text'
		){
			lastTag.data += data;
		} else {

			this._addDomElement({
				index: -1,
				data: data,
				type: 'text',
				visible: true,
				_element: null
			});
		}
	}
};

DomHandler.prototype.oncomment = function(data){
	var lastTag = this._tagStack[this._tagStack.length - 1];

	if(lastTag && lastTag.type === 'comment'){
		lastTag.data += data;
		return;
	}

	var element = {
		index: -1,
		data: data,
		type: 'comment',
		visible: true,
		_element: null
	};

	this._addDomElement(element);
	this._tagStack.push(element);
};

DomHandler.prototype.oncdatastart = function(){
	var element = {
		children: [{
			index: -1,
			data: "",
			type: 'text',
			visible: true,
			_element: null
		}],
		type: 'cdata'
	};

	this._addDomElement(element);
	this._tagStack.push(element);
};

DomHandler.prototype.oncommentend = DomHandler.prototype.oncdataend = function(){
	this._tagStack.pop();
};

DomHandler.prototype.onprocessinginstruction = function(name, data){
	this._addDomElement({
		index: -1,
		name: name,
		data: data,
		type: 'directive',
		visible: true,
		_element: null
	});
};

module.exports = DomHandler;