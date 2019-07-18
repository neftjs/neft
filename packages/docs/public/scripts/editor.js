/* eslint-env browser */
/* global CodeFlask, NeftEditor */

(function () {
  const ws = new WebSocket('wss://editor.neft.io/socket')
  let wsKey = sessionStorage.getItem('editorWsKey')

  const showWsKey = () => {
    Array.from(document.querySelectorAll('.editor .key')).forEach((span) => {
      span.innerHTML = `Your code: <b>${wsKey.slice(0, 3)} ${wsKey.slice(3)}</b>`
    })
  }

  const getWsKey = async () => {
    if (wsKey) return
    const res = await fetch('https://editor.neft.io/hello')
    wsKey = await res.text()
    sessionStorage.setItem('editorWsKey', wsKey)
    showWsKey()
  }

  if (wsKey) {
    showWsKey()
  } else {
    getWsKey()
  }

  const sendToWsNow = (code) => {
    ws.send(JSON.stringify({
      push: wsKey,
      code,
    }))
  }

  Array.from(document.querySelectorAll('.editor')).forEach((editorElement) => {
    const textarea = editorElement.querySelector('textarea')
    // CodeFlask accepts an element and takes innerHTML as code to render;
    // we can't do that without escaping
    const flask = new CodeFlask({
      nodeType: true,
      innerHTML: textarea.value,
      appendChild: editorElement.appendChild.bind(editorElement),
    }, { language: 'xml' })
    const codeElement = editorElement.querySelector('.code')
    codeElement.insertBefore(flask.elWrapper, textarea)
    codeElement.removeChild(textarea)
    const iframe = editorElement.querySelector('iframe')

    let wsSendTimeout
    let browserSendTimeout

    const sendToWs = (code) => {
      if (ws.readyState !== WebSocket.OPEN) return
      clearTimeout(wsSendTimeout)
      wsSendTimeout = setTimeout(sendToWsNow, 300, code)
    }

    const sendCodeNow = (code) => {
      const compiled = NeftEditor.compile(code)
      iframe.contentWindow.postMessage(compiled, '*')
      sendToWs(compiled)
    }

    const sendCode = (code) => {
      clearTimeout(browserSendTimeout)
      browserSendTimeout = setTimeout(sendCodeNow, 200, code)
    }

    const updateCode = () => {
      try {
        sendCode(flask.getCode())
      } catch (error) {
        console.error(error)
      }
    }

    ws.onopen = updateCode

    setTimeout(() => {
      flask.onUpdate(updateCode)
      updateCode()
    })
  })
}())
