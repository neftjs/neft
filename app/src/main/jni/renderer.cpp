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

namespace renderer {
    static jobject jniObj = NULL;
    static jmethodID jniUpdateView = NULL;

    static vector<Persistent<Function, CopyablePersistentTraits<Function>>> animationFrameCalls;
    static Persistent<Function, CopyablePersistentTraits<Function>> updateViewCallback;

    static Persistent<Array, CopyablePersistentTraits<Array>> outActions;
    static Persistent<Array, CopyablePersistentTraits<Array>> outBooleans;
    static Persistent<Array, CopyablePersistentTraits<Array>> outIntegers;
    static Persistent<Array, CopyablePersistentTraits<Array>> outFloats;
    static Persistent<Array, CopyablePersistentTraits<Array>> outStrings;

    void requestAnimationFrame(const FunctionCallbackInfo<Value>& args) {
        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        Local<Function> callback = Local<Function>::Cast(args[0]);
        Persistent<Function, CopyablePersistentTraits<Function>> value(isolate, callback);

        animationFrameCalls.push_back(value);
    }

    void onUpdateView(const FunctionCallbackInfo<Value>& args) {
        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        Local<Function> callback = Local<Function>::Cast(args[0]);
        Persistent<Function, CopyablePersistentTraits<Function>> value(isolate, callback);
        renderer::updateViewCallback = value;
    }

    void transferData(const FunctionCallbackInfo<Value>& args) {
        JNIEnv *jniEnv = Java::GetEnv();

        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        // actions
        jbyteArray outActions;
        jbyte* outActionsFill;
        {
            Local<Array> array = Local<Array>::Cast(args[0]);
            const int length = args[1]->Int32Value();
            outActions = jniEnv->NewByteArray(length);
            outActionsFill = new jbyte[length];
            for (int i = 0; i < length; i++) {
                outActionsFill[i] = array->Get(i)->Uint32Value();
            }
            jniEnv->SetByteArrayRegion(outActions, 0, length, outActionsFill);
        }

        // booleans
        jbooleanArray outBooleans;
        jboolean* outBooleansFill;
        {
            Local<Array> array = Local<Array>::Cast(args[2]);
            const int length = args[3]->Int32Value();
            outBooleans = jniEnv->NewBooleanArray(length);
            outBooleansFill = new jboolean[length];
            for (int i = 0; i < length; i++) {
                outBooleansFill[i] = array->Get(i)->BooleanValue();
            }
            jniEnv->SetBooleanArrayRegion(outBooleans, 0, length, outBooleansFill);
        }

        // ints
        jintArray outInts;
        jint* outIntsFill;
        {
            Local<Array> array = Local<Array>::Cast(args[4]);
            const int length = args[5]->Int32Value();
            outInts = jniEnv->NewIntArray(length);
            outIntsFill = new jint[length];
            for (int i = 0; i < length; i++) {
                outIntsFill[i] = array->Get(i)->Uint32Value();
            }
            jniEnv->SetIntArrayRegion(outInts, 0, length, outIntsFill);
        }

        // floats
        jfloatArray outFloats;
        jfloat* outFloatsFill;
        {
            Local<Array> array = Local<Array>::Cast(args[6]);
            const int length = args[7]->Int32Value();
            outFloats = jniEnv->NewFloatArray(length);
            outFloatsFill = new jfloat[length];
            for (int i = 0; i < length; i++) {
                outFloatsFill[i] = array->Get(i)->NumberValue();
            }
            jniEnv->SetFloatArrayRegion(outFloats, 0, length, outFloatsFill);
        }

        // strings
        jobjectArray outStrings;
        {
            Local<Array> array = Local<Array>::Cast(args[8]);
            const int length = args[9]->Int32Value();
            outStrings = jniEnv->NewObjectArray(length, jniEnv->FindClass("java/lang/String"), jniEnv->NewStringUTF(""));
            for (int i = 0; i < length; i++) {
                jstring stringUtf = jniEnv->NewStringUTF(*String::Utf8Value(array->Get(i)->ToString()));
                jniEnv->SetObjectArrayElement(outStrings, i, stringUtf);
                jniEnv->DeleteLocalRef(stringUtf);
            }
        }

        // transfer data
        jniEnv->CallVoidMethod(jniObj, jniUpdateView, outActions, outBooleans, outInts, outFloats, outStrings);

        // clear
        jniEnv->ReleaseByteArrayElements(outActions, outActionsFill, 0);
        jniEnv->ReleaseBooleanArrayElements(outBooleans, outBooleansFill, 0);
        jniEnv->ReleaseIntArrayElements(outInts, outIntsFill, 0);
        jniEnv->ReleaseFloatArrayElements(outFloats, outFloatsFill, 0);

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
        jsObject = JS::CreateObject(JS::GetGlobalNeftObject(), "renderer");
        JS::LinkFunction(JS::GetGlobal(), "requestAnimationFrame", renderer::requestAnimationFrame);
        JS::LinkFunction(jsObject, "transferData", renderer::transferData);
        JS::LinkFunction(jsObject, "onUpdateView", renderer::onUpdateView);

        outActions.Reset(isolate, Array::New(isolate, 0));
        outBooleans.Reset(isolate, Array::New(isolate, 0));
        outIntegers.Reset(isolate, Array::New(isolate, 0));
        outFloats.Reset(isolate, Array::New(isolate, 0));
        outStrings.Reset(isolate, Array::New(isolate, 0));
        return 0;
    }
}

