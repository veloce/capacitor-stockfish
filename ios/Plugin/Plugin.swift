import Foundation
import Capacitor

@objc(Stockfish)
public class Stockfish: CAPPlugin {
    
    private var stockfish: StockfishBridge?
    private var isInit = false
    
    private let template = "{\"output\": \"%@\"}"
    @objc public func sendOutput(_ output: String) {
        bridge.triggerWindowJSEvent(eventName: "stockfish", data: String(format: template, output))
    }

    @objc override public func load() {
        stockfish = StockfishBridge(plugin: self)
        var onPauseWorkItem: DispatchWorkItem?

        NotificationCenter.default.addObserver(forName: UIApplication.willResignActiveNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            if ((self?.isInit) != nil) {
                onPauseWorkItem = DispatchWorkItem {
                    self?.stockfish?.cmd("stop")
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 60 * 10, execute: onPauseWorkItem!)
            }
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            if ((self?.isInit) != nil) {
                onPauseWorkItem?.cancel()
            }
        }

        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: OperationQueue.main) { [weak self] (_) in
            if ((self?.isInit) != nil) {
                self?.stockfish?.cmd("stop")
                self?.stockfish?.exit()
                self?.isInit = false
            }
        }
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func getCPUArch(_ call: CAPPluginCall) {
        call.success([
            "value": StockfishBridge.getCPUType() ?? "unknown"
        ])
    }

    @objc func getMaxMemory(_ call: CAPPluginCall) {
        // allow max 1/16th of total mem
        let maxMemInMb = (ProcessInfo().physicalMemory / 16) / (1024 * 1024)
        call.success([
            "value": maxMemInMb
        ])
    }

    @objc func start(_ call: CAPPluginCall) {
        if (!isInit) {
            stockfish?.start()
            isInit = true
        }
        call.success()
    }

    @objc func cmd(_ call: CAPPluginCall) {
        if (isInit) {
            guard let cmd = call.options["cmd"] as? String else {
                call.reject("Must provide a cmd")
                return
            }
            stockfish?.cmd(cmd)
            call.resolve()
        } else {
            call.reject("You must call start before anything else")
        }
    }
    
    @objc func exit(_ call: CAPPluginCall) {
        if (isInit) {
            stockfish?.cmd("quit")
            stockfish?.exit()
            isInit = false
        }
        call.success()
    }
}
