module.exports = (element, parser) => {
  const [nSlot, rest] = element.queryAll('n-slot').concat(element.queryAll('n-target'))
  if (!nSlot) return
  if (rest) parser.error(new Error('Component can have only one <n-slot />'))
  nSlot.name = 'blank'
  parser.addProp('slot', () => JSON.stringify(nSlot.getAccessPath(element)))
}
