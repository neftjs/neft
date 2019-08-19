#pragma once

#include <stdio.h>
#include <stdlib.h>
#include "include/libplatform/libplatform.h"
#include "android/log.h"
#include "include/v8.h"

using namespace v8;

static std::unique_ptr<v8::Platform> platformInstance;
static Isolate* isolate_;
static Persistent<Script> script_;
static Persistent<Context, CopyablePersistentTraits<Context>> context_;
static Persistent<Object, CopyablePersistentTraits<Object>> global_;
static Persistent<Object, CopyablePersistentTraits<Object>> globalAndroid_;
static Persistent<Object, CopyablePersistentTraits<Object>> globalNeft_;

void OnMessage(Local<Message> message, Local<Value> error) {
    HandleScope scope(isolate_);
    String::Utf8Value str(isolate_, message->Get());

    __android_log_write(ANDROID_LOG_ERROR, "Neft", *str);
}

void OnFatalError(const char* location, const char* message) {
    __android_log_print(ANDROID_LOG_ERROR, "Neft", "FATAL ERROR: %s %s", location, message);
}

namespace JS {
    Isolate* GetIsolate(){
        return isolate_;
    }
    Persistent<Object, CopyablePersistentTraits<Object>> GetGlobal(){
        return global_;
    }
    Persistent<Context, CopyablePersistentTraits<Context>> GetContext(){
        return context_;
    }
    Persistent<Object, CopyablePersistentTraits<Object>> GetGlobalAndroidObject(){
        return globalAndroid_;
    }
    Persistent<Object, CopyablePersistentTraits<Object>> GetGlobalNeftObject(){
        return globalNeft_;
    }
    Persistent<Object, CopyablePersistentTraits<Object>> CreateObject(Persistent<Object, CopyablePersistentTraits<Object>> target, const char *name){
        // Enter isolate
        Isolate::Scope isolate_scope(isolate_);
        HandleScope handle_scope(isolate_);

        // Get local context and enter it
        Local<Context> context = Local<Context>::New(isolate_, context_);
        Context::Scope context_scope(context);

        // Get local target
        Local<Object> localTarget = Local<Object>::New(isolate_, target);

        // Create new object and add it to the target
        Local<Object> object = Object::New(isolate_);
        auto objectName = String::NewFromUtf8(isolate_, name, NewStringType::kNormal).ToLocalChecked();
        (void) localTarget->Set(context, objectName, object);

        // Get persistent link to the created object
        Persistent<Object, CopyablePersistentTraits<Object>> persistentObject(isolate_, object);

        return persistentObject;
    }
    Persistent<Function, CopyablePersistentTraits<Function>> LinkFunction(Persistent<Object, CopyablePersistentTraits<Object>> target, const char *name, FunctionCallback callback){
        // Enter isolate
        Isolate::Scope isolate_scope(isolate_);
        HandleScope handle_scope(isolate_);

        // Get local context and enter it
        Local<Context> context = Local<Context>::New(isolate_, context_);
        Context::Scope context_scope(context);

        // Get local target
        Local<Object> localTarget = Local<Object>::New(isolate_, target);

        // Create new function and add it to the target
        Local<Function> function = Function::New(context, callback).ToLocalChecked();
        auto functionName = String::NewFromUtf8(isolate_, name, NewStringType::kNormal).ToLocalChecked();
        (void) localTarget->Set(context, functionName, function);

        // Get persistent link to the created function
        Persistent<Function, CopyablePersistentTraits<Function>> persistentFunction(isolate_, function);

        return persistentFunction;
    }
    void CallFunction(Persistent<Function, CopyablePersistentTraits<Function>> function, int argc, Handle<Value> argv[]){
        // Enter isolate
        Locker locker(isolate_);
        Isolate::Scope isolate_scope(isolate_);
        HandleScope handle_scope(isolate_);

        // Get local context and enter it
        Local<Context> context = Local<Context>::New(isolate_, context_);
        Context::Scope context_scope(context);

        // Get local function
        Local<Function> local = Local<Function>::New(isolate_, function);

        // Call function
        (void) local->Call(context, isolate_->GetCurrentContext()->Global(), argc, argv);
    }
    void Initialize(const char *js){
        // Initialize V8.
        V8::InitializeICU();
        platformInstance = platform::NewDefaultPlatform();
        V8::InitializePlatform(platformInstance.get());
        V8::Initialize();

        // Create a new Isolate and make it the current one.
        Isolate::CreateParams create_params;
        create_params.array_buffer_allocator = ArrayBuffer::Allocator::NewDefaultAllocator();
        Isolate* isolate = isolate_ = Isolate::New(create_params);
        {
            Isolate::Scope isolate_scope(isolate);

            // configure
            isolate->SetMicrotasksPolicy(MicrotasksPolicy::kAuto);
            isolate->SetCaptureStackTraceForUncaughtExceptions(true);
            isolate->AddMessageListener(OnMessage);
            isolate->SetFatalErrorHandler(OnFatalError);

            // Create a stack-allocated handle scope.
            HandleScope handle_scope(isolate);

            // Create a new context.
            Local<Context> context = Context::New(isolate);
            context_.Reset(isolate, context);

            // Enter the context for compiling and running script.
            Context::Scope context_scope(context);
            Handle<Object> global = context->Global();
            global_.Reset(isolate, global);

            // Prepare global object
            globalAndroid_ = JS::CreateObject(global_, "android");
            globalNeft_ = JS::CreateObject(global_, "_neft");

            // Create a string containing the JavaScript source code.
            Local<String> source = String::NewFromUtf8(isolate, js, NewStringType::kNormal).ToLocalChecked();

            // Compile the source code.
            Local<Script> script;
            TryCatch try_catch(isolate);
            if (!Script::Compile(context, source).ToLocal(&script)){
                String::Utf8Value error(isolate, try_catch.StackTrace(context).ToLocalChecked());
                __android_log_write(ANDROID_LOG_ERROR, "Neft", *error);
                return;
            }
            script_.Reset(isolate, script);
        }
    }
    void Run(){
        Locker locker(isolate_);
        Isolate::Scope isolate_scope(isolate_);
        HandleScope handle_scope(isolate_);

        Local<Context> context = Local<Context>::New(isolate_, context_);
        Context::Scope context_scope(context);

        Local<Script> script = Local<Script>::New(isolate_, script_);

        // Run the script to get the result.
        Local<Value> result;
        TryCatch try_catch(isolate_);
        if (!script->Run(context).ToLocal(&result)){
            String::Utf8Value error(isolate_, try_catch.StackTrace(context).ToLocalChecked());
            __android_log_write(ANDROID_LOG_ERROR, "Neft", *error);
        }
    }
};
