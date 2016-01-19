 (function() {
  'use strict';
  var canvas, ctx;
  
  window.onerror = function() {
  return document.write(Array.prototype.join.call(arguments));
  };
  
  canvas = document.createElement('canvas');
  
  ctx = canvas.getContext('2d');
  
  window.svgToImage = function(dataUri, width, height, callback) {
  var img, onError, onLoaded;
  img = new Image;
  img.src = "data:image/svg+xml;utf8," + (atob(dataUri));
  onLoaded = function() {
  if (width !== 0) {
  img.width = width;
  }
  if (height !== 0) {
  img.height = height;
  }
  width = canvas.width = img.width;
  height = canvas.height = img.height;
  ctx.drawImage(img, 0, 0);
  return callback(canvas.toDataURL("image/png"));
  };
  onError = function() {
  return callback("");
  };
  if (img.naturalWidth > 0) {
  onLoaded();
  } else {
  img.onload = onLoaded;
  img.onerror = onError;
  }
  };
  
  }).call(this);