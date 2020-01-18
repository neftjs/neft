if (process.env.NEFT_MODE === 'universal') {
  module.exports = require('./styles-universal')
}

if (process.env.NEFT_MODE === 'web') {
  module.exports = require('./styles-web')
}
