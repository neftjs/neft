const RUNNERS = {
  html: require('./browser'),
  webgl: require('./browser'),
  android: require('./android'),
  ios: require('./ios'),
}

exports.run = (target, args) => {
  RUNNERS[target](args)
}
