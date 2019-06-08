module.exports = function (element, parser) {
  const nProps = element.query('n-props')
  if (!nProps) return

  nProps.parent = null
  parser.addProp('props', () => JSON.stringify(nProps.props))

  const nextNPropos = element.query('n-props')
  if (nextNPropos) {
    parser.warning(new Error('Component file can contain only one <n-props> tag'))
  }
}
