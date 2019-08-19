#include <jni.h>
#include "include/v8.h"
#include "js.cpp"
#include "java.cpp"

using namespace v8;

namespace timers {
    static jobject jniObject;
    static jmethodID jniShotMethod;

    Persistent<Function, CopyablePersistentTraits<Function>> callback;

    void registerCallback(const FunctionCallbackInfo<Value>& args){
        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        Local<Function> callback = Local<Function>::Cast(args[0]);
        Persistent<Function, CopyablePersistentTraits<Function>> value(isolate, callback);
        timers::callback = value;
    }

    void shot(const FunctionCallbackInfo<Value>& args) {
        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        Local<Context> context = Local<Context>::New(isolate, JS::GetContext());
        Context::Scope context_scope(context);

        jint delay = args[0]->Int32Value(context).ToChecked();
        int id = Java::GetEnv()->CallIntMethod(jniObject, jniShotMethod, delay);

        args.GetReturnValue().Set(Integer::New(isolate, id));
    }

    void immediate(const FunctionCallbackInfo<Value>& args) {
        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        Local<Function> callback = Local<Function>::New(isolate, args[0].As<Function>());
        isolate->EnqueueMicrotask(callback);
    }

    int main() {
        Persistent<Object, CopyablePersistentTraits<Object>> jsObject;
        jsObject = JS::CreateObject(JS::GetGlobalNeftObject(), "timers");
        JS::LinkFunction(jsObject, "registerCallback", timers::registerCallback);
        JS::LinkFunction(jsObject, "shot", timers::shot);
        JS::LinkFunction(jsObject, "immediate", timers::immediate);
        return 0;
    }
}

extern "C" void Java_io_neft_Native_timers_1init(JNIEnv * env, jobject object, jobject timersObject) {
    jclass jniClass = (jclass) env->GetObjectClass(timersObject);
    timers::jniObject = env->NewGlobalRef(timersObject);
    timers::jniShotMethod = env->GetMethodID(jniClass, "shot", "(I)I");
}

extern "C" void Java_io_neft_Native_timers_1callback(JNIEnv * env, jobject obj, jint id) {
    Isolate *isolate = JS::GetIsolate();
    Locker locker(isolate);
    Isolate::Scope isolate_scope(isolate);
    HandleScope handle_scope(isolate);

    const unsigned argc = 1;
    Local<Value> argv[argc] = { Int32::New(isolate, id) };
    JS::CallFunction(timers::callback, argc, argv);
}