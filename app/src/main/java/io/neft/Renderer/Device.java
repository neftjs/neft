package io.neft.Renderer;

import android.app.Activity;
import android.content.Context;
import android.content.res.Configuration;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.util.DisplayMetrics;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;

public class Device {
    static final String[] keyCodes;

    static {
        keyCodes = new String[KeyEvent.getMaxKeyCode()];

        try {
            keyCodes[KeyEvent.KEYCODE_UNKNOWN] = "Unknown";
            keyCodes[KeyEvent.KEYCODE_SOFT_LEFT] = "SoftLeft";
            keyCodes[KeyEvent.KEYCODE_SOFT_RIGHT] = "SoftRight";
            keyCodes[KeyEvent.KEYCODE_HOME] = "Home";
            keyCodes[KeyEvent.KEYCODE_BACK] = "Back";
            keyCodes[KeyEvent.KEYCODE_CALL] = "Call";
            keyCodes[KeyEvent.KEYCODE_ENDCALL] = "EndCall";
            keyCodes[KeyEvent.KEYCODE_0] = "0";
            keyCodes[KeyEvent.KEYCODE_1] = "1";
            keyCodes[KeyEvent.KEYCODE_2] = "2";
            keyCodes[KeyEvent.KEYCODE_3] = "3";
            keyCodes[KeyEvent.KEYCODE_4] = "4";
            keyCodes[KeyEvent.KEYCODE_5] = "5";
            keyCodes[KeyEvent.KEYCODE_6] = "6";
            keyCodes[KeyEvent.KEYCODE_7] = "7";
            keyCodes[KeyEvent.KEYCODE_8] = "8";
            keyCodes[KeyEvent.KEYCODE_9] = "9";
            keyCodes[KeyEvent.KEYCODE_STAR] = "Star";
            keyCodes[KeyEvent.KEYCODE_POUND] = "Pound";
            keyCodes[KeyEvent.KEYCODE_DPAD_UP] = "DPadUp";
            keyCodes[KeyEvent.KEYCODE_DPAD_DOWN] = "DPadDown";
            keyCodes[KeyEvent.KEYCODE_DPAD_LEFT] = "DPadLeft";
            keyCodes[KeyEvent.KEYCODE_DPAD_RIGHT] = "DPadRight";
            keyCodes[KeyEvent.KEYCODE_DPAD_CENTER] = "DPadCenter";
            keyCodes[KeyEvent.KEYCODE_VOLUME_UP] = "VolumeUp";
            keyCodes[KeyEvent.KEYCODE_VOLUME_DOWN] = "VolumeDown";
            keyCodes[KeyEvent.KEYCODE_POWER] = "Power";
            keyCodes[KeyEvent.KEYCODE_CAMERA] = "Camera";
            keyCodes[KeyEvent.KEYCODE_CLEAR] = "Clear";
            keyCodes[KeyEvent.KEYCODE_A] = "A";
            keyCodes[KeyEvent.KEYCODE_B] = "B";
            keyCodes[KeyEvent.KEYCODE_C] = "C";
            keyCodes[KeyEvent.KEYCODE_D] = "D";
            keyCodes[KeyEvent.KEYCODE_E] = "E";
            keyCodes[KeyEvent.KEYCODE_F] = "F";
            keyCodes[KeyEvent.KEYCODE_G] = "G";
            keyCodes[KeyEvent.KEYCODE_H] = "H";
            keyCodes[KeyEvent.KEYCODE_I] = "I";
            keyCodes[KeyEvent.KEYCODE_J] = "J";
            keyCodes[KeyEvent.KEYCODE_K] = "K";
            keyCodes[KeyEvent.KEYCODE_L] = "L";
            keyCodes[KeyEvent.KEYCODE_M] = "M";
            keyCodes[KeyEvent.KEYCODE_N] = "N";
            keyCodes[KeyEvent.KEYCODE_O] = "O";
            keyCodes[KeyEvent.KEYCODE_P] = "P";
            keyCodes[KeyEvent.KEYCODE_Q] = "Q";
            keyCodes[KeyEvent.KEYCODE_R] = "R";
            keyCodes[KeyEvent.KEYCODE_S] = "S";
            keyCodes[KeyEvent.KEYCODE_T] = "T";
            keyCodes[KeyEvent.KEYCODE_U] = "U";
            keyCodes[KeyEvent.KEYCODE_V] = "V";
            keyCodes[KeyEvent.KEYCODE_W] = "W";
            keyCodes[KeyEvent.KEYCODE_X] = "X";
            keyCodes[KeyEvent.KEYCODE_Y] = "Y";
            keyCodes[KeyEvent.KEYCODE_Z] = "Z";
            keyCodes[KeyEvent.KEYCODE_COMMA] = ",";
            keyCodes[KeyEvent.KEYCODE_PERIOD] = ".";
            keyCodes[KeyEvent.KEYCODE_ALT_LEFT] = "AltLeft";
            keyCodes[KeyEvent.KEYCODE_ALT_RIGHT] = "AltRight";
            keyCodes[KeyEvent.KEYCODE_SHIFT_LEFT] = "ShiftLeft";
            keyCodes[KeyEvent.KEYCODE_SHIFT_RIGHT] = "ShiftRight";
            keyCodes[KeyEvent.KEYCODE_TAB] = "Tab";
            keyCodes[KeyEvent.KEYCODE_SPACE] = "Space";
            keyCodes[KeyEvent.KEYCODE_SYM] = "Symbol";
            keyCodes[KeyEvent.KEYCODE_EXPLORER] = "Explorer";
            keyCodes[KeyEvent.KEYCODE_ENVELOPE] = "Envelope";
            keyCodes[KeyEvent.KEYCODE_ENTER] = "Enter";
            keyCodes[KeyEvent.KEYCODE_DEL] = "Backspace";
            keyCodes[KeyEvent.KEYCODE_GRAVE] = "`";
            keyCodes[KeyEvent.KEYCODE_MINUS] = "-";
            keyCodes[KeyEvent.KEYCODE_EQUALS] = "=";
            keyCodes[KeyEvent.KEYCODE_LEFT_BRACKET] = "[";
            keyCodes[KeyEvent.KEYCODE_RIGHT_BRACKET] = "]";
            keyCodes[KeyEvent.KEYCODE_BACKSLASH] = "\\";
            keyCodes[KeyEvent.KEYCODE_SEMICOLON] = ";";
            keyCodes[KeyEvent.KEYCODE_APOSTROPHE] = "'";
            keyCodes[KeyEvent.KEYCODE_SLASH] = "/";
            keyCodes[KeyEvent.KEYCODE_AT] = "@";
            keyCodes[KeyEvent.KEYCODE_NUM] = "Num";
            keyCodes[KeyEvent.KEYCODE_HEADSETHOOK] = "HeadsetHool";
            keyCodes[KeyEvent.KEYCODE_FOCUS] = "Focus";
            keyCodes[KeyEvent.KEYCODE_PLUS] = "+";
            keyCodes[KeyEvent.KEYCODE_MENU] = "Menu";
            keyCodes[KeyEvent.KEYCODE_NOTIFICATION] = "Notification";
            keyCodes[KeyEvent.KEYCODE_SEARCH] = "Search";
            keyCodes[KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE] = "MediaPlayPause";
            keyCodes[KeyEvent.KEYCODE_MEDIA_STOP] = "MediaStop";
            keyCodes[KeyEvent.KEYCODE_MEDIA_NEXT] = "MediaNext";
            keyCodes[KeyEvent.KEYCODE_MEDIA_PREVIOUS] = "MediaPrevious";
            keyCodes[KeyEvent.KEYCODE_MEDIA_REWIND] = "MediaRewind";
            keyCodes[KeyEvent.KEYCODE_MEDIA_FAST_FORWARD] = "MediaFastForward";
            keyCodes[KeyEvent.KEYCODE_MUTE] = "Mute";
            keyCodes[KeyEvent.KEYCODE_PAGE_UP] = "PageUp";
            keyCodes[KeyEvent.KEYCODE_PAGE_DOWN] = "PageDown";
            keyCodes[KeyEvent.KEYCODE_PICTSYMBOLS] = "PictureSymbols";
            keyCodes[KeyEvent.KEYCODE_SWITCH_CHARSET] = "SwitchCharset";
            keyCodes[KeyEvent.KEYCODE_BUTTON_A] = "ButtonA";
            keyCodes[KeyEvent.KEYCODE_BUTTON_B] = "ButtonB";
            keyCodes[KeyEvent.KEYCODE_BUTTON_C] = "ButtonC";
            keyCodes[KeyEvent.KEYCODE_BUTTON_X] = "ButtonX";
            keyCodes[KeyEvent.KEYCODE_BUTTON_Y] = "ButtonY";
            keyCodes[KeyEvent.KEYCODE_BUTTON_Z] = "ButtonZ";
            keyCodes[KeyEvent.KEYCODE_BUTTON_L1] = "ButtonL1";
            keyCodes[KeyEvent.KEYCODE_BUTTON_R1] = "ButtonR1";
            keyCodes[KeyEvent.KEYCODE_BUTTON_L2] = "ButtonL2";
            keyCodes[KeyEvent.KEYCODE_BUTTON_R2] = "ButtonR2";
            keyCodes[KeyEvent.KEYCODE_BUTTON_THUMBL] = "ButtonThumbLeft";
            keyCodes[KeyEvent.KEYCODE_BUTTON_THUMBR] = "ButtonThumbRight";
            keyCodes[KeyEvent.KEYCODE_BUTTON_START] = "ButtonStart";
            keyCodes[KeyEvent.KEYCODE_BUTTON_SELECT] = "ButtonSelect";
            keyCodes[KeyEvent.KEYCODE_BUTTON_MODE] = "ButtonMode";
            keyCodes[KeyEvent.KEYCODE_ESCAPE] = "Escape";
            keyCodes[KeyEvent.KEYCODE_FORWARD_DEL] = "Delete";
            keyCodes[KeyEvent.KEYCODE_CTRL_LEFT] = "CtrlLeft";
            keyCodes[KeyEvent.KEYCODE_CTRL_RIGHT] = "CtrlRight";
            keyCodes[KeyEvent.KEYCODE_CAPS_LOCK] = "CapsLock";
            keyCodes[KeyEvent.KEYCODE_SCROLL_LOCK] = "ScrollLock";
            keyCodes[KeyEvent.KEYCODE_META_LEFT] = "MetaLeft";
            keyCodes[KeyEvent.KEYCODE_META_RIGHT] = "MetaRight";
            keyCodes[KeyEvent.KEYCODE_FUNCTION] = "Function";
            keyCodes[KeyEvent.KEYCODE_SYSRQ] = "PrintScreen";
            keyCodes[KeyEvent.KEYCODE_BREAK] = "Break";
            keyCodes[KeyEvent.KEYCODE_MOVE_HOME] = "Home";
            keyCodes[KeyEvent.KEYCODE_MOVE_END] = "End";
            keyCodes[KeyEvent.KEYCODE_INSERT] = "Insert";
            keyCodes[KeyEvent.KEYCODE_FORWARD] = "Forward";
            keyCodes[KeyEvent.KEYCODE_MEDIA_PLAY] = "MediaPlay";
            keyCodes[KeyEvent.KEYCODE_MEDIA_PAUSE] = "MediaPause";
            keyCodes[KeyEvent.KEYCODE_MEDIA_CLOSE] = "MediaClose";
            keyCodes[KeyEvent.KEYCODE_MEDIA_EJECT] = "MediaEject";
            keyCodes[KeyEvent.KEYCODE_MEDIA_RECORD] = "MediaRecord";
            keyCodes[KeyEvent.KEYCODE_F1] = "F1";
            keyCodes[KeyEvent.KEYCODE_F2] = "F2";
            keyCodes[KeyEvent.KEYCODE_F3] = "F3";
            keyCodes[KeyEvent.KEYCODE_F4] = "F4";
            keyCodes[KeyEvent.KEYCODE_F5] = "F5";
            keyCodes[KeyEvent.KEYCODE_F6] = "F6";
            keyCodes[KeyEvent.KEYCODE_F7] = "F7";
            keyCodes[KeyEvent.KEYCODE_F8] = "F8";
            keyCodes[KeyEvent.KEYCODE_F9] = "F9";
            keyCodes[KeyEvent.KEYCODE_F10] = "F10";
            keyCodes[KeyEvent.KEYCODE_F11] = "F11";
            keyCodes[KeyEvent.KEYCODE_F12] = "F12";
            keyCodes[KeyEvent.KEYCODE_NUM_LOCK] = "NumLock";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_0] = "NumPad0";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_1] = "NumPad1";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_2] = "NumPad2";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_3] = "NumPad3";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_4] = "NumPad4";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_5] = "NumPad5";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_6] = "NumPad6";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_7] = "NumPad7";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_8] = "NumPad8";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_9] = "NumPad9";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_DIVIDE] = "NumPad/";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_MULTIPLY] = "NumPad*";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_SUBTRACT] = "NumPad-";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_ADD] = "NumPad+";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_DOT] = "NumPad.";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_COMMA] = "NumPad,";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_ENTER] = "NumPadEnter";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_EQUALS] = "NumPad=";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_LEFT_PAREN] = "NumPad(";
            keyCodes[KeyEvent.KEYCODE_NUMPAD_RIGHT_PAREN] = "NumPad)";
            keyCodes[KeyEvent.KEYCODE_VOLUME_MUTE] = "VolumeMute";
            keyCodes[KeyEvent.KEYCODE_INFO] = "Info";
            keyCodes[KeyEvent.KEYCODE_CHANNEL_UP] = "ChannelUp";
            keyCodes[KeyEvent.KEYCODE_CHANNEL_DOWN] = "ChannelDown";
            keyCodes[KeyEvent.KEYCODE_ZOOM_IN] = "ZoomIn";
            keyCodes[KeyEvent.KEYCODE_ZOOM_OUT] = "ZoomOut";
            keyCodes[KeyEvent.KEYCODE_TV] = "TV";
            keyCodes[KeyEvent.KEYCODE_WINDOW] = "Window";
            keyCodes[KeyEvent.KEYCODE_GUIDE] = "Guide";
            keyCodes[KeyEvent.KEYCODE_DVR] = "DVR";
            keyCodes[KeyEvent.KEYCODE_BOOKMARK] = "Bookmark";
            keyCodes[KeyEvent.KEYCODE_CAPTIONS] = "Captions";
            keyCodes[KeyEvent.KEYCODE_SETTINGS] = "Settings";
            keyCodes[KeyEvent.KEYCODE_TV_POWER] = "TVPower";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT] = "TVInput";
            keyCodes[KeyEvent.KEYCODE_STB_POWER] = "STBPower";
            keyCodes[KeyEvent.KEYCODE_STB_INPUT] = "STBInput";
            keyCodes[KeyEvent.KEYCODE_AVR_POWER] = "AVRPower";
            keyCodes[KeyEvent.KEYCODE_AVR_INPUT] = "AVRInput";
            keyCodes[KeyEvent.KEYCODE_PROG_RED] = "ProgrammableRed";
            keyCodes[KeyEvent.KEYCODE_PROG_GREEN] = "ProgrammableGreen";
            keyCodes[KeyEvent.KEYCODE_PROG_YELLOW] = "ProgrammableYellow";
            keyCodes[KeyEvent.KEYCODE_PROG_BLUE] = "ProgrammableBlue";
            keyCodes[KeyEvent.KEYCODE_APP_SWITCH] = "AppSwitch";
            keyCodes[KeyEvent.KEYCODE_BUTTON_1] = "Button1";
            keyCodes[KeyEvent.KEYCODE_BUTTON_2] = "Button2";
            keyCodes[KeyEvent.KEYCODE_BUTTON_3] = "Button3";
            keyCodes[KeyEvent.KEYCODE_BUTTON_4] = "Button4";
            keyCodes[KeyEvent.KEYCODE_BUTTON_5] = "Button5";
            keyCodes[KeyEvent.KEYCODE_BUTTON_6] = "Button6";
            keyCodes[KeyEvent.KEYCODE_BUTTON_7] = "Button7";
            keyCodes[KeyEvent.KEYCODE_BUTTON_8] = "Button8";
            keyCodes[KeyEvent.KEYCODE_BUTTON_9] = "Button9";
            keyCodes[KeyEvent.KEYCODE_BUTTON_10] = "Button10";
            keyCodes[KeyEvent.KEYCODE_BUTTON_11] = "Button11";
            keyCodes[KeyEvent.KEYCODE_BUTTON_12] = "Button12";
            keyCodes[KeyEvent.KEYCODE_BUTTON_13] = "Button13";
            keyCodes[KeyEvent.KEYCODE_BUTTON_14] = "Button14";
            keyCodes[KeyEvent.KEYCODE_BUTTON_15] = "Button15";
            keyCodes[KeyEvent.KEYCODE_BUTTON_16] = "Button16";
            keyCodes[KeyEvent.KEYCODE_LANGUAGE_SWITCH] = "LanguageSwitch";
            keyCodes[KeyEvent.KEYCODE_MANNER_MODE] = "MannerMode";
            keyCodes[KeyEvent.KEYCODE_3D_MODE] = "3DMode";
            keyCodes[KeyEvent.KEYCODE_CONTACTS] = "Contacts";
            keyCodes[KeyEvent.KEYCODE_CALENDAR] = "Calendar";
            keyCodes[KeyEvent.KEYCODE_MUSIC] = "Music";
            keyCodes[KeyEvent.KEYCODE_CALCULATOR] = "Calculator";
            keyCodes[KeyEvent.KEYCODE_ZENKAKU_HANKAKU] = "ZenkakuHankaku";
            keyCodes[KeyEvent.KEYCODE_EISU] = "Eisu";
            keyCodes[KeyEvent.KEYCODE_MUHENKAN] = "Muhenkan";
            keyCodes[KeyEvent.KEYCODE_HENKAN] = "Henkan";
            keyCodes[KeyEvent.KEYCODE_KATAKANA_HIRAGANA] = "KatakanaHiragana";
            keyCodes[KeyEvent.KEYCODE_YEN] = "Yen";
            keyCodes[KeyEvent.KEYCODE_RO] = "Ro";
            keyCodes[KeyEvent.KEYCODE_KANA] = "Kana";
            keyCodes[KeyEvent.KEYCODE_ASSIST] = "Assist";
            keyCodes[KeyEvent.KEYCODE_BRIGHTNESS_DOWN] = "BrightnessDown";
            keyCodes[KeyEvent.KEYCODE_BRIGHTNESS_UP] = "BrightnessUp";
            keyCodes[KeyEvent.KEYCODE_MEDIA_AUDIO_TRACK] = "MediaAudioTrack";
            keyCodes[KeyEvent.KEYCODE_SLEEP] = "Sleep";
            keyCodes[KeyEvent.KEYCODE_WAKEUP] = "WakeUp";
            keyCodes[KeyEvent.KEYCODE_PAIRING] = "Pairing";
            keyCodes[KeyEvent.KEYCODE_MEDIA_TOP_MENU] = "MediaTopMenu";
            keyCodes[KeyEvent.KEYCODE_11] = "11";
            keyCodes[KeyEvent.KEYCODE_12] = "12";
            keyCodes[KeyEvent.KEYCODE_LAST_CHANNEL] = "LastChannel";
            keyCodes[KeyEvent.KEYCODE_TV_DATA_SERVICE] = "TVDataService";
            keyCodes[KeyEvent.KEYCODE_VOICE_ASSIST] = "VoiceAssist";
            keyCodes[KeyEvent.KEYCODE_TV_RADIO_SERVICE] = "TVRadioService";
            keyCodes[KeyEvent.KEYCODE_TV_TELETEXT] = "TVTeletext";
            keyCodes[KeyEvent.KEYCODE_TV_NUMBER_ENTRY] = "TVNumberEntry";
            keyCodes[KeyEvent.KEYCODE_TV_TERRESTRIAL_ANALOG] = "TVTerrestrialAnalog";
            keyCodes[KeyEvent.KEYCODE_TV_TERRESTRIAL_DIGITAL] = "TVTerrestrialDigital";
            keyCodes[KeyEvent.KEYCODE_TV_SATELLITE] = "TVSatellite";
            keyCodes[KeyEvent.KEYCODE_TV_SATELLITE_BS] = "TVSatelliteBS";
            keyCodes[KeyEvent.KEYCODE_TV_SATELLITE_CS] = "TVSatelliteCS";
            keyCodes[KeyEvent.KEYCODE_TV_SATELLITE_SERVICE] = "TVSatelliteService";
            keyCodes[KeyEvent.KEYCODE_TV_NETWORK] = "TVNetwork";
            keyCodes[KeyEvent.KEYCODE_TV_ANTENNA_CABLE] = "TVAntennaCable";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT_HDMI_1] = "TVInputHDMI1";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT_HDMI_2] = "TVInputHDMI2";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT_HDMI_3] = "TVInputHDMI3";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT_HDMI_4] = "TVInputHDMI4";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT_COMPOSITE_1] = "TVInputComposite1";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT_COMPOSITE_2] = "TVInputComposite1";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT_COMPONENT_1] = "TVInputComponent1";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT_COMPONENT_2] = "TVInputComponent2";
            keyCodes[KeyEvent.KEYCODE_TV_INPUT_VGA_1] = "TVInputVGA1";
            keyCodes[KeyEvent.KEYCODE_TV_AUDIO_DESCRIPTION] = "TVAudioDescription";
            keyCodes[KeyEvent.KEYCODE_TV_AUDIO_DESCRIPTION_MIX_UP] = "TVAudioDescriptionMixUp";
            keyCodes[KeyEvent.KEYCODE_TV_AUDIO_DESCRIPTION_MIX_DOWN] = "TVAudioDescriptionMixDown";
            keyCodes[KeyEvent.KEYCODE_TV_ZOOM_MODE] = "TVZoomMode";
            keyCodes[KeyEvent.KEYCODE_TV_CONTENTS_MENU] = "TVContentsMenu";
            keyCodes[KeyEvent.KEYCODE_TV_MEDIA_CONTEXT_MENU] = "TVMediaContextMenu";
            keyCodes[KeyEvent.KEYCODE_TV_TIMER_PROGRAMMING] = "TVTimerProgramming";
            keyCodes[KeyEvent.KEYCODE_HELP] = "Help";
            keyCodes[KeyEvent.KEYCODE_NAVIGATE_PREVIOUS] = "NavigatePrevious";
            keyCodes[KeyEvent.KEYCODE_NAVIGATE_NEXT] = "NavigateNext";
            keyCodes[KeyEvent.KEYCODE_NAVIGATE_IN] = "NavigateIn";
            keyCodes[KeyEvent.KEYCODE_NAVIGATE_OUT] = "NavigateOut";
            keyCodes[KeyEvent.KEYCODE_MEDIA_SKIP_FORWARD] = "MediaSkipForward";
            keyCodes[KeyEvent.KEYCODE_MEDIA_SKIP_BACKWARD] = "MediaSkipBackward";
            keyCodes[KeyEvent.KEYCODE_MEDIA_STEP_FORWARD] = "MediaStepForward";
            keyCodes[KeyEvent.KEYCODE_MEDIA_STEP_BACKWARD] = "MediaStepBackward";
        } catch(ArrayIndexOutOfBoundsException err){
        }
    }

    class KeyboardText extends EditText {
        private final Device device;

        public KeyboardText(Context context, final Device device){
            super(context);
            this.device = device;
            this.setInputType(InputType.TYPE_CLASS_TEXT);
            this.setVisibility(View.INVISIBLE);

            // set layout to get onKeyPreIme
            this.layout(0, 0, 1, 1);

            this.setOnKeyListener(new OnKeyListener() {
                @Override
                public boolean onKey(View v, int keyCode, KeyEvent event) {
                    return device.onKey(keyCode, event);
                }
            });

            this.addTextChangedListener(new TextWatcher() {
                public void afterTextChanged(Editable s) {
                }

                public void beforeTextChanged(CharSequence s, int start, int count, int after) {
                }

                public void onTextChanged(CharSequence s, int start, int before, int count) {
                    final int startIndex = start + before;
                    final int endIndex = start + count;
                    if (endIndex > startIndex) {
                        final CharSequence text = s.subSequence(startIndex, endIndex);
                        device.renderer.pushAction(Renderer.OutAction.KEY_INPUT);
                        device.renderer.pushString(text.toString());
                    }
                }
            });
        }

        public boolean onKeyPreIme(int keyCode, KeyEvent event){
            return device.onKey(keyCode, event);
        }
    }

    public final float pixelRatio;
    public final boolean isPhone;
    public Renderer renderer;
    public boolean keyboardVisible = false;
    public MotionEvent pointerDownEvent;

    public final KeyboardText keyboardText;

    static void register(Renderer renderer){
        renderer.actions.put(Renderer.InAction.DEVICE_SHOW_KEYBOARD, new Action() {
            @Override
            void work(Reader reader) {
                reader.renderer.device.showKeyboard();
            }
        });

        renderer.actions.put(Renderer.InAction.DEVICE_HIDE_KEYBOARD, new Action() {
            @Override
            void work(Reader reader) {
                reader.renderer.device.hideKeyboard();
            }
        });
    }

    public Device(Renderer renderer){
        this.renderer = renderer;

        // create EditText to handle KeyInput
        this.keyboardText = new KeyboardText(renderer.mainActivity.getApplicationContext(), this);
        renderer.mainActivity.view.addView(keyboardText);

        // hide keyboard
        final Window window = ((Activity) renderer.mainActivity.view.getContext()).getWindow();
        window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);

        // DEVICE_PIXEL_RATIO
        final DisplayMetrics metrics = renderer.mainActivity.getResources().getDisplayMetrics();
        this.pixelRatio = metrics.density;
        renderer.pushAction(Renderer.OutAction.DEVICE_PIXEL_RATIO);
        renderer.pushFloat(pixelRatio);

        // DEVICE_IS_PHONE
        this.isPhone = (renderer.mainActivity.getResources().getConfiguration().screenLayout
                & Configuration.SCREENLAYOUT_SIZE_MASK)
                >= Configuration.SCREENLAYOUT_SIZE_LARGE;
        renderer.pushAction(Renderer.OutAction.DEVICE_IS_PHONE);
        renderer.pushBoolean(isPhone);
    }

    void showKeyboard(){
        InputMethodManager imm = (InputMethodManager) renderer.mainActivity.getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.toggleSoftInputFromWindow(renderer.mainActivity.view.getWindowToken(), InputMethodManager.SHOW_FORCED, 0);
        keyboardText.requestFocus();

        this.keyboardVisible = true;
        renderer.pushAction(Renderer.OutAction.DEVICE_KEYBOARD_SHOW);
    }

    void hideKeyboard(){
        InputMethodManager imm = (InputMethodManager) renderer.mainActivity.getSystemService(Context.INPUT_METHOD_SERVICE);
        imm.hideSoftInputFromWindow(renderer.mainActivity.view.getWindowToken(), 0);
        keyboardText.clearFocus();
        keyboardText.setText(null);

        this.keyboardVisible = false;
        renderer.pushAction(Renderer.OutAction.DEVICE_KEYBOARD_HIDE);
    }

    public boolean onTouchEvent(MotionEvent event){
        switch (event.getAction()){
            case MotionEvent.ACTION_DOWN:
                pointerDownEvent = event;
                renderer.pushAction(Renderer.OutAction.POINTER_PRESS);
                break;
            case MotionEvent.ACTION_UP:
                renderer.pushAction(Renderer.OutAction.POINTER_RELEASE);
                break;
            case MotionEvent.ACTION_MOVE:
                renderer.pushAction(Renderer.OutAction.POINTER_MOVE);
                break;
            default:
                return true;
        }

        renderer.pushFloat(event.getX() / pixelRatio);
        renderer.pushFloat(event.getY() / pixelRatio);

        return true;
    }

    public boolean onKey(int keyCode, KeyEvent event){
        // hide keyboard
        if (keyboardVisible && (keyCode & (KeyEvent.KEYCODE_BACK | KeyEvent.KEYCODE_ENTER)) > 0) {
            this.hideKeyboard();
        }

        switch (event.getAction()){
            case KeyEvent.ACTION_DOWN:
                renderer.pushAction(Renderer.OutAction.KEY_PRESS);
                break;
            case KeyEvent.ACTION_UP:
                renderer.pushAction(Renderer.OutAction.KEY_RELEASE);
                break;
            case KeyEvent.ACTION_MULTIPLE:
                renderer.pushAction(Renderer.OutAction.KEY_HOLD);
                break;
            default:
                return false;
        }

        renderer.pushString(keyCodes[keyCode]);

        return keyCode == KeyEvent.KEYCODE_BACK;
    }
}
