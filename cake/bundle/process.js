// Coffee won't work in cake second time using child_process.fork
var fs = require('fs');
try {
	require('coffee-script').eval(fs.readFileSync(__dirname + '/process.coffee', 'utf-8'));
}
catch (err){

	process.send({ err: err.stack });

}