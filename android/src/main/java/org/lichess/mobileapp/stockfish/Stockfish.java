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

  private static final String EVENT_OUTPUT = "output";

  private boolean isInit = false;

  static {
    System.loadLibrary("stockfish");
  }

  // JNI
  public native void jniInit();
  public native void jniExit();
  public native void jniCmd(String cmd);
  public void onMessage(byte[] b) {
    JSObject output = new JSObject();
    output.put("line", new String(b));
    notifyListeners(EVENT_OUTPUT, output);
  }
  // end JNI

  @PluginMethod
  public void getMemory(PluginCall call) {
    Context context = getContext();
    ActivityManager actManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
    ActivityManager.MemoryInfo memInfo = new ActivityManager.MemoryInfo();
    actManager.getMemoryInfo(memInfo);
    long totalMemory = memInfo.totalMem;
    JSObject ret = new JSObject();
    ret.put("value", totalMemory);
    call.success(ret);
  }

  @PluginMethod
  public void start(PluginCall call) {
    if (!isInit) {
      jniInit();
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
      jniCmd("stop");
      jniExit();
      isInit = false;
    }
  }
}
