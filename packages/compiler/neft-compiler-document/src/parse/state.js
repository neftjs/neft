module.exports = (element, parser) => {
  const nStates = element.queryAll('n-state')
  const usedNames = {}
  const states = []

  nStates.forEach((nState) => {
    const { name } = nState.props
    if (!name) {
      parser.warning(new Error('<n-state /> needs to define a name'))
    }
    if (usedNames[name]) {
      parser.warning(new Error('<n-state /> name is duplicated'))
    }
    nState.visible = false
    usedNames[name] = true
    states.push(nState)
  })

  if (states.length > 0) {
    parser.addProp('states', () => JSON.stringify(states.map(state => state.getAccessPath(element))))
  }
}
