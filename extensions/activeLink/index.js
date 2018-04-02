const { utils } = Neft
const { callNativeFunction } = Neft.native

exports.mailto = (opts) => {
    const isOpts = utils.isObject(opts)
    const address = String(isOpts ? opts.address : opts)
    const subject = isOpts ? String(opts.subject) : null
    callNativeFunction('extensionActiveLinkMailto', address, subject)
}

exports.tel = (number) => {
    callNativeFunction('extensionActiveLinkTel', String(number))
}
