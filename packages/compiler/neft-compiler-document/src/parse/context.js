module.exports = (element, parser) => {
  const contexts = []
  const nUseContexts = element.queryAll('n-use-context')
  nUseContexts.forEach((nUseContext) => {
    nUseContext.visible = false
    contexts.push(nUseContext)
  })

  if (contexts.length > 0) {
    parser.addProp('contexts', () => JSON.stringify(nUseContexts.map(nUseContext => nUseContext.getAccessPath(element))))
  }
}
