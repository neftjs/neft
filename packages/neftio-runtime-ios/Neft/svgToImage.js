const canvas = document.createElement('canvas')
const ctx = canvas.getContext('2d')

this.svgToImage = function(dataUri, width, height, callback) {
  const img = new Image()
  img.src = `data:image/svg+xmlutf8,${atob(dataUri)}`
  const onLoaded = function () {
    if (width !== 0) {
      img.width = width
    }
    if (height !== 0) {
      img.height = height
    }
    canvas.width = img.width
    canvas.height = img.height
    ctx.drawImage(img, 0, 0)
    return callback(canvas.toDataURL('image/png'))
  }
  const onError = function () {
    return callback('')
  }
  if (img.naturalWidth > 0) {
    onLoaded()
  } else {
    img.onload = onLoaded
    img.onerror = onError
  }
}
