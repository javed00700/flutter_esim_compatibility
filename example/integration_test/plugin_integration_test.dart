import 'package:flutter_esim_compatibility/flutter_esim_compatibility.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('isEsimCompatible test', (WidgetTester tester) async {
    final bool isCompatible = await FlutterEsimCompatibility.isEsimCompatible();
    // Verify that the call executes without throwing and returns a boolean value.
    expect(isCompatible, isA<bool>());
  });
}
