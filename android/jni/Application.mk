APP_PLATFORM := android-21
APP_STL := c++_shared
APP_ABI := armeabi-v7a arm64-v8a x86 x86_64
APP_OPTIM := release
APP_CPPFLAGS += -std=c++17 -DUSE_PTHREADS -DNDEBUG -O3
APP_USE_CPP0X := true
