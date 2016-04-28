#pragma once

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "include/libplatform/libplatform.h"
#include "android/log.h"
#include "include/v8.h"

using namespace v8;

static Isolate* isolate_;
static Persistent<Context, CopyablePersistentTraits<Context>> context_;
static Persistent<Script> script_;
static Persistent<Object, CopyablePersistentTraits<Object>> global_;
static Persistent<Object, CopyablePersistentTraits<Object>> globalAndroid_;
static Persistent<Object, CopyablePersistentTraits<Object>> globalNeft_;

namespace JS {
    class ArrayBufferAllocator : public v8::ArrayBuffer::Allocator {
    public:
        virtual void* Allocate(size_t length) {
            void* data = AllocateUninitialized(length);
            return data == NULL ? data : memset(data, 0, length);
        }
        virtual void* AllocateUninitialized(size_t length) {
            return malloc(length);
        }
        virtual void Free(void* data, size_t) {
            free(data);
        }
    };

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
        localTarget->Set(String::NewFromUtf8(isolate_, name), object);

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
        Local<Function> function = Function::New(isolate_, callback);
        localTarget->Set(String::NewFromUtf8(isolate_, name), function);

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
        local->Call(isolate_->GetCurrentContext()->Global(), argc, argv);
    }
    void Initialize(const char *js){
        // Initialize V8.
        V8::InitializeICU();
        Platform* platform = platform::CreateDefaultPlatform();
        V8::InitializePlatform(platform);
        V8::Initialize();

        // Create a new Isolate and make it the current one.
        JS::ArrayBufferAllocator allocator;
        Isolate::CreateParams create_params;
        create_params.array_buffer_allocator = &allocator;
        Isolate* isolate = isolate_ = Isolate::New(create_params);
        {
            Isolate::Scope isolate_scope(isolate);

            // Create a stack-allocated handle scope.
            HandleScope handle_scope(isolate);

            // Create a new context.
            Local<Context> context = Context::New(isolate);
            context_.Reset(isolate, context);

            // Enter the context for compiling and running script.
            Context::Scope context_scope(context);
            Handle<Object> global = context->Global();
            global_.Reset(isolate, global);

            // Set config
            isolate->SetAutorunMicrotasks(true);

            // Prepare global object
            globalAndroid_ = JS::CreateObject(global_, "android");
            globalNeft_ = JS::CreateObject(global_, "_neft");

            // Create a string containing the JavaScript source code.
            Local<String> source =
                    String::NewFromUtf8(isolate, js,
                                        NewStringType::kNormal).ToLocalChecked();

            // Compile the source code.
            Local<Script> script;
            TryCatch try_catch(isolate);
            if (!Script::Compile(context, source).ToLocal(&script)){
                String::Utf8Value error(try_catch.StackTrace());
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
            String::Utf8Value error(try_catch.StackTrace());
            __android_log_write(ANDROID_LOG_ERROR, "Neft", *error);
        }
    }
};