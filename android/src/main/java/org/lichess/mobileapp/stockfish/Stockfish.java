package org.lichess.mobileapp.stockfish;

import android.app.ActivityManager;
import android.content.Context;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;

@NativePlugin
public final class Stockfish extends Plugin {

  private static final String EVENT_OUTPUT = "stockfishOutput";

  private boolean isInit = false;

  static {
    System.loadLibrary("stockfish-jni");
  }

  // JNI
  public native void jniInit(long memorySize);
  public native void jniExit();
  public native void jniCmd(String cmd);
  public void onMessage(byte[] b) {
    String output = new String(b);
    notifyListeners(EVENT_OUTPUT, output);
  }
  // end JNI

  @PluginMethod
  public void init(PluginCall call) {
    if (!isInit) {
      // Get total device RAM for hashtable sizing
      Context context = getContext();
      ActivityManager actManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
      ActivityManager.MemoryInfo memInfo = new ActivityManager.MemoryInfo();
      actManager.getMemoryInfo(memInfo);
      long totalMemory = memInfo.totalMem;
      jniInit(totalMemory);
      isInit = true;
    }
    call.success();
  }

  @PluginMethod
  public void cmd(PluginCall call) {
    if (isInit) {
      String cmd = call.getString("cmd");
      if (cmd == null) {
        call.error("Must provide a cmd");
        return;
      }
      jniCmd(cmd);
      call.success();
    } else {
      call.error("Please call init before doing anything.");
    }
  }

  @PluginMethod
  public void exit(PluginCall call) {
    if (isInit) {
      doExit();
    }
    call.success();
  }

  private void doExit() {
    if (isInit) {
      jniExit();
      isInit = false;
    }
  }
}
