import Flutter
import UIKit

public class FlutterEsimCompatibilityPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "flutter_esim_compatibility",
      binaryMessenger: registrar.messenger()
    )
    let instance = FlutterEsimCompatibilityPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "isEsimCompatible":
      result(UIDevice.current.isEsimCompatible())
    default:
      result(FlutterMethodNotImplemented)
    }
  }
}
