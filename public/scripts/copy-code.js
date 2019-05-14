/* eslint-env browser */

(function () {
  const codes = document.querySelectorAll('code')
  const alert = document.querySelector('#alert-copied')
  let timer

  codes.forEach((code) => {
    code.addEventListener('click', () => {
      window.navigator.clipboard.writeText(code.textContent)

      clearTimeout(timer)
      alert.style.visibility = 'visible'
      timer = setTimeout(() => {
        alert.style.visibility = 'hidden'
      }, 1500)
    })
  })
}())
