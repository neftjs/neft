APP_ABI := armeabi armeabi-v7a x86

APP_STL := c++_static
APP_OPTIM := release
APP_PLATFORM := android-17
NDK_TOOLCHAIN_VERSION := 4.8

APP_CFLAGS += -std=c++11 -Werror -Wall -g
