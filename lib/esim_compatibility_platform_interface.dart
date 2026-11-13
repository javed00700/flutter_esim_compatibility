import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'esim_compatibility_method_channel.dart';

/// The interface that platform-specific implementations of `esim_compatibility` must extend.
abstract class EsimCompatibilityPlatform extends PlatformInterface {
  /// Constructs an [EsimCompatibilityPlatform].
  EsimCompatibilityPlatform() : super(token: _token);

  static final Object _token = Object();

  static EsimCompatibilityPlatform _instance = MethodChannelEsimCompatibility();

  /// The default instance of [EsimCompatibilityPlatform] to use.
  static EsimCompatibilityPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [EsimCompatibilityPlatform] when
  /// they register themselves.
  static set instance(EsimCompatibilityPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  /// Checks whether the current device is eSIM compatible.
  Future<bool> isEsimCompatible() {
    throw UnimplementedError('isEsimCompatible() has not been implemented.');
  }
}
