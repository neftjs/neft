enum OutAction: Int {
    case
    // basic
    event = 0,

    // renderer
    screenSize,
    screenOrientation,
    screenStatusBarHeight,
    navigatorLanguage,
    navigatorOnline,
    devicePixelRatio,
    deviceIsPhone,
    pointerPress,
    pointerRelease,
    pointerMove,
    deviceKeyboardShow,
    deviceKeyboardHide,
    deviceKeyboardHeight,
    keyPress,
    keyHold,
    keyInput,
    keyRelease,
    imageSize,
    textSize,
    fontLoad,
    nativeItemWidth,
    nativeItemHeight,
    windowResize,
    itemKeysFocus
}
