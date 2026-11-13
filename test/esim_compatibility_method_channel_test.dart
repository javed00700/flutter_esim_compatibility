import 'package:esim_compatibility/esim_compatibility_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final MethodChannelEsimCompatibility platform =
      MethodChannelEsimCompatibility();
  const MethodChannel channel = MethodChannel('esim_compatibility');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('isEsimCompatible returns true when native method returns true', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'isEsimCompatible') {
          return true;
        }
        return null;
      },
    );

    expect(await platform.isEsimCompatible(), isTrue);
  });

  test('isEsimCompatible returns false when native method returns false', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        if (methodCall.method == 'isEsimCompatible') {
          return false;
        }
        return null;
      },
    );

    expect(await platform.isEsimCompatible(), isFalse);
  });

  test('isEsimCompatible returns false when native method returns null', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async => null,
    );

    expect(await platform.isEsimCompatible(), isFalse);
  });

  test('isEsimCompatible returns false on PlatformException', () async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        throw PlatformException(code: 'UNAVAILABLE');
      },
    );

    expect(await platform.isEsimCompatible(), isFalse);
  });
}
