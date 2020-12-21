LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := stockfish
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../stockfish/src/
LOCAL_SHARED_LIBRARIES := stockfish
LOCAL_SRC_FILES := stockfish-jni.cpp
LOCAL_LDLIBS := -llog -landroid

include $(BUILD_SHARED_LIBRARY)
