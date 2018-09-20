module.exports = (element, parser) => {
  const refs = {}

  element.queryAll('[n-ref]').forEach((nRef) => {
    const ref = nRef.props['n-ref']
    if (refs[ref]) {
      parser.warning(new Error(`n-ref must be unique; ${ref} is duplicated`))
      return
    }
    refs[ref] = nRef
  })

  if (!Object.keys(refs).length) return

  parser.addProp('refs', () => {
    const json = Object.keys(refs).reduce((result, ref) => {
      result[ref] = refs[ref].getAccessPath(element)
      return result
    }, {})
    return JSON.stringify(json)
  })
}
