this._createOnCompletion = function(id) {
  return function(data) {
    ios.postMessage("response", {
      id: id,
      response: data,
    })
  }
}
