import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_esim_compatibility_method_channel.dart';

/// The interface that platform-specific implementations of `flutter_esim_compatibility` must extend.
abstract class FlutterEsimCompatibilityPlatform extends PlatformInterface {
  /// Constructs a [FlutterEsimCompatibilityPlatform].
  FlutterEsimCompatibilityPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterEsimCompatibilityPlatform _instance =
      MethodChannelFlutterEsimCompatibility();

  /// The default instance of [FlutterEsimCompatibilityPlatform] to use.
  static FlutterEsimCompatibilityPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterEsimCompatibilityPlatform] when
  /// they register themselves.
  static set instance(FlutterEsimCompatibilityPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Checks whether the current device is eSIM compatible.
  Future<bool> isEsimCompatible() {
    throw UnimplementedError('isEsimCompatible() has not been implemented.');
  }
}

