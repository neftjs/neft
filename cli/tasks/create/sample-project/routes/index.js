var List = require('neft-list');
var Dict = require('neft-dict');

module.exports = function(app){
	return {
		// create app.Route
		'get /': {
			init: function(){
				this.order = new List();
				this.orderStatus = new Dict({
					pending: false,
					loaded: false,
					error: '',
					response: ''
				});
			},
			getData: function(callback){
				callback(null, new List(app.models.products.getAll()));
			},

			/* custom methods below */

			orderProduct: function(product){
				if (this.orderStatus.pending){
					return;
				}

				this.data.remove(product);
				this.order.append(product);
			},
			send: function(){
				if (this.orderStatus.pending){
					return;
				}

				var self = this;
				this.orderStatus.set('pending', true);

				// server request
				app.networking.post('api/order', this.order.toArray(), function(err, msg){
					// server URL must be specified in the `package.json`
					if (this.response.status === 0){
						err = 'No internet connection';
					}

					self.orderStatus.extend({
						loaded: true,
						pending: false,
						error: err ? err+'' : '',
						response: msg || ''
					});
					self.data.extend(self.order);
					self.order.clear();
				});
			}
		}
	};
};
