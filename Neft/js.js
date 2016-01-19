 (function() {
  window._createOnCompletion = function(id) {
  return function(data) {
  webkit.messageHandlers.response.postMessage({
                                              id: id,
                                              response: data
                                              });
  };
  };
  
  }).call(this);