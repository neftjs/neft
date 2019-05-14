LOCAL_PATH := $(call my-dir)
LOCAL_CFLAGS := -Werror -Wall -g

include $(CLEAR_VARS)
LOCAL_MODULE    := v8_base
ifeq ($(TARGET_ARCH_ABI), x86)
    LOCAL_SRC_FILES := libs/ia32/libv8_base.a
else
    LOCAL_SRC_FILES := libs/arm/libv8_base.a
endif
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := v8_libplatform
ifeq ($(TARGET_ARCH_ABI), x86)
    LOCAL_SRC_FILES := libs/ia32/libv8_libplatform.a
else
    LOCAL_SRC_FILES := libs/arm/libv8_libplatform.a
endif
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := v8_libbase
ifeq ($(TARGET_ARCH_ABI), x86)
    LOCAL_SRC_FILES := libs/ia32/libv8_libbase.a
else
    LOCAL_SRC_FILES := libs/arm/libv8_libbase.a
endif
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := v8_nosnapshot
ifeq ($(TARGET_ARCH_ABI), x86)
    LOCAL_SRC_FILES := libs/ia32/libv8_nosnapshot.a
else
    LOCAL_SRC_FILES := libs/arm/libv8_nosnapshot.a
endif
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_CPPFLAGS += -std=c++11 -g
LOCAL_MODULE    := neft
LOCAL_SRC_FILES := neft.cpp
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_LDLIBS    := -llog -landroid -lz -latomic
LOCAL_STATIC_LIBRARIES := v8_base v8_libplatform v8_libbase v8_nosnapshot
CFLAGS += -Werror -Wall -g
include $(BUILD_SHARED_LIBRARY)
