module.exports = (element, parser) => {
  const refs = {}

  element.queryAll('[n-ref]').concat(element.queryAll('[ref]')).forEach((nRef) => {
    const ref = nRef.props['n-ref'] || nRef.props.ref
    if (refs[ref]) {
      parser.warning(new Error(`n-ref ${ref} is already defined`))
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
