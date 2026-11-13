import 'dart:async';

import 'flutter_esim_compatibility_platform_interface.dart';

/// A utility class to check whether the current device supports eSIM.
class FlutterEsimCompatibility {
  /// Creates an instance of [FlutterEsimCompatibility].
  const FlutterEsimCompatibility();

  /// Checks if the current device is eSIM compatible.
  ///
  /// On **Android**, verifies whether the device is running API level 28 (Android 9)
  /// or higher and whether `EuiccManager.isEnabled()` returns `true`.
  ///
  /// On **iOS**, verifies the hardware device identifier against Apple models
  /// that feature an embedded SIM (eSIM), including iPhones from XR/XS onwards,
  /// cellular iPads with eSIM support, and simulator configurations.
  ///
  /// On unsupported platforms or in case of errors, returns `false`.
  static Future<bool> isEsimCompatible() {
    return FlutterEsimCompatibilityPlatform.instance.isEsimCompatible();
  }

  /// Instance method version of [isEsimCompatible].
  Future<bool> checkCompatibility() {
    return isEsimCompatible();
  }
}

/// Backward compatibility alias for [FlutterEsimCompatibility].
typedef EsimCompatibility = FlutterEsimCompatibility;

