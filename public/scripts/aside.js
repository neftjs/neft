/* eslint-env browser */

// Remembers aside#aside scroll position
(function () {
  const STORAGE_KEY = 'asideScrollY'
  const { localStorage } = window

  if (!localStorage) return

  const element = document.getElementById('aside')
  if (!element) return

  // function getPage() {
  //   return location.pathname.slice(0, location.pathname.indexOf('/', 1) + 1)
  // }

  function syncScrollY() {
    element.scrollTop = localStorage.getItem(STORAGE_KEY) || 0
  }

  function updateItem() {
    localStorage.setItem(STORAGE_KEY, element.scrollTop)
  }

  function listenOnChanges() {
    let timer = 0
    element.addEventListener('scroll', () => {
      clearTimeout(timer)
      timer = setTimeout(updateItem, 50)
    })
  }

  // function isSamePageAsBefore() {
  //   return document.referrer.indexOf(location.origin + getPage()) === 0
  // }

  // if (isSamePageAsBefore()) {
  syncScrollY()
  // } else {
  //   updateItem()
  // }

  listenOnChanges()
}())
