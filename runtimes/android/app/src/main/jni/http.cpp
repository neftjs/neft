#include <jni.h>
#include "include/v8.h"
#include "js.cpp"
#include "java.cpp"
#include "android/log.h"

using namespace v8;

namespace http {
    static jobject jniObject;
    static jmethodID jniRequestMethod;

    Persistent<Function, CopyablePersistentTraits<Function>> response;

    void onResponse(const FunctionCallbackInfo<Value>& args){
        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        Local<Function> callback = Local<Function>::Cast(args[0]);
        Persistent<Function, CopyablePersistentTraits<Function>> value(isolate, callback);
        http::response = value;
    }

    void request(const FunctionCallbackInfo<Value>& args) {
        Isolate *isolate = JS::GetIsolate();
        Isolate::Scope isolate_scope(isolate);

        JNIEnv *jniEnv = Java::GetEnv();

        // get parameters
        jstring path = jniEnv->NewStringUTF(*String::Utf8Value(args[0]->ToString()));
        jstring method = jniEnv->NewStringUTF(*String::Utf8Value(args[1]->ToString()));
        jstring data = jniEnv->NewStringUTF(*String::Utf8Value(args[3]->ToString()));

        // get headers array
        Local<Array> jsHeaders = Local<Array>::Cast(args[2]);
        const int length = jsHeaders->Length();
        jobjectArray headers = jniEnv->NewObjectArray(length, jniEnv->FindClass("java/lang/String"), jniEnv->NewStringUTF(""));
        for (int i = 0; i < length; i++) {
            jstring stringUTF = jniEnv->NewStringUTF(*String::Utf8Value(jsHeaders->Get(i)->ToString()));
            jniEnv->SetObjectArrayElement(headers, i, stringUTF);
            jniEnv->DeleteLocalRef(stringUTF);
        }

        int id = jniEnv->CallIntMethod(http::jniObject, http::jniRequestMethod, path, method, headers, data);

        args.GetReturnValue().Set(Integer::New(isolate, id));
    }

    int main() {
        Persistent<Object, CopyablePersistentTraits<Object>> jsObject;
        jsObject = JS::CreateObject(JS::GetGlobalNeftObject(), "http");
        JS::LinkFunction(jsObject, "onResponse", http::onResponse);
        JS::LinkFunction(jsObject, "request", http::request);
        return 0;
    }
}

extern "C" void Java_io_neft_Native_http_1init(JNIEnv *env, jobject object, jobject httpObject) {
    jclass jniClass = (jclass) env->GetObjectClass(httpObject);
    http::jniObject = env->NewGlobalRef(httpObject);
    http::jniRequestMethod = env->GetMethodID(jniClass, "request", "(Ljava/lang/String;Ljava/lang/String;[Ljava/lang/String;Ljava/lang/String;)I");
}

extern "C" void Java_io_neft_Native_http_1onResponse(JNIEnv * env, jobject obj, jint id, jstring error, jint code, jstring resp, jstring cookies) {
    Isolate *isolate = JS::GetIsolate();
    Locker locker(isolate);
    Isolate::Scope isolate_scope(isolate);
    HandleScope handle_scope(isolate);

    const unsigned argc = 5;
    Local<Value> argv[argc] = {
            Int32::New(isolate, id),
            String::NewFromUtf8(isolate, env->GetStringUTFChars(error, 0)),
            Int32::New(isolate, code),
            String::NewFromUtf8(isolate, env->GetStringUTFChars(resp, 0)),
            String::NewFromUtf8(isolate, env->GetStringUTFChars(cookies, 0))
    };
    JS::CallFunction(http::response, argc, argv);
}
