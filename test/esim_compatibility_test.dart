import 'package:esim_compatibility/esim_compatibility.dart';
import 'package:esim_compatibility/esim_compatibility_method_channel.dart';
import 'package:esim_compatibility/esim_compatibility_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockEsimCompatibilityPlatform
    with MockPlatformInterfaceMixin
    implements EsimCompatibilityPlatform {
  bool isCompatibleValue = true;

  @override
  Future<bool> isEsimCompatible() => Future.value(isCompatibleValue);
}

void main() {
  final EsimCompatibilityPlatform initialPlatform =
      EsimCompatibilityPlatform.instance;

  test('$MethodChannelEsimCompatibility is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelEsimCompatibility>());
  });

  group('EsimCompatibility', () {
    late MockEsimCompatibilityPlatform fakePlatform;

    setUp(() {
      fakePlatform = MockEsimCompatibilityPlatform();
      EsimCompatibilityPlatform.instance = fakePlatform;
    });

    test('isEsimCompatible returns true when supported', () async {
      fakePlatform.isCompatibleValue = true;
      expect(await EsimCompatibility.isEsimCompatible(), isTrue);
    });

    test('isEsimCompatible returns false when not supported', () async {
      fakePlatform.isCompatibleValue = false;
      expect(await EsimCompatibility.isEsimCompatible(), isFalse);
    });

    test('instance checkCompatibility delegates to isEsimCompatible', () async {
      fakePlatform.isCompatibleValue = true;
      const plugin = EsimCompatibility();
      expect(await plugin.checkCompatibility(), isTrue);
    });
  });
}
