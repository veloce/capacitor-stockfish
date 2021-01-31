package org.lichess.mobileapp.stockfish;

import android.app.ActivityManager;
import android.content.Context;
import android.os.Build;

import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.ScheduledFuture;
import static java.util.concurrent.TimeUnit.SECONDS;

import com.getcapacitor.JSObject;
import com.getcapacitor.NativePlugin;
import com.getcapacitor.Plugin;
import com.getcapacitor.PluginCall;
import com.getcapacitor.PluginMethod;


@NativePlugin
public final class Stockfish extends Plugin {

  private PluginCall outputCall;
  private boolean isInit = false;

  private final ScheduledExecutorService scheduler =
    Executors.newScheduledThreadPool(1);
  private ScheduledFuture<?> stopOnPauseHandle;

  static {
    System.loadLibrary("stockfish");
  }

  // JNI
  public native void jniInit();
  public native void jniExit();
  public native void jniCmd(String cmd);
  public void onMessage(byte[] bytes) {
    JSObject obj = new JSObject();
    obj.put("output", new String(bytes));
    bridge.triggerWindowJSEvent("stockfish", obj.toString());
  }
  // end JNI

  @PluginMethod
  public void getCPUArch(PluginCall call) {
    // The possible values are armeabi, armeabi-v7a, arm64-v8a, x86, x86_64, mips, mips64
    String abi;
    if (Build.VERSION.SDK_INT < Build.VERSION_CODES.LOLLIPOP) {
      abi = Build.CPU_ABI;
    } else {
      abi = Build.SUPPORTED_ABIS[0];
    }
    JSObject ret = new JSObject();
    ret.put("value", abi);
    call.success(ret);
  }

  @PluginMethod
  public void getMaxMemory(PluginCall call) {
    Context context = getContext();
    ActivityManager actManager = (ActivityManager) context.getSystemService(Context.ACTIVITY_SERVICE);
    ActivityManager.MemoryInfo memInfo = new ActivityManager.MemoryInfo();
    actManager.getMemoryInfo(memInfo);
    // allow max 1/16th of total mem
    long maxMemInMB = (memInfo.totalMem / 16) / (1024L * 1024L);
    JSObject ret = new JSObject();
    ret.put("value", maxMemInMB);
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
    doExit();
    call.success();
  }

  @Override
  protected void handleOnDestroy() {
    doExit();
  }

  @Override
  protected void handleOnPause() {
    if (isInit) {
      stopOnPauseHandle = scheduler.schedule(new Runnable() {
        public void run() {
          if (isInit) {
            jniCmd("stop");
          }
        }
      }, 60 * 10, SECONDS);
    }
  }

  @Override
  protected void handleOnResume() {
    if (isInit) {
      if (stopOnPauseHandle != null) {
        stopOnPauseHandle.cancel(false);
      }
    }
  }

  private void doExit() {
    if (isInit) {
      jniCmd("stop");
      jniExit();
      isInit = false;
    }
  }
}
