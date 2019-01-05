/* eslint-env browser */
/* global elasticlunr, searchTexts */

(function () {
  const SEARCH_OPTIONS = {
    expand: true,
    fields: {
      h1: { boost: 4 },
      h2: { boost: 3 },
      h3: { boost: 2 },
    },
  }

  if (typeof searchTexts === 'undefined') return

  const inputElement = document.getElementById('search')
  const resultElement = document.getElementById('searchResult')
  if (!inputElement || !resultElement) return

  function trimOnlyNonWords(token) {
    return token
      .replace(/\W+/g, ' ')
      .trim()
  }

  function trim(token) {
    return trimOnlyNonWords(token)
      .replace(/([a-z])([A-Z])/g, '$1 $2')
      .trim()
  }

  const lunrIndex = (function buildSearch() {
    const index = elasticlunr(function () {
      this.addField('h1')
      this.addField('h2')
      this.addField('h3')
      this.setRef('id')
      this.saveDocument(false)
    })

    function addDoc(id, level, text) {
      const doc = { id }
      doc[`h${level}`] = text
      index.addDoc(doc)
    }

    const { texts } = searchTexts
    for (let i = 0, n = texts.length; i < n; i += 1) {
      const level = texts[i][1]
      const text = texts[i][2]
      addDoc(i, level, trimOnlyNonWords(text))
      addDoc(i, level, trim(text))
    }
    return index
  }())

  function search(text) {
    const result = []
    const lunrResult = lunrIndex.search(trim(text), SEARCH_OPTIONS)
    const { pages } = searchTexts
    const { texts } = searchTexts
    for (let i = 0; i < lunrResult.length; i += 1) {
      const found = texts[lunrResult[i].ref]
      result.push({
        page: pages[found[0]],
        text: found[2],
      })
    }
    return result
  }

  function showResult(value, result) {
    if (!result.length) {
      resultElement.innerHTML = ''
      return
    }

    const markRe = new RegExp(`(${value.split(' ').join('|')})`, 'ig')

    let html = '<ul>'

    for (let i = 0; i < result.length; i += 1) {
      const uri = `/${result[i].page}.html`
      const text = result[i].text.replace(markRe, '<mark>$1</mark>')
      html += `<li><a href="${uri}">${text}</a></li>`
    }

    html += '</ul>'

    resultElement.innerHTML = html
  }

  function listenOnElement() {
    let lastSearchResult
    inputElement.addEventListener('input', () => {
      const { value } = inputElement
      let searchResult = search(value)
      if (value && !searchResult.length && lastSearchResult) {
        searchResult = lastSearchResult
      }
      showResult(value, searchResult)
      lastSearchResult = searchResult
    })
  }

  function updateResultElementMaxHeight() {
    resultElement.style.maxHeight = `${window.innerHeight - 100}px`
  }

  listenOnElement()
  window.addEventListener('resize', updateResultElementMaxHeight)
  updateResultElementMaxHeight()
}())
