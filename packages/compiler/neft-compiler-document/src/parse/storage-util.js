const InputRE = /{([^}]*)}/g

exports.isBinding = (text) => {
  InputRE.lastIndex = 0
  return text && InputRE.test(text)
}
