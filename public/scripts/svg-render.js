/* eslint-env browser */

(function () {
  const codes = document.querySelectorAll('code.svg')

  for (let i = 0; i < codes.length; i += 1) {
    const elem = codes[i]
    elem.innerHTML = elem.textContent
  }
}())
