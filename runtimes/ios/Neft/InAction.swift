enum InAction: Int {
    case
    // basic
    callFunction = 0,

    // renderer
    deviceLog,
    deviceShowKeyboard,
    deviceHideKeyboard,

    setWindow,

    createItem,
    setItemParent,
    insertItemBefore,
    setItemVisible,
    setItemClip,
    setItemWidth,
    setItemHeight,
    setItemX,
    setItemY,
    setItemScale,
    setItemRotation,
    setItemOpacity,
    setItemBackground,
    setItemKeysFocus,

    createImage,
    setImageSource,
    setImageSourceWidth,
    setImageSourceHeight,
    setImageFillMode,
    setImageOffsetX,
    setImageOffsetY,

    createText,
    setText,
    setTextWrap,
    updateTextContentSize,
    setTextColor,
    setTextLineHeight,
    setTextFontFamily,
    setTextFontPixelSize,
    setTextFontWordSpacing,
    setTextFontLetterSpacing,
    setTextAlignmentHorizontal,
    setTextAlignmentVertical,

    createTextInput,
    setTextInputText,
    setTextInputColor,
    setTextInputLineHeight,
    setTextInputMultiLine,
    setTextInputEchoMode,
    setTextInputFontFamily,
    setTextFontInputPixelSize,
    setTextFontInputWordSpacing,
    setTextFontInputLetterSpacing,
    setTextInputAlignmentHorizontal,
    setTextInputAlignmentVertical,

    createNativeItem,
    onNativeItemPointerPress,
    onNativeItemPointerRelease,
    onNativeItemPointerMove,

    loadFont,

    createRectangle,
    setRectangleColor,
    setRectangleRadius,
    setRectangleBorderColor,
    setRectangleBorderWidth,

    createScrollable,
    setScrollableContentItem,
    setScrollableContentX,
    setScrollableContentY,
    activateScrollable
}
