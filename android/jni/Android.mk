LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

LOCAL_MODULE := stockfish
LOCAL_C_INCLUDES := $(LOCAL_PATH)/../../stockfish/src/ $(LOCAL_PATH)/../../lib/
LOCAL_SRC_FILES := \
	stockfish-jni.cpp \
	../../stockfish/src/thread.cpp \
	../../stockfish/src/timeman.cpp \
	../../stockfish/src/ucioption.cpp \
	../../stockfish/src/nnue/evaluate_nnue.cpp \
	../../stockfish/src/nnue/features/half_kp.cpp \
	../../stockfish/src/misc.cpp \
	../../stockfish/src/bitboard.cpp \
	../../stockfish/src/psqt.cpp \
	../../stockfish/src/benchmark.cpp \
	../../stockfish/src/movepick.cpp \
	../../stockfish/src/tune.cpp \
	../../stockfish/src/syzygy/tbprobe.cpp \
	../../stockfish/src/bitbase.cpp \
	../../stockfish/src/evaluate.cpp \
	../../stockfish/src/search.cpp \
	../../stockfish/src/pawns.cpp \
	../../stockfish/src/movegen.cpp \
	../../stockfish/src/material.cpp \
	../../stockfish/src/tt.cpp \
	../../stockfish/src/position.cpp \
	../../stockfish/src/uci.cpp \
	../../stockfish/src/endgame.cpp
LOCAL_LDLIBS := -llog -landroid
LOCAL_ARM_NEON := true

include $(BUILD_SHARED_LIBRARY)
