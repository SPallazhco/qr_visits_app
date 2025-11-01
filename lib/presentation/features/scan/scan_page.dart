import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:go_router/go_router.dart';

class ScanPage extends ConsumerStatefulWidget {
  const ScanPage({super.key});

  @override
  ConsumerState<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends ConsumerState<ScanPage> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );
  bool _handled = false;
  bool _checkingPerm = true;
  bool _permDenied = false;

  @override
  void initState() {
    super.initState();
    _ensureCameraPermission();
  }

  Future<void> _ensureCameraPermission() async {
    final status = await Permission.camera.status;
    if (status.isGranted) {
      setState(() {
        _checkingPerm = false;
      });
      return;
    }
    final result = await Permission.camera.request();
    if (!mounted) return;
    if (result.isGranted) {
      setState(() => _checkingPerm = false);
    } else {
      setState(() {
        _checkingPerm = false;
        _permDenied = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_handled) return;
    final codes = capture.barcodes;
    if (codes.isEmpty) return;

    final raw = codes.first.rawValue;
    if (raw == null || raw.trim().isEmpty) return;

    _handled = true;
    context.pop(raw.trim()); // devolvemos el código
  }

  @override
  Widget build(BuildContext context) {
    if (_checkingPerm) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (_permDenied) {
      return Scaffold(
        appBar: AppBar(title: const Text('Escanear')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text(
                  'Permiso de cámara denegado.\nActívalo para poder escanear.',
                  textAlign: TextAlign.center,
                ),
              ),
              FilledButton(
                onPressed: () async {
                  await openAppSettings();
                },
                child: const Text('Abrir ajustes'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Escanear'),
        actions: [
          IconButton(
            tooltip: 'Linterna',
            onPressed: () => _controller.toggleTorch(),
            icon: const Icon(Icons.flash_on),
          ),
          IconButton(
            tooltip: 'Cámara frontal/trasera',
            onPressed: () => _controller.switchCamera(),
            icon: const Icon(Icons.cameraswitch),
          ),
        ],
      ),
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _onDetect),
          // Sencillo overlay de guía
          IgnorePointer(
            child: Center(
              child: Container(
                width: 260,
                height: 260,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
