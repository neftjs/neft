/* eslint-env browser */
/* global CodeFlask, NeftEditor */

(function () {
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

    const compileCode = () => {
      try {
        const compiled = NeftEditor.compile(flask.getCode())
        iframe.contentWindow.postMessage(compiled)
      } catch (error) {
        // NOP
      }
    }

    setTimeout(() => {
      flask.onUpdate(compileCode)
      compileCode()
    })
  })
}())
