const SPACE_RE = / /g

exports.prefixTagClassOrIdProp = (prop, value, prefix) => {
  if (!value || !prefix || typeof value !== 'string') return value

  if (prop === 'class') {
    return `${prefix}-${value.replace(SPACE_RE, ` ${prefix}-`)}`
  }

  if (prop === 'id') {
    return `${prefix}-${value}`
  }

  return value
}