extern "C" void Java_io_neft_Native_renderer_1init(JNIEnv * env, jobject obj, jobject rendererObj) {
    jclass jniClass = (jclass) env->GetObjectClass(rendererObj);
    renderer::jniObj = env->NewGlobalRef(rendererObj);
    renderer::jniUpdateView = env->GetMethodID(jniClass, "updateView", "([B[Z[I[F[Ljava/lang/String;)V");
}

extern "C" void Java_io_neft_Native_renderer_1callAnimationFrame(JNIEnv * env, jobject obj) {
    using namespace renderer;

    // enter isolate
    Isolate* isolate = JS::GetIsolate();
    Locker locker(isolate);
    Isolate::Scope isolate_scope(isolate);
    HandleScope handle_scope(isolate);

    // get local context and enter it
    Local<Context> context = Local<Context>::New(isolate, JS::GetContext());
    Context::Scope context_scope(context);

    // call all registered functions
    const int length = animationFrameCalls.size();
    for (int i = 0; i < length; i++){
        Persistent<Function, CopyablePersistentTraits<Function>> func = animationFrameCalls[i];

        // get local function
        Local<Function> localFunc = Local<Function>::New(isolate, func);

        // call function
        localFunc->Call(context->Global(), 0, NULL);

        // clear persistent
        func.Reset();
    }

    // remove called functions
    animationFrameCalls.erase(animationFrameCalls.begin(), animationFrameCalls.begin() + length);
}

extern "C" void Java_io_neft_Native_renderer_1updateView(JNIEnv * env, jobject obj,
                                                         jbyteArray actions, jint actionsLength,
                                                         jbooleanArray booleans, jint booleansLength,
                                                         jintArray integers, jint integersLength,
                                                         jfloatArray floats, jint floatsLength,
                                                         jobjectArray strings, jint stringsLength) {
    using namespace renderer;

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
        localOutActions->Set(i, Integer::New(isolate, actionsArr[i]));
    }
    localOutActions->Set(String::NewFromUtf8(isolate, "length"), Integer::New(isolate, actionsLength));
    env->ReleaseByteArrayElements(actions, actionsArr, 0);

    // booleans
    jboolean *booleansArr = env->GetBooleanArrayElements(booleans, 0);
    Local<Array> localOutBooleans = Local<Array>::New(isolate, outBooleans);
    for (int i = 0; i < booleansLength; i++) {
        localOutBooleans->Set(i, Boolean::New(isolate, booleansArr[i]));
    }
    env->ReleaseBooleanArrayElements(booleans, booleansArr, 0);

    // integers
    jint *integersArr = env->GetIntArrayElements(integers, 0);
    Local<Array> localOutIntegers = Local<Array>::New(isolate, outIntegers);
    for (int i = 0; i < integersLength; i++) {
        localOutIntegers->Set(i, Integer::New(isolate, integersArr[i]));
    }
    env->ReleaseIntArrayElements(integers, integersArr, 0);

    // floats
    jfloat *floatsArr = env->GetFloatArrayElements(floats, 0);
    Local<Array> localOutFloats = Local<Array>::New(isolate, outFloats);
    for (int i = 0; i < floatsLength; i++) {
        localOutFloats->Set(i, Number::New(isolate, floatsArr[i]));
    }
    env->ReleaseFloatArrayElements(floats, floatsArr, 0);

    // strings
    Local<Array> localOutStrings = Local<Array>::New(isolate, outStrings);
    for (int i = 0; i < stringsLength; i++) {
        jobject stringUtfObject = env->GetObjectArrayElement(strings, i);
        jstring stringUtf = (jstring) stringUtfObject;
        const char *stringUtfChar = env->GetStringUTFChars(stringUtf, 0);
        localOutStrings->Set(i, String::NewFromUtf8(isolate, stringUtfChar));
        env->ReleaseStringUTFChars(stringUtf, stringUtfChar);
        env->DeleteLocalRef(stringUtfObject);
    }

    // Get local function
    Local<Function> local = Local<Function>::New(isolate, updateViewCallback);

    // Call function
    const unsigned argc = 5;
    Local<Value> argv[argc] = {localOutActions, localOutBooleans, localOutIntegers,
                               localOutFloats, localOutStrings};
    local->Call(Null(isolate), argc, argv);
}
