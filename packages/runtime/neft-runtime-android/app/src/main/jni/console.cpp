#include "android/log.h"
#include "include/v8.h"
#include "js.cpp"

#define  LOG_TAG    "Neft"

using namespace v8;

static void androidLog(int level, const FunctionCallbackInfo<Value>& args) {
    Isolate *isolate = JS::GetIsolate();
    HandleScope scope(isolate);

    Local<Context> context = Local<Context>::New(isolate, JS::GetContext());
    Context::Scope context_scope(context);

    String::Utf8Value str(isolate, args[0]->ToString(context).ToLocalChecked());

    __android_log_write(level, LOG_TAG, *str);
}

namespace console {
    void log(const FunctionCallbackInfo<Value>& args) {
        androidLog(ANDROID_LOG_DEBUG, args);
    }

    void info(const FunctionCallbackInfo<Value>& args) {
        androidLog(ANDROID_LOG_INFO, args);
    }

    void warn(const FunctionCallbackInfo<Value>& args) {
        androidLog(ANDROID_LOG_WARN, args);
    }

    void error(const FunctionCallbackInfo<Value>& args) {
        androidLog(ANDROID_LOG_ERROR, args);
    }

    int main(){
        Persistent<Object, CopyablePersistentTraits<Object>> object;
        object = JS::CreateObject(JS::GetGlobalNeftObject(), "console");
        JS::LinkFunction(object, "log", console::log);
        JS::LinkFunction(object, "info", console::info);
        JS::LinkFunction(object, "warn", console::warn);
        JS::LinkFunction(object, "error", console::error);
        return 0;
    }
}
