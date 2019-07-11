module.exports = (element) => {
  const nCalls = element.queryAll('n-call')
  if (!nCalls.length) return

  nCalls.forEach((nCall) => {
    nCall.visible = false
  })
}
