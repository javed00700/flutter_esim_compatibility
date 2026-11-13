# esim_compatibility

[![pub package](https://img.shields.io/pub/v/esim_compatibility.svg)](https://pub.dev/packages/esim_compatibility)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

A lightweight, high-performance Flutter plugin to detect whether the user's device supports **eSIM (embedded SIM)** on **iOS** and **Android**.

---

## Features

- ✅ **Swift Package Manager (SPM) & CocoaPods dual compatibility** on iOS.
- ✅ **Android support** via native `EuiccManager` (API level 28+ / Android 9+).
- ✅ **iOS support** via native hardware model analysis with $O(1)$ set lookup and future-proof generation heuristics.
- ✅ **Cellular iPad & Simulator support**.
- ✅ **Zero third-party dependencies** beyond Flutter standard libraries.
- ✅ **No special permissions** required in `AndroidManifest.xml` or `Info.plist`.
- ✅ **Safe fallback**: returns `false` on unsupported platforms without throwing uncaught exceptions.

---

## Platform Support

| Platform | Supported | Implementation Detail |
| :--- | :---: | :--- |
| **Android** | ✅ | Native `EuiccManager.isEnabled()` (Android 9 / API 28+) |
| **iOS** | ✅ | Native `utsname` hardware identifier matching & future-proof heuristics |
| **macOS** | ❌ | Returns `false` |
| **Windows** | ❌ | Returns `false` |
| **Linux** | ❌ | Returns `false` |
| **Web** | ❌ | Returns `false` |

---

## Installation

Add `esim_compatibility` to your `pubspec.yaml` file:

```yaml
dependencies:
  esim_compatibility: ^1.0.0
```

Then run:

```bash
flutter pub get
```

---

## Usage

### Simple Check

```dart
import 'package:esim_compatibility/esim_compatibility.dart';

void main() async {
  // Check eSIM compatibility
  final bool isSupported = await EsimCompatibility.isEsimCompatible();

  if (isSupported) {
    print('✅ Device supports eSIM');
  } else {
    print('❌ Device does not support eSIM');
  }
}
```

### In a Flutter Widget

```dart
import 'package:esim_compatibility/esim_compatibility.dart';
import 'package:flutter/material.dart';

class EsimCheckWidget extends StatefulWidget {
  const EsimCheckWidget({super.key});

  @override
  State<EsimCheckWidget> createState() => _EsimCheckWidgetState();
}

class _EsimCheckWidgetState extends State<EsimCheckWidget> {
  bool? _isEsimSupported;

  @override
  void initState() {
    super.initState();
    _checkDevice();
  }

  Future<void> _checkDevice() async {
    final supported = await EsimCompatibility.isEsimCompatible();
    if (!mounted) return;
    setState(() {
      _isEsimSupported = supported;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isEsimSupported == null) {
      return const CircularProgressIndicator();
    }

    return Text(
      _isEsimSupported! ? 'eSIM Supported' : 'eSIM Not Supported',
      style: TextStyle(
        color: _isEsimSupported! ? Colors.green : Colors.red,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
```

---

## How It Works

### Android
On Android, the plugin queries the system `EuiccManager` service:
1. Verifies that the device is running **Android 9 (API level 28)** or higher.
2. Checks `euiccManager.isEnabled()` to verify that the hardware embedded UICC is active and usable.

### iOS
Apple does not provide an unrestricted public API to query eSIM hardware state directly without carrier-exclusive entitlements. The plugin utilizes hardware model inspection via `utsname`:
1. Identifies the hardware model identifier (e.g., `iPhone15,2`, `iPad14,4`).
2. Compares against known eSIM-capable devices:
   - **iPhones**: iPhone XR, XS, XS Max, and all subsequent generations (iPhone 11 through iPhone 16/16e/17/18, SE 2nd & 3rd gen).
   - **Future-proofing**: Any iPhone model with major revision $\ge 11$ is recognized as eSIM-compatible.
   - **iPads**: Cellular models of iPad (7th gen+), iPad Air (3rd gen+), iPad mini (5th gen+), and iPad Pro (11-inch & 12.9-inch 3rd gen+).
   - **Simulator**: Inspects the simulated device target via `SIMULATOR_MODEL_IDENTIFIER`.

> **Note on Regional Variations**: Some regional device models (such as certain physical dual-SIM iPhones sold in Mainland China, Hong Kong, or Macao) do not feature an embedded eSIM chip.

---

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
