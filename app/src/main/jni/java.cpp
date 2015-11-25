#pragma once

namespace Java {
    static JavaVM* vm = NULL;

    JNIEnv* GetEnv(){
        JNIEnv *jniEnv;
        vm->GetEnv((void**) &jniEnv, JNI_VERSION_1_6);
        return jniEnv;
    }
}

jint JNI_OnLoad(JavaVM* vm, void* reserved){
    Java::vm = vm;

    return JNI_VERSION_1_6;
}