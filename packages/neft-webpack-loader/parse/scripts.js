module.exports = function (element, parser) {
  const script = element.query('script')
  if (!script) return

  script.parent = null

  parser.addProp('script', () => {
    const code = script.stringifyChildren()
    return `((module) => {\n(() => {${code}})()\n return module.exports})({})`
  })

  const nextScript = element.query('script')
  if (nextScript) {
    parser.warning(new Error('Component file can contain only one <script> tag'))
  }
}
