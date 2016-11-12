enum OutAction: Int {
    case
    // basic
    event = 0,

    // renderer
    screenSize,
    screenOrientation,
    navigatorLanguage,
    navigatorOnline,
    devicePixelRatio,
    deviceIsPhone,
    pointerPress,
    pointerRelease,
    pointerMove,
    deviceKeyboardShow,
    deviceKeyboardHide,
    keyPress,
    keyHold,
    keyInput,
    keyRelease,
    imageSize,
    textSize,
    fontLoad,
    scrollableContentX,
    scrollableContentY,
    textInputText,
    nativeItemWidth,
    nativeItemHeight
}
