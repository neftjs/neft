/* eslint-env browser */
/* global elasticlunr, searchTexts */

(function () {
  const SEARCH_OPTIONS = {
    expand: true,
    fields: {
      page: { boost: 3 },
      text: { boost: 2 },
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

  const ids = []

  const lunrIndex = (function buildSearch() {
    const index = elasticlunr(function () {
      this.addField('page')
      this.addField('text')
      this.setRef('id')
      this.saveDocument(false)
    })

    const addDoc = (type, text, id) => {
      ids.push(id)
      index.addDoc({
        [type]: trimOnlyNonWords(text),
        id: ids.length - 1,
      })
      index.addDoc({
        [type]: trim(text),
        id: ids.length - 1,
      })
    }

    searchTexts.forEach(([category, pages]) => {
      pages.forEach(([uri, page, types]) => {
        addDoc('page', page, { category, uri, page })
        types.forEach(([type, texts]) => {
          texts.forEach(([hash, text]) => {
            addDoc('text', text, {
              category, uri, type, hash, text,
            })
          })
        })
      })
    })

    return index
  }())

  function search(text) {
    const result = []
    const lunrResult = lunrIndex.search(trim(text), SEARCH_OPTIONS)

    lunrResult.forEach(({ ref }) => {
      console.log(ids[ref])
    })

    // const { pages } = searchTexts
    // const { texts } = searchTexts
    // for (let i = 0; i < lunrResult.length; i += 1) {
    //   const found = texts[lunrResult[i].ref]
    //   result.push({
    //     page: pages[found[0]],
    //     text: found[2],
    //   })
    // }
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
      const uri = `/${result[i].page}`
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
