#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "include/v8.h"

#include "js.cpp"
#include "java.cpp"
#include "console.cpp"
#include "renderer.cpp"
#include "http.cpp"
#include "timers.cpp"

using namespace v8;

extern "C" void Java_io_neft_Native_init(JNIEnv * env, jobject obj, jstring js) {

    // Initialize V8
    JS::Initialize(env->GetStringUTFChars(js, JNI_FALSE));

    // Prepare global JS object
    http::main();
    timers::main();
    console::main();
    renderer::main();

    // Run script
    JS::Run();

    return;
}