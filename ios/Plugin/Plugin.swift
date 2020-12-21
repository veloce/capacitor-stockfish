import Foundation
import Capacitor

@objc(Stockfish)
public class Stockfish: CAPPlugin {

    var isInit = false

    @objc func start(_ call: CAPPluginCall) {
        isInit = true
        call.success()
    }

    @objc func cmd(_ call: CAPPluginCall) {
        if (isInit) {
            guard let cmd = call.options["cmd"] as? String else {
                call.reject("Must provide a cmd")
                return
            }
            call.resolve()
        } else {
            call.reject("You must call start before anything else")
        }
    }
}
