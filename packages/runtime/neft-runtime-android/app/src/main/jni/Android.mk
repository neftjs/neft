LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)
LOCAL_MODULE := libv8_monolith
LOCAL_SRC_FILES := libs/$(TARGET_ARCH_ABI)/libv8_monolith.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include

LOCAL_CFLAGS := -std=c++11
LOCAL_STATIC_LIBRARIES := v8_monolith

LOCAL_MODULE := neft
LOCAL_SRC_FILES := neft.cpp
LOCAL_LDLIBS := -llog -landroid

include $(BUILD_SHARED_LIBRARY)
