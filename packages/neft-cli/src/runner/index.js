const RUNNERS = {
  html: require('./browser'),
  webgl: require('./browser'),
  android: require('./android'),
}

exports.run = (target, args) => {
  RUNNERS[target](args)
}
