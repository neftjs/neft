module.exports = (element, parser) => {
  const nTarget = element.query('n-target')
  if (!nTarget) return
  parser.addProp('target', () => JSON.stringify(nTarget.getAccessPath(element)))
}
