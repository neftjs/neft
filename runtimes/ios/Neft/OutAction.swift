enum OutAction: Int {
    case
    // basic
    event = 0,

    // renderer
    screen_SIZE,
    screen_ORIENTATION,
    navigator_LANGUAGE,
    navigator_ONLINE,
    device_PIXEL_RATIO,
    device_IS_PHONE,
    pointer_PRESS,
    pointer_RELEASE,
    pointer_MOVE,
    device_KEYBOARD_SHOW,
    device_KEYBOARD_HIDE,
    key_PRESS,
    key_HOLD,
    key_INPUT,
    key_RELEASE,
    image_SIZE,
    text_SIZE,
    font_LOAD,
    scrollable_CONTENT_X,
    scrollable_CONTENT_Y,
    text_INPUT_TEXT,
    native_ITEM_WIDTH,
    native_ITEM_HEIGHT
}
