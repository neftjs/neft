module.exports = (element, parser) => {
  const nLogs = element.queryAll('n-log')
  if (!nLogs.length) return

  nLogs.forEach((nLog) => {
    nLog.visible = false
  })

  parser.addProp('logs', () => JSON.stringify(nLogs.map(nLog => nLog.getAccessPath(element))))
}
