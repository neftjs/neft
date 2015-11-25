LOCAL_PATH := $(call my-dir)
LOCAL_CFLAGS := -Werror -Wall -g

include $(CLEAR_VARS)
LOCAL_MODULE    := v8_base
LOCAL_SRC_FILES := libs/arm/libv8_base.a
include $(PREBUILT_STATIC_LIBRARY)

include $(CLEAR_VARS)
LOCAL_MODULE    := v8_libplatform
LOCAL_SRC_FILES := libs/arm/libv8_libplatform.a
include $(PREBUILT_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_MODULE    := v8_libbase
LOCAL_SRC_FILES := libs/arm/libv8_libbase.a
include $(PREBUILT_STATIC_LIBRARY)



include $(CLEAR_VARS)
LOCAL_MODULE    := v8_nosnapshot
LOCAL_SRC_FILES := libs/arm/libv8_nosnapshot.a
include $(PREBUILT_STATIC_LIBRARY)


include $(CLEAR_VARS)
LOCAL_CPPFLAGS += -std=c++11 -g
LOCAL_MODULE    := neft
LOCAL_SRC_FILES := neft.cpp
LOCAL_C_INCLUDES := $(LOCAL_PATH)/include
LOCAL_LDLIBS    := -llog -landroid -lz
LOCAL_STATIC_LIBRARIES := v8_base v8_libplatform v8_libbase v8_nosnapshot
CFLAGS += -Werror -Wall -g
include $(BUILD_SHARED_LIBRARY)
