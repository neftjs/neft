const targetEnvs = {
  node: {
    node: true,
    server: true,
  },
  html: {
    html: true,
    browser: true,
    client: true,
  },
  webgl: {
    webgl: true,
    browser: true,
    client: true,
  },
  android: {
    android: true,
    client: true,
    native: true,
  },
  ios: {
    ios: true,
    client: true,
    native: true,
    apple: true,
  },
  macos: {
    macos: true,
    client: true,
    native: true,
    apple: true,
  },
}

exports.cliEnv = {
  NEFT_NODE: '1',
  NEFT_SERVER: '1',
  NEFT_PLATFORM: 'node',
}

exports.getTargetEnv = ({ production, target }) => {
  const env = {
    NODE_ENV: production ? 'production' : 'development',
    NEFT_PLATFORM: target,
  }
  Object.keys(targetEnvs).forEach((possibleTarget) => {
    const enabled = possibleTarget === target
    const val = enabled ? '1' : ''
    Object.keys(targetEnvs[possibleTarget]).forEach((key) => {
      const define = `NEFT_${key.toUpperCase()}`
      if (define in env && !enabled) return
      env[define] = val
    })
  })
  return env
}
