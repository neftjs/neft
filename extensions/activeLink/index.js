const { utils } = Neft
const { callNativeFunction } = Neft.native

exports.mailto = (opts) => {
    const address = utils.isObject(opts) ? opts.address : opts
    callNativeFunction('extensionActiveLinkMailto', String(address))
}

exports.tel = (number) => {
    callNativeFunction('extensionActiveLinkTel', String(number))
}
