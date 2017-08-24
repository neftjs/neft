package io.neft.renderer;

import android.content.Context;
import android.content.res.Configuration;
import android.content.res.Resources;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.util.DisplayMetrics;
import android.util.Log;
import android.util.SparseArray;
import android.view.KeyEvent;
import android.view.MotionEvent;
import android.view.View;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;

import io.neft.App;
import io.neft.client.InAction;
import io.neft.client.OutAction;
import io.neft.client.handlers.NoArgsActionHandler;
import io.neft.client.handlers.StringActionHandler;
import lombok.Getter;

public final class Device {
    private static class KeyboardText extends EditText {
        public KeyboardText(Context context){
            super(context);
            this.setInputType(InputType.TYPE_CLASS_TEXT);
            this.setVisibility(View.INVISIBLE);

            // set layout to get onKeyPreIme
            this.layout(0, 0, 1, 1);

            this.setOnKeyListener(new OnKeyListener() {
                @Override
                public boolean onKey(View v, int keyCode, KeyEvent event) {
                    APP.processKeyEvent(keyCode, event);
                    return true;
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
                        APP.getClient().pushAction(OutAction.KEY_INPUT, text.toString());
                    }
                }
            });
        }

        public boolean onKeyPreIme(int keyCode, KeyEvent event){
            APP.processKeyEvent(keyCode, event);
            return true;
        }
    }

    private static final App APP = App.getInstance();
    private static final String[] KEY_CODES;
    private static final SparseArray<OutAction> TOUCH_EVENTS_MAPPING = new SparseArray<>();
    private static final SparseArray<OutAction> KEY_EVENTS_MAPPING = new SparseArray<>();
    private static final int[] VIEW_LOCATION = new int[2];

    static {
        KEY_EVENTS_MAPPING.put(KeyEvent.ACTION_DOWN, OutAction.KEY_PRESS);
        KEY_EVENTS_MAPPING.put(KeyEvent.ACTION_UP, OutAction.KEY_RELEASE);
        KEY_EVENTS_MAPPING.put(KeyEvent.ACTION_MULTIPLE, OutAction.KEY_HOLD);
    }

    static {
        TOUCH_EVENTS_MAPPING.put(MotionEvent.ACTION_DOWN, OutAction.POINTER_PRESS);
        TOUCH_EVENTS_MAPPING.put(MotionEvent.ACTION_UP, OutAction.POINTER_RELEASE);
        TOUCH_EVENTS_MAPPING.put(MotionEvent.ACTION_MOVE, OutAction.POINTER_MOVE);
    }

    static {
        KEY_CODES = new String[KeyEvent.getMaxKeyCode()];

        try {
            KEY_CODES[KeyEvent.KEYCODE_UNKNOWN] = "Unknown";
            KEY_CODES[KeyEvent.KEYCODE_SOFT_LEFT] = "SoftLeft";
            KEY_CODES[KeyEvent.KEYCODE_SOFT_RIGHT] = "SoftRight";
            KEY_CODES[KeyEvent.KEYCODE_HOME] = "Home";
            KEY_CODES[KeyEvent.KEYCODE_BACK] = "Back";
            KEY_CODES[KeyEvent.KEYCODE_CALL] = "Call";
            KEY_CODES[KeyEvent.KEYCODE_ENDCALL] = "EndCall";
            KEY_CODES[KeyEvent.KEYCODE_0] = "0";
            KEY_CODES[KeyEvent.KEYCODE_1] = "1";
            KEY_CODES[KeyEvent.KEYCODE_2] = "2";
            KEY_CODES[KeyEvent.KEYCODE_3] = "3";
            KEY_CODES[KeyEvent.KEYCODE_4] = "4";
            KEY_CODES[KeyEvent.KEYCODE_5] = "5";
            KEY_CODES[KeyEvent.KEYCODE_6] = "6";
            KEY_CODES[KeyEvent.KEYCODE_7] = "7";
            KEY_CODES[KeyEvent.KEYCODE_8] = "8";
            KEY_CODES[KeyEvent.KEYCODE_9] = "9";
            KEY_CODES[KeyEvent.KEYCODE_STAR] = "Star";
            KEY_CODES[KeyEvent.KEYCODE_POUND] = "Pound";
            KEY_CODES[KeyEvent.KEYCODE_DPAD_UP] = "DPadUp";
            KEY_CODES[KeyEvent.KEYCODE_DPAD_DOWN] = "DPadDown";
            KEY_CODES[KeyEvent.KEYCODE_DPAD_LEFT] = "DPadLeft";
            KEY_CODES[KeyEvent.KEYCODE_DPAD_RIGHT] = "DPadRight";
            KEY_CODES[KeyEvent.KEYCODE_DPAD_CENTER] = "DPadCenter";
            KEY_CODES[KeyEvent.KEYCODE_VOLUME_UP] = "VolumeUp";
            KEY_CODES[KeyEvent.KEYCODE_VOLUME_DOWN] = "VolumeDown";
            KEY_CODES[KeyEvent.KEYCODE_POWER] = "Power";
            KEY_CODES[KeyEvent.KEYCODE_CAMERA] = "Camera";
            KEY_CODES[KeyEvent.KEYCODE_CLEAR] = "Clear";
            KEY_CODES[KeyEvent.KEYCODE_A] = "A";
            KEY_CODES[KeyEvent.KEYCODE_B] = "B";
            KEY_CODES[KeyEvent.KEYCODE_C] = "C";
            KEY_CODES[KeyEvent.KEYCODE_D] = "D";
            KEY_CODES[KeyEvent.KEYCODE_E] = "E";
            KEY_CODES[KeyEvent.KEYCODE_F] = "F";
            KEY_CODES[KeyEvent.KEYCODE_G] = "G";
            KEY_CODES[KeyEvent.KEYCODE_H] = "H";
            KEY_CODES[KeyEvent.KEYCODE_I] = "I";
            KEY_CODES[KeyEvent.KEYCODE_J] = "J";
            KEY_CODES[KeyEvent.KEYCODE_K] = "K";
            KEY_CODES[KeyEvent.KEYCODE_L] = "L";
            KEY_CODES[KeyEvent.KEYCODE_M] = "M";
            KEY_CODES[KeyEvent.KEYCODE_N] = "N";
            KEY_CODES[KeyEvent.KEYCODE_O] = "O";
            KEY_CODES[KeyEvent.KEYCODE_P] = "P";
            KEY_CODES[KeyEvent.KEYCODE_Q] = "Q";
            KEY_CODES[KeyEvent.KEYCODE_R] = "R";
            KEY_CODES[KeyEvent.KEYCODE_S] = "S";
            KEY_CODES[KeyEvent.KEYCODE_T] = "T";
            KEY_CODES[KeyEvent.KEYCODE_U] = "U";
            KEY_CODES[KeyEvent.KEYCODE_V] = "V";
            KEY_CODES[KeyEvent.KEYCODE_W] = "W";
            KEY_CODES[KeyEvent.KEYCODE_X] = "X";
            KEY_CODES[KeyEvent.KEYCODE_Y] = "Y";
            KEY_CODES[KeyEvent.KEYCODE_Z] = "Z";
            KEY_CODES[KeyEvent.KEYCODE_COMMA] = ",";
            KEY_CODES[KeyEvent.KEYCODE_PERIOD] = ".";
            KEY_CODES[KeyEvent.KEYCODE_ALT_LEFT] = "AltLeft";
            KEY_CODES[KeyEvent.KEYCODE_ALT_RIGHT] = "AltRight";
            KEY_CODES[KeyEvent.KEYCODE_SHIFT_LEFT] = "ShiftLeft";
            KEY_CODES[KeyEvent.KEYCODE_SHIFT_RIGHT] = "ShiftRight";
            KEY_CODES[KeyEvent.KEYCODE_TAB] = "Tab";
            KEY_CODES[KeyEvent.KEYCODE_SPACE] = "Space";
            KEY_CODES[KeyEvent.KEYCODE_SYM] = "Symbol";
            KEY_CODES[KeyEvent.KEYCODE_EXPLORER] = "Explorer";
            KEY_CODES[KeyEvent.KEYCODE_ENVELOPE] = "Envelope";
            KEY_CODES[KeyEvent.KEYCODE_ENTER] = "Enter";
            KEY_CODES[KeyEvent.KEYCODE_DEL] = "Backspace";
            KEY_CODES[KeyEvent.KEYCODE_GRAVE] = "`";
            KEY_CODES[KeyEvent.KEYCODE_MINUS] = "-";
            KEY_CODES[KeyEvent.KEYCODE_EQUALS] = "=";
            KEY_CODES[KeyEvent.KEYCODE_LEFT_BRACKET] = "[";
            KEY_CODES[KeyEvent.KEYCODE_RIGHT_BRACKET] = "]";
            KEY_CODES[KeyEvent.KEYCODE_BACKSLASH] = "\\";
            KEY_CODES[KeyEvent.KEYCODE_SEMICOLON] = ";";
            KEY_CODES[KeyEvent.KEYCODE_APOSTROPHE] = "'";
            KEY_CODES[KeyEvent.KEYCODE_SLASH] = "/";
            KEY_CODES[KeyEvent.KEYCODE_AT] = "@";
            KEY_CODES[KeyEvent.KEYCODE_NUM] = "Num";
            KEY_CODES[KeyEvent.KEYCODE_HEADSETHOOK] = "HeadsetHool";
            KEY_CODES[KeyEvent.KEYCODE_FOCUS] = "Focus";
            KEY_CODES[KeyEvent.KEYCODE_PLUS] = "+";
            KEY_CODES[KeyEvent.KEYCODE_MENU] = "Menu";
            KEY_CODES[KeyEvent.KEYCODE_NOTIFICATION] = "Notification";
            KEY_CODES[KeyEvent.KEYCODE_SEARCH] = "Search";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_PLAY_PAUSE] = "MediaPlayPause";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_STOP] = "MediaStop";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_NEXT] = "MediaNext";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_PREVIOUS] = "MediaPrevious";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_REWIND] = "MediaRewind";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_FAST_FORWARD] = "MediaFastForward";
            KEY_CODES[KeyEvent.KEYCODE_MUTE] = "Mute";
            KEY_CODES[KeyEvent.KEYCODE_PAGE_UP] = "PageUp";
            KEY_CODES[KeyEvent.KEYCODE_PAGE_DOWN] = "PageDown";
            KEY_CODES[KeyEvent.KEYCODE_PICTSYMBOLS] = "PictureSymbols";
            KEY_CODES[KeyEvent.KEYCODE_SWITCH_CHARSET] = "SwitchCharset";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_A] = "ButtonA";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_B] = "ButtonB";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_C] = "ButtonC";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_X] = "ButtonX";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_Y] = "ButtonY";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_Z] = "ButtonZ";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_L1] = "ButtonL1";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_R1] = "ButtonR1";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_L2] = "ButtonL2";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_R2] = "ButtonR2";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_THUMBL] = "ButtonThumbLeft";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_THUMBR] = "ButtonThumbRight";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_START] = "ButtonStart";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_SELECT] = "ButtonSelect";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_MODE] = "ButtonMode";
            KEY_CODES[KeyEvent.KEYCODE_ESCAPE] = "Escape";
            KEY_CODES[KeyEvent.KEYCODE_FORWARD_DEL] = "Delete";
            KEY_CODES[KeyEvent.KEYCODE_CTRL_LEFT] = "CtrlLeft";
            KEY_CODES[KeyEvent.KEYCODE_CTRL_RIGHT] = "CtrlRight";
            KEY_CODES[KeyEvent.KEYCODE_CAPS_LOCK] = "CapsLock";
            KEY_CODES[KeyEvent.KEYCODE_SCROLL_LOCK] = "ScrollLock";
            KEY_CODES[KeyEvent.KEYCODE_META_LEFT] = "MetaLeft";
            KEY_CODES[KeyEvent.KEYCODE_META_RIGHT] = "MetaRight";
            KEY_CODES[KeyEvent.KEYCODE_FUNCTION] = "Function";
            KEY_CODES[KeyEvent.KEYCODE_SYSRQ] = "PrintScreen";
            KEY_CODES[KeyEvent.KEYCODE_BREAK] = "Break";
            KEY_CODES[KeyEvent.KEYCODE_MOVE_HOME] = "Home";
            KEY_CODES[KeyEvent.KEYCODE_MOVE_END] = "End";
            KEY_CODES[KeyEvent.KEYCODE_INSERT] = "Insert";
            KEY_CODES[KeyEvent.KEYCODE_FORWARD] = "Forward";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_PLAY] = "MediaPlay";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_PAUSE] = "MediaPause";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_CLOSE] = "MediaClose";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_EJECT] = "MediaEject";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_RECORD] = "MediaRecord";
            KEY_CODES[KeyEvent.KEYCODE_F1] = "F1";
            KEY_CODES[KeyEvent.KEYCODE_F2] = "F2";
            KEY_CODES[KeyEvent.KEYCODE_F3] = "F3";
            KEY_CODES[KeyEvent.KEYCODE_F4] = "F4";
            KEY_CODES[KeyEvent.KEYCODE_F5] = "F5";
            KEY_CODES[KeyEvent.KEYCODE_F6] = "F6";
            KEY_CODES[KeyEvent.KEYCODE_F7] = "F7";
            KEY_CODES[KeyEvent.KEYCODE_F8] = "F8";
            KEY_CODES[KeyEvent.KEYCODE_F9] = "F9";
            KEY_CODES[KeyEvent.KEYCODE_F10] = "F10";
            KEY_CODES[KeyEvent.KEYCODE_F11] = "F11";
            KEY_CODES[KeyEvent.KEYCODE_F12] = "F12";
            KEY_CODES[KeyEvent.KEYCODE_NUM_LOCK] = "NumLock";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_0] = "NumPad0";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_1] = "NumPad1";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_2] = "NumPad2";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_3] = "NumPad3";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_4] = "NumPad4";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_5] = "NumPad5";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_6] = "NumPad6";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_7] = "NumPad7";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_8] = "NumPad8";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_9] = "NumPad9";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_DIVIDE] = "NumPad/";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_MULTIPLY] = "NumPad*";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_SUBTRACT] = "NumPad-";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_ADD] = "NumPad+";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_DOT] = "NumPad.";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_COMMA] = "NumPad,";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_ENTER] = "NumPadEnter";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_EQUALS] = "NumPad=";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_LEFT_PAREN] = "NumPad(";
            KEY_CODES[KeyEvent.KEYCODE_NUMPAD_RIGHT_PAREN] = "NumPad)";
            KEY_CODES[KeyEvent.KEYCODE_VOLUME_MUTE] = "VolumeMute";
            KEY_CODES[KeyEvent.KEYCODE_INFO] = "Info";
            KEY_CODES[KeyEvent.KEYCODE_CHANNEL_UP] = "ChannelUp";
            KEY_CODES[KeyEvent.KEYCODE_CHANNEL_DOWN] = "ChannelDown";
            KEY_CODES[KeyEvent.KEYCODE_ZOOM_IN] = "ZoomIn";
            KEY_CODES[KeyEvent.KEYCODE_ZOOM_OUT] = "ZoomOut";
            KEY_CODES[KeyEvent.KEYCODE_TV] = "TV";
            KEY_CODES[KeyEvent.KEYCODE_WINDOW] = "Window";
            KEY_CODES[KeyEvent.KEYCODE_GUIDE] = "Guide";
            KEY_CODES[KeyEvent.KEYCODE_DVR] = "DVR";
            KEY_CODES[KeyEvent.KEYCODE_BOOKMARK] = "Bookmark";
            KEY_CODES[KeyEvent.KEYCODE_CAPTIONS] = "Captions";
            KEY_CODES[KeyEvent.KEYCODE_SETTINGS] = "Settings";
            KEY_CODES[KeyEvent.KEYCODE_TV_POWER] = "TVPower";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT] = "TVInput";
            KEY_CODES[KeyEvent.KEYCODE_STB_POWER] = "STBPower";
            KEY_CODES[KeyEvent.KEYCODE_STB_INPUT] = "STBInput";
            KEY_CODES[KeyEvent.KEYCODE_AVR_POWER] = "AVRPower";
            KEY_CODES[KeyEvent.KEYCODE_AVR_INPUT] = "AVRInput";
            KEY_CODES[KeyEvent.KEYCODE_PROG_RED] = "ProgrammableRed";
            KEY_CODES[KeyEvent.KEYCODE_PROG_GREEN] = "ProgrammableGreen";
            KEY_CODES[KeyEvent.KEYCODE_PROG_YELLOW] = "ProgrammableYellow";
            KEY_CODES[KeyEvent.KEYCODE_PROG_BLUE] = "ProgrammableBlue";
            KEY_CODES[KeyEvent.KEYCODE_APP_SWITCH] = "AppSwitch";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_1] = "Button1";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_2] = "Button2";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_3] = "Button3";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_4] = "Button4";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_5] = "Button5";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_6] = "Button6";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_7] = "Button7";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_8] = "Button8";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_9] = "Button9";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_10] = "Button10";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_11] = "Button11";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_12] = "Button12";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_13] = "Button13";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_14] = "Button14";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_15] = "Button15";
            KEY_CODES[KeyEvent.KEYCODE_BUTTON_16] = "Button16";
            KEY_CODES[KeyEvent.KEYCODE_LANGUAGE_SWITCH] = "LanguageSwitch";
            KEY_CODES[KeyEvent.KEYCODE_MANNER_MODE] = "MannerMode";
            KEY_CODES[KeyEvent.KEYCODE_3D_MODE] = "3DMode";
            KEY_CODES[KeyEvent.KEYCODE_CONTACTS] = "Contacts";
            KEY_CODES[KeyEvent.KEYCODE_CALENDAR] = "Calendar";
            KEY_CODES[KeyEvent.KEYCODE_MUSIC] = "Music";
            KEY_CODES[KeyEvent.KEYCODE_CALCULATOR] = "Calculator";
            KEY_CODES[KeyEvent.KEYCODE_ZENKAKU_HANKAKU] = "ZenkakuHankaku";
            KEY_CODES[KeyEvent.KEYCODE_EISU] = "Eisu";
            KEY_CODES[KeyEvent.KEYCODE_MUHENKAN] = "Muhenkan";
            KEY_CODES[KeyEvent.KEYCODE_HENKAN] = "Henkan";
            KEY_CODES[KeyEvent.KEYCODE_KATAKANA_HIRAGANA] = "KatakanaHiragana";
            KEY_CODES[KeyEvent.KEYCODE_YEN] = "Yen";
            KEY_CODES[KeyEvent.KEYCODE_RO] = "Ro";
            KEY_CODES[KeyEvent.KEYCODE_KANA] = "Kana";
            KEY_CODES[KeyEvent.KEYCODE_ASSIST] = "Assist";
            KEY_CODES[KeyEvent.KEYCODE_BRIGHTNESS_DOWN] = "BrightnessDown";
            KEY_CODES[KeyEvent.KEYCODE_BRIGHTNESS_UP] = "BrightnessUp";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_AUDIO_TRACK] = "MediaAudioTrack";
            KEY_CODES[KeyEvent.KEYCODE_SLEEP] = "Sleep";
            KEY_CODES[KeyEvent.KEYCODE_WAKEUP] = "WakeUp";
            KEY_CODES[KeyEvent.KEYCODE_PAIRING] = "Pairing";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_TOP_MENU] = "MediaTopMenu";
            KEY_CODES[KeyEvent.KEYCODE_11] = "11";
            KEY_CODES[KeyEvent.KEYCODE_12] = "12";
            KEY_CODES[KeyEvent.KEYCODE_LAST_CHANNEL] = "LastChannel";
            KEY_CODES[KeyEvent.KEYCODE_TV_DATA_SERVICE] = "TVDataService";
            KEY_CODES[KeyEvent.KEYCODE_VOICE_ASSIST] = "VoiceAssist";
            KEY_CODES[KeyEvent.KEYCODE_TV_RADIO_SERVICE] = "TVRadioService";
            KEY_CODES[KeyEvent.KEYCODE_TV_TELETEXT] = "TVTeletext";
            KEY_CODES[KeyEvent.KEYCODE_TV_NUMBER_ENTRY] = "TVNumberEntry";
            KEY_CODES[KeyEvent.KEYCODE_TV_TERRESTRIAL_ANALOG] = "TVTerrestrialAnalog";
            KEY_CODES[KeyEvent.KEYCODE_TV_TERRESTRIAL_DIGITAL] = "TVTerrestrialDigital";
            KEY_CODES[KeyEvent.KEYCODE_TV_SATELLITE] = "TVSatellite";
            KEY_CODES[KeyEvent.KEYCODE_TV_SATELLITE_BS] = "TVSatelliteBS";
            KEY_CODES[KeyEvent.KEYCODE_TV_SATELLITE_CS] = "TVSatelliteCS";
            KEY_CODES[KeyEvent.KEYCODE_TV_SATELLITE_SERVICE] = "TVSatelliteService";
            KEY_CODES[KeyEvent.KEYCODE_TV_NETWORK] = "TVNetwork";
            KEY_CODES[KeyEvent.KEYCODE_TV_ANTENNA_CABLE] = "TVAntennaCable";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT_HDMI_1] = "TVInputHDMI1";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT_HDMI_2] = "TVInputHDMI2";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT_HDMI_3] = "TVInputHDMI3";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT_HDMI_4] = "TVInputHDMI4";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT_COMPOSITE_1] = "TVInputComposite1";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT_COMPOSITE_2] = "TVInputComposite1";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT_COMPONENT_1] = "TVInputComponent1";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT_COMPONENT_2] = "TVInputComponent2";
            KEY_CODES[KeyEvent.KEYCODE_TV_INPUT_VGA_1] = "TVInputVGA1";
            KEY_CODES[KeyEvent.KEYCODE_TV_AUDIO_DESCRIPTION] = "TVAudioDescription";
            KEY_CODES[KeyEvent.KEYCODE_TV_AUDIO_DESCRIPTION_MIX_UP] = "TVAudioDescriptionMixUp";
            KEY_CODES[KeyEvent.KEYCODE_TV_AUDIO_DESCRIPTION_MIX_DOWN] = "TVAudioDescriptionMixDown";
            KEY_CODES[KeyEvent.KEYCODE_TV_ZOOM_MODE] = "TVZoomMode";
            KEY_CODES[KeyEvent.KEYCODE_TV_CONTENTS_MENU] = "TVContentsMenu";
            KEY_CODES[KeyEvent.KEYCODE_TV_MEDIA_CONTEXT_MENU] = "TVMediaContextMenu";
            KEY_CODES[KeyEvent.KEYCODE_TV_TIMER_PROGRAMMING] = "TVTimerProgramming";
            KEY_CODES[KeyEvent.KEYCODE_HELP] = "Help";
            KEY_CODES[KeyEvent.KEYCODE_NAVIGATE_PREVIOUS] = "NavigatePrevious";
            KEY_CODES[KeyEvent.KEYCODE_NAVIGATE_NEXT] = "NavigateNext";
            KEY_CODES[KeyEvent.KEYCODE_NAVIGATE_IN] = "NavigateIn";
            KEY_CODES[KeyEvent.KEYCODE_NAVIGATE_OUT] = "NavigateOut";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_SKIP_FORWARD] = "MediaSkipForward";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_SKIP_BACKWARD] = "MediaSkipBackward";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_STEP_FORWARD] = "MediaStepForward";
            KEY_CODES[KeyEvent.KEYCODE_MEDIA_STEP_BACKWARD] = "MediaStepBackward";
        } catch(ArrayIndexOutOfBoundsException err){
        }
    }

    public static void register() {
        APP.getClient().onAction(InAction.DEVICE_LOG, new StringActionHandler() {
            @Override
            public void accept(String value) {
                APP.getRenderer().getDevice().log(value);
            }
        });

        APP.getClient().onAction(InAction.DEVICE_SHOW_KEYBOARD, new NoArgsActionHandler() {
            @Override
            public void accept() {
                APP.getRenderer().getDevice().showKeyboard();
            }
        });

        APP.getClient().onAction(InAction.DEVICE_HIDE_KEYBOARD, new NoArgsActionHandler() {
            @Override
            public void accept() {
                APP.getRenderer().getDevice().hideKeyboard();
            }
        });
    }

    @Getter private float pixelRatio;
    private boolean isPhone;
    private boolean keyboardVisible = false;

    private KeyboardText keyboardText;

    static void init(final Device device) {
        // create EditText to handle KeyInput
        device.keyboardText = new KeyboardText(APP.getActivity().getApplicationContext());
        final Window window = APP.getActivity().getWindow();
        APP.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                APP.getWindowView().getLocationOnScreen(VIEW_LOCATION);
                APP.getWindowView().addView(device.keyboardText);

                // hide keyboard
                window.setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);
            }
        });

        Resources resources = APP.getActivity().getResources();

        // DEVICE_PIXEL_RATIO
        final DisplayMetrics metrics = resources.getDisplayMetrics();
        device.pixelRatio = metrics.density;
        APP.getClient().pushAction(OutAction.DEVICE_PIXEL_RATIO, device.pixelRatio);

        // DEVICE_IS_PHONE
        device.isPhone = (resources.getConfiguration().screenLayout
                & Configuration.SCREENLAYOUT_SIZE_MASK)
                >= Configuration.SCREENLAYOUT_SIZE_LARGE;
        APP.getClient().pushAction(OutAction.DEVICE_IS_PHONE, device.isPhone);
    }

    void log(String val){
        Log.i("Neft", val);
    }

    void showKeyboard(){
        APP.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                InputMethodManager imm = (InputMethodManager) APP.getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
                imm.toggleSoftInputFromWindow(APP.getWindowView().getWindowToken(), InputMethodManager.SHOW_FORCED, 0);
                keyboardText.requestFocus();
            }
        });

        this.keyboardVisible = true;
        APP.getClient().pushAction(OutAction.DEVICE_KEYBOARD_SHOW);
    }

    private void hideKeyboard(){
        APP.getActivity().runOnUiThread(new Runnable() {
            @Override
            public void run() {
                InputMethodManager imm = (InputMethodManager) APP.getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
                imm.hideSoftInputFromWindow(APP.getWindowView().getWindowToken(), 0);
                keyboardText.clearFocus();
                keyboardText.setText(null);
            }
        });

        this.keyboardVisible = false;
        APP.getClient().pushAction(OutAction.DEVICE_KEYBOARD_HIDE);
    }

    public void onTouchEvent(MotionEvent event){
        OutAction action = TOUCH_EVENTS_MAPPING.get(event.getAction());
        if (action != null) {
            float x = (event.getRawX() - VIEW_LOCATION[0]) / pixelRatio;
            float y = (event.getRawY() - VIEW_LOCATION[1]) / pixelRatio;
            APP.getClient().pushAction(action, x, y);
        }
    }

    public void onKeyEvent(int keyCode, KeyEvent event){
        // hide keyboard
        if (keyboardVisible && (keyCode & (KeyEvent.KEYCODE_BACK | KeyEvent.KEYCODE_ENTER)) > 0) {
            this.hideKeyboard();
        }

        OutAction action = KEY_EVENTS_MAPPING.get(event.getAction());
        if (action != null) {
            String actionKeyCode = KEY_CODES[keyCode];
            APP.getClient().pushAction(action, actionKeyCode);
        }
    }
}
