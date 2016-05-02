module.exports = function(app){
	return {
		'post api/order': {
			getData: function(callback){
				var self = this;
				console.log('Got data', this.request.data);
				setTimeout(function(){
					callback(null, 'Order confirmed! Amount: ' + self.request.data.length);
				}, 2000);
			}
		}
	}
};
