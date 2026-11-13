import 'package:flutter/material.dart';
import 'package:flutter_esim_compatibility/flutter_esim_compatibility.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'eSIM Compatibility Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const EsimHomeScreen(),
    );
  }
}

class EsimHomeScreen extends StatefulWidget {
  const EsimHomeScreen({super.key});

  @override
  State<EsimHomeScreen> createState() => _EsimHomeScreenState();
}

class _EsimHomeScreenState extends State<EsimHomeScreen> {
  bool? _isEsimSupported;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkCompatibility();
  }

  Future<void> _checkCompatibility() async {
    setState(() {
      _isLoading = true;
    });

    final isSupported = await FlutterEsimCompatibility.isEsimCompatible();

    if (!mounted) return;

    setState(() {
      _isEsimSupported = isSupported;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('eSIM Compatibility'),
        centerTitle: true,
        backgroundColor: theme.colorScheme.inversePrimary,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_isLoading)
                const CircularProgressIndicator()
              else ...[
                Icon(
                  _isEsimSupported == true
                      ? Icons.check_circle_outline
                      : Icons.highlight_off,
                  size: 80,
                  color: _isEsimSupported == true ? Colors.green : Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  _isEsimSupported == true
                      ? 'eSIM is Supported!'
                      : 'eSIM is Not Supported',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color:
                        _isEsimSupported == true
                            ? Colors.green.shade800
                            : Colors.red.shade800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  _isEsimSupported == true
                      ? 'This device possesses hardware eSIM capabilities.'
                      : 'This device does not support eSIM or eSIM is disabled.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 32),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : _checkCompatibility,
                icon: const Icon(Icons.refresh),
                label: const Text('Check Again'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
