(function () {
  const thread = document.getElementById('disqus_thread')
  if (thread) {
    const script = document.createElement('script')
    script.src = 'https://neft.disqus.com/embed.js'
    script.setAttribute('data-timestamp', +new Date())
    document.body.appendChild(script)
  }
}())
