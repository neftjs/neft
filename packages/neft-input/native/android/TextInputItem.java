package io.neft.extensions.input_extension;

import android.content.Context;
import android.graphics.Color;
import android.text.Editable;
import android.text.InputType;
import android.text.TextWatcher;
import android.util.Log;
import android.view.inputmethod.EditorInfo;
import android.view.inputmethod.InputMethodManager;
import android.widget.EditText;
import io.neft.renderer.NativeItem;
import io.neft.renderer.annotation.OnCall;
import io.neft.renderer.annotation.OnCreate;
import io.neft.renderer.annotation.OnSet;
import io.neft.utils.ColorValue;

import java.util.HashMap;
import java.util.Map;

public class TextInputItem extends NativeItem {
    private static final Map<String, Integer> KEYBOARD_TYPES = new HashMap<>();
    private static final Map<String, Integer> KEY_TYPES = new HashMap<>();

    static {
        KEYBOARD_TYPES.put("text", InputType.TYPE_CLASS_TEXT);
        KEYBOARD_TYPES.put("numeric", InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_DECIMAL);
        KEYBOARD_TYPES.put("email", InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_EMAIL_ADDRESS);
        KEYBOARD_TYPES.put("tel", InputType.TYPE_CLASS_PHONE);

        KEY_TYPES.put("done", EditorInfo.IME_ACTION_DONE);
        KEY_TYPES.put("go", EditorInfo.IME_ACTION_GO);
        KEY_TYPES.put("next", EditorInfo.IME_ACTION_NEXT);
        KEY_TYPES.put("search", EditorInfo.IME_ACTION_SEARCH);
        KEY_TYPES.put("send", EditorInfo.IME_ACTION_SEND);
        KEY_TYPES.put(null, EditorInfo.IME_ACTION_UNSPECIFIED);
    }

    int keyboardTypeMod;
    int multilineMod;
    boolean secureTextEntry;

    @OnCreate("TextInput")
    public TextInputItem() {
        super(new EditText(APP.getActivity().getApplicationContext()));
        EditText itemView = getItemView();
        itemView.setBackground(null);
        itemView.setPadding(0, 0, 0, 0);

        setTextColor(new ColorValue(Color.BLACK));

        itemView.addTextChangedListener(new TextWatcher() {
            @Override
            public void beforeTextChanged(CharSequence s, int start, int count, int after) {}

            @Override
            public void onTextChanged(CharSequence s, int start, int before, int count) {
                pushEvent("textChange", getItemView().getText().toString());
            }

            @Override
            public void afterTextChanged(Editable s) {}
        });

        setKeyboardType("text");
        setMultiline(false);
        setReturnKeyType(null);
        setSecureTextEntry(false);
    }

    private EditText getItemView() {
        return (EditText) itemView;
    }

    private void updateInputType() {
        int secureTextEntryMod = 0;
        if (secureTextEntry) {
            if ((keyboardTypeMod & InputType.TYPE_CLASS_NUMBER) > 0) {
                secureTextEntryMod = InputType.TYPE_NUMBER_VARIATION_PASSWORD;
            } else {
                secureTextEntryMod = InputType.TYPE_TEXT_VARIATION_PASSWORD;
            }
        }
        getItemView().setInputType(keyboardTypeMod | multilineMod | secureTextEntryMod);
    }

    @OnSet("text")
    public void setText(String val) {
        getItemView().setText(val);
        updateSize();
    }

    @OnSet("textColor")
    public void setTextColor(ColorValue val) {
        getItemView().setTextColor(val.getColor());
    }

    @OnSet("placeholder")
    public void setPlaceholder(String val) {
        getItemView().setHint(val);
    }

    @OnSet("placeholderColor")
    public void setPlaceholderColor(ColorValue val) {
        getItemView().setHintTextColor(val.getColor());
    }

    @OnSet("keyboardType")
    public void setKeyboardType(String keyboardType) {
        Integer val = KEYBOARD_TYPES.get(keyboardType);
        if (val == null) {
            Log.w("Neft", "Unknown TextInput keyboardType " + keyboardType);
            val = InputType.TYPE_CLASS_TEXT;
        }
        keyboardTypeMod = val;
        updateInputType();
    }

    @OnSet("multiline")
    public void setMultiline(boolean multiline) {
        multilineMod = multiline ? InputType.TYPE_TEXT_FLAG_MULTI_LINE : 0;
        updateInputType();
    }

    @OnSet("returnKeyType")
    public void setReturnKeyType(String keyType) {
        Integer val = KEY_TYPES.get(keyType);
        if (val == null) {
            Log.w("Neft", "Unknown TextInput returnKeyType " + keyType);
            val = EditorInfo.IME_ACTION_UNSPECIFIED;
        }
        getItemView().setImeOptions(val);
    }

    @OnSet("secureTextEntry")
    public void setSecureTextEntry(boolean val) {
        secureTextEntry = val;
        updateInputType();
    }

    @OnCall("focus")
    public void focus() {
        EditText itemView = getItemView();
        itemView.requestFocusFromTouch();
        InputMethodManager manager = (InputMethodManager) APP.getActivity().getSystemService(Context.INPUT_METHOD_SERVICE);
        manager.showSoftInput(itemView, 0);
    }
}
