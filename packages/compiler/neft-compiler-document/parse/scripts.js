module.exports = function (element, parser) {
  const script = element.query('script')
  if (!script) return

  script.parent = null

  parser.addProp('script', () => `((module) => {\
      const { exports } = module;\n
      (() => {\n\n${parser.scripts[parser.resourcePath].value}\n\n})();\n
      return module.exports;
    })({ exports: {} })`)

  const nextScripts = element.queryAll('script')
  if (nextScripts.length > 0) {
    parser.warning(new Error('Component file can contain only one <script> tag'))

    nextScripts.forEach((nextScript) => {
      nextScript.parent = null
    })
  }
}
