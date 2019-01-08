module.exports = (element, parser) => {
  const [nTarget, rest] = element.queryAll('n-target')
  if (!nTarget) return
  if (rest) parser.error(new Error('Component can have only one <n-target />'))
  nTarget.name = 'blank'
  parser.addProp('target', () => JSON.stringify(nTarget.getAccessPath(element)))
}
