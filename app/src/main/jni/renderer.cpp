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
    static vector<Persistent<Function, CopyablePersistentTraits<Function>>> animationFrameCalls;

    void requestAnimationFrame(const FunctionCallbackInfo<Value>& args) {
        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        Local<Function> callback = Local<Function>::Cast(args[0]);
        Persistent<Function, CopyablePersistentTraits<Function>> value(isolate, callback);

        animationFrameCalls.push_back(value);
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
        return 0;
    }
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
