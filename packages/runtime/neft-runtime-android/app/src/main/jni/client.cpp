#include <jni.h>
#include <vector>
#include "include/v8.h"
#include "android/log.h"

#include "js.cpp"
#include "java.cpp"

#include <iostream>
#include <sstream>
#include <string>
using namespace std;

using namespace v8;

namespace client {
    static jobject jniObj = NULL;
    static jmethodID jniOnData = NULL;

    static Persistent<Function, CopyablePersistentTraits<Function>> updateViewCallback;

    static Persistent<Array, CopyablePersistentTraits<Array>> outActions;
    static Persistent<Array, CopyablePersistentTraits<Array>> outBooleans;
    static Persistent<Array, CopyablePersistentTraits<Array>> outIntegers;
    static Persistent<Array, CopyablePersistentTraits<Array>> outFloats;
    static Persistent<Array, CopyablePersistentTraits<Array>> outStrings;

    void onData(const FunctionCallbackInfo<Value>& args) {
        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        Local<Function> callback = Local<Function>::Cast(args[0]);
        Persistent<Function, CopyablePersistentTraits<Function>> value(isolate, callback);
        client::updateViewCallback = value;
    }

    void transferData(const FunctionCallbackInfo<Value>& args) {
        JNIEnv *jniEnv = Java::GetEnv();

        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        Local<Context> context = Local<Context>::New(isolate, JS::GetContext());
        Context::Scope context_scope(context);

        // actions
        jbyteArray outActions;
        jbyte* outActionsFill;
        {
            Local<Array> array = Local<Array>::Cast(args[0]);
            const int length = args[1]->Int32Value(context).ToChecked();
            outActions = jniEnv->NewByteArray(length);
            outActionsFill = new jbyte[length];
            for (int i = 0; i < length; i++) {
                outActionsFill[i] = array->Get(context, i).ToLocalChecked()->Uint32Value(context).ToChecked();
            }
            jniEnv->SetByteArrayRegion(outActions, 0, length, outActionsFill);
        }

        // booleans
        jbooleanArray outBooleans;
        jboolean* outBooleansFill;
        {
            Local<Array> array = Local<Array>::Cast(args[2]);
            const int length = args[3]->Int32Value(context).ToChecked();
            outBooleans = jniEnv->NewBooleanArray(length);
            outBooleansFill = new jboolean[length];
            for (int i = 0; i < length; i++) {
                outBooleansFill[i] = array->Get(context, i).ToLocalChecked()->BooleanValue(isolate);
            }
            jniEnv->SetBooleanArrayRegion(outBooleans, 0, length, outBooleansFill);
        }

        // ints
        jintArray outInts;
        jint* outIntsFill;
        {
            Local<Array> array = Local<Array>::Cast(args[4]);
            const int length = args[5]->Int32Value(context).ToChecked();
            outInts = jniEnv->NewIntArray(length);
            outIntsFill = new jint[length];
            for (int i = 0; i < length; i++) {
                outIntsFill[i] = array->Get(context, i).ToLocalChecked()->Uint32Value(context).ToChecked();
            }
            jniEnv->SetIntArrayRegion(outInts, 0, length, outIntsFill);
        }

        // floats
        jfloatArray outFloats;
        jfloat* outFloatsFill;
        {
            Local<Array> array = Local<Array>::Cast(args[6]);
            const int length = args[7]->Int32Value(context).ToChecked();
            outFloats = jniEnv->NewFloatArray(length);
            outFloatsFill = new jfloat[length];
            for (int i = 0; i < length; i++) {
                outFloatsFill[i] = array->Get(context, i).ToLocalChecked()->NumberValue(context).ToChecked();
            }
            jniEnv->SetFloatArrayRegion(outFloats, 0, length, outFloatsFill);
        }

        // strings
        jobjectArray outStrings;
        {
            Local<Array> array = Local<Array>::Cast(args[8]);
            const int length = args[9]->Int32Value(context).ToChecked();
            outStrings = jniEnv->NewObjectArray(length, jniEnv->FindClass("java/lang/String"), jniEnv->NewStringUTF(""));
            for (int i = 0; i < length; i++) {
                String::Utf8Value string(isolate, array->Get(context, i).ToLocalChecked()->ToString(context).ToLocalChecked());
                jstring stringUtf = jniEnv->NewStringUTF(*string);
                jniEnv->SetObjectArrayElement(outStrings, i, stringUtf);
                jniEnv->DeleteLocalRef(stringUtf);
            }
        }

        // transfer data
        jniEnv->CallVoidMethod(jniObj, jniOnData, outActions, outBooleans, outInts, outFloats, outStrings);

        // clear
        jniEnv->DeleteLocalRef(outActions);
        jniEnv->DeleteLocalRef(outBooleans);
        jniEnv->DeleteLocalRef(outInts);
        jniEnv->DeleteLocalRef(outFloats);
        jniEnv->DeleteLocalRef(outStrings);
    }

    int main(){
        Isolate *isolate = JS::GetIsolate();
        Locker locker(isolate);
        Isolate::Scope isolate_scope(isolate);
        HandleScope handle_scope(isolate);

        Local<Context> context = Local<Context>::New(isolate, JS::GetContext());
        Context::Scope context_scope(context);

        Persistent<Object, CopyablePersistentTraits<Object>> jsObject;
        jsObject = JS::CreateObject(JS::GetGlobalNeftObject(), "native");
        JS::LinkFunction(jsObject, "transferData", client::transferData);
        JS::LinkFunction(jsObject, "onData", client::onData);

        outActions.Reset(isolate, Array::New(isolate, 0));
        outBooleans.Reset(isolate, Array::New(isolate, 0));
        outIntegers.Reset(isolate, Array::New(isolate, 0));
        outFloats.Reset(isolate, Array::New(isolate, 0));
        outStrings.Reset(isolate, Array::New(isolate, 0));
        return 0;
    }
}

extern "C" void Java_io_neft_Native_client_1init(JNIEnv * env, jobject obj, jobject clientObj) {
    jclass jniClass = (jclass) env->GetObjectClass(clientObj);
    client::jniObj = env->NewGlobalRef(clientObj);
    client::jniOnData = env->GetMethodID(jniClass, "onData", "([B[Z[I[F[Ljava/lang/String;)V");
}

extern "C" void Java_io_neft_Native_client_1sendData(JNIEnv * env, jobject obj,
                                                     jbyteArray actions, jint actionsLength,
                                                     jbooleanArray booleans, jint booleansLength,
                                                     jintArray integers, jint integersLength,
                                                     jfloatArray floats, jint floatsLength,
                                                     jobjectArray strings, jint stringsLength) {
    using namespace client;

    Isolate *isolate = JS::GetIsolate();
    Locker locker(isolate);
    Isolate::Scope isolate_scope(isolate);
    HandleScope handle_scope(isolate);

    Local<Context> context = Local<Context>::New(isolate, JS::GetContext());
    Context::Scope context_scope(context);

    // actions
    Local<Array> localOutActions = Local<Array>::New(isolate, outActions);
    jbyte *actionsArr = env->GetByteArrayElements(actions, 0);
    for (int i = 0; i < actionsLength; i++) {
        (void) localOutActions->Set(context, i, Integer::New(isolate, actionsArr[i]));
    }
    (void) localOutActions->Set(context, String::NewFromUtf8(isolate, "length", NewStringType::kNormal).ToLocalChecked(), Integer::New(isolate, actionsLength));
    env->ReleaseByteArrayElements(actions, actionsArr, 0);

    // booleans
    jboolean *booleansArr = env->GetBooleanArrayElements(booleans, 0);
    Local<Array> localOutBooleans = Local<Array>::New(isolate, outBooleans);
    for (int i = 0; i < booleansLength; i++) {
        (void) localOutBooleans->Set(context, i, Boolean::New(isolate, booleansArr[i]));
    }
    env->ReleaseBooleanArrayElements(booleans, booleansArr, 0);

    // integers
    jint *integersArr = env->GetIntArrayElements(integers, 0);
    Local<Array> localOutIntegers = Local<Array>::New(isolate, outIntegers);
    for (int i = 0; i < integersLength; i++) {
        (void) localOutIntegers->Set(context, i, Integer::New(isolate, integersArr[i]));
    }
    env->ReleaseIntArrayElements(integers, integersArr, 0);

    // floats
    jfloat *floatsArr = env->GetFloatArrayElements(floats, 0);
    Local<Array> localOutFloats = Local<Array>::New(isolate, outFloats);
    for (int i = 0; i < floatsLength; i++) {
        (void) localOutFloats->Set(context, i, Number::New(isolate, floatsArr[i]));
    }
    env->ReleaseFloatArrayElements(floats, floatsArr, 0);

    // strings
    Local<Array> localOutStrings = Local<Array>::New(isolate, outStrings);
    for (int i = 0; i < stringsLength; i++) {
        jobject stringUtfObject = env->GetObjectArrayElement(strings, i);
        jstring stringUtf = (jstring) stringUtfObject;
        const char *stringUtfChar = env->GetStringUTFChars(stringUtf, 0);
        (void) localOutStrings->Set(context, i, String::NewFromUtf8(isolate, stringUtfChar, NewStringType::kNormal).ToLocalChecked());
        env->ReleaseStringUTFChars(stringUtf, stringUtfChar);
        env->DeleteLocalRef(stringUtfObject);
    }

    // Get local function
    Local<Function> local = Local<Function>::New(isolate, updateViewCallback);

    // Call function
    const unsigned argc = 5;
    Local<Value> argv[argc] = {localOutActions, localOutBooleans, localOutIntegers,
                               localOutFloats, localOutStrings};
    (void) local->Call(context, Null(isolate), argc, argv);
}