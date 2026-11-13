import 'package:flutter_esim_compatibility/flutter_esim_compatibility.dart';
import 'package:flutter_esim_compatibility/flutter_esim_compatibility_method_channel.dart';
import 'package:flutter_esim_compatibility/flutter_esim_compatibility_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterEsimCompatibilityPlatform
    with MockPlatformInterfaceMixin
    implements FlutterEsimCompatibilityPlatform {
  bool isCompatibleValue = true;

  @override
  Future<bool> isEsimCompatible() => Future.value(isCompatibleValue);
}

void main() {
  final FlutterEsimCompatibilityPlatform initialPlatform =
      FlutterEsimCompatibilityPlatform.instance;

  test('$MethodChannelFlutterEsimCompatibility is the default instance', () {
    expect(
        initialPlatform, isInstanceOf<MethodChannelFlutterEsimCompatibility>());
  });

  group('FlutterEsimCompatibility', () {
    late MockFlutterEsimCompatibilityPlatform fakePlatform;

    setUp(() {
      fakePlatform = MockFlutterEsimCompatibilityPlatform();
      FlutterEsimCompatibilityPlatform.instance = fakePlatform;
    });

    test('isEsimCompatible returns true when supported', () async {
      fakePlatform.isCompatibleValue = true;
      expect(await FlutterEsimCompatibility.isEsimCompatible(), isTrue);
    });

    test('isEsimCompatible returns false when not supported', () async {
      fakePlatform.isCompatibleValue = false;
      expect(await FlutterEsimCompatibility.isEsimCompatible(), isFalse);
    });

    test('instance checkCompatibility delegates to isEsimCompatible', () async {
      fakePlatform.isCompatibleValue = true;
      const plugin = FlutterEsimCompatibility();
      expect(await plugin.checkCompatibility(), isTrue);
    });

    test('backward compatibility alias EsimCompatibility works', () async {
      fakePlatform.isCompatibleValue = true;
      expect(await EsimCompatibility.isEsimCompatible(), isTrue);
    });
  });
}
