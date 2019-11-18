module.exports = (element, parser) => {
  const nLet = element.query('n-let')
  if (!nLet) return
  nLet.visible = false
  parser.addProp('let', () => JSON.stringify(nLet.getAccessPath(element)))
}
