const RUNNERS = {
  html: require('./browser'),
  webgl: require('./browser'),
}

exports.run = (target) => {
  RUNNERS[target]()
}
