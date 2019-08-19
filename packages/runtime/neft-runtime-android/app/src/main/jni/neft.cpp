#include <jni.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "include/libplatform/libplatform.h"
#include "android/log.h"
#include "include/v8.h"

#include "js.cpp"
#include "java.cpp"
#include "console.cpp"
#include "renderer.cpp"
#include "timers.cpp"
#include "client.cpp"

using namespace v8;

extern "C" void Java_io_neft_Native_init(JNIEnv * env, jobject obj, jstring js) {
    // Initialize V8
    JS::Initialize(env->GetStringUTFChars(js, JNI_FALSE));

    // Prepare global JS object
    timers::main();
    console::main();
    renderer::main();
    client::main();

    // Run script
    JS::Run();

    return;
}