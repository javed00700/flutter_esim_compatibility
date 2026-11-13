import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_esim_compatibility_platform_interface.dart';

/// An implementation of [FlutterEsimCompatibilityPlatform] that uses method channels.
class MethodChannelFlutterEsimCompatibility
    extends FlutterEsimCompatibilityPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel =
      const MethodChannel('flutter_esim_compatibility');

  @override
  Future<bool> isEsimCompatible() async {
    try {
      final isCompatible =
          await methodChannel.invokeMethod<bool>('isEsimCompatible');
      return isCompatible ?? false;
    } on PlatformException {
      return false;
    } on MissingPluginException {
      return false;
    }
  }
}
