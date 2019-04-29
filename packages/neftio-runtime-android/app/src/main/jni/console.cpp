#include "android/log.h"
#include "include/v8.h"
#include "js.cpp"

#define  LOG_TAG    "Neftio"

using namespace v8;

static void androidLog(int level, const FunctionCallbackInfo<Value>& args) {
    __android_log_write(level, LOG_TAG, *String::Utf8Value(args[0]->ToString()));
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
