import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import 'pdf417_parser.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen>
    with WidgetsBindingObserver {
  final _controller = MobileScannerController(
    formats: [BarcodeFormat.pdf417],
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _hasScanned = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _controller.stop();
    } else if (state == AppLifecycleState.resumed) {
      _controller.start();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) {
    if (_hasScanned) return;

    for (final barcode in capture.barcodes) {
      final raw = barcode.rawValue;
      if (raw == null || raw.isEmpty) continue;

      setState(() => _hasScanned = true);
      _controller.stop();

      try {
        final vehicleData = SA417Parser.parse(raw);
        context.push(AppRoute.confirmVehicle, extra: {
          'licensePlate': vehicleData.licensePlate,
          'make':         vehicleData.make,
          'model':        vehicleData.model,
          'year':         vehicleData.year,
          'colour':       vehicleData.colour,
          'vin':          vehicleData.vin,
          'rawBarcode':   raw,
        });
      } catch (e) {
        setState(() {
          _hasScanned  = false;
          _errorMessage = 'Could not read license disk.\nPlease try again.';
        });
        _controller.start();
      }
      break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Text(
          'Scan license disk',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _controller,
              builder: (_, value, __) {
                final state = value as MobileScannerState;
                return Icon(
                  state.torchState == TorchState.on
                    ? Icons.flashlight_on
                    : Icons.flashlight_off,
                  color: Colors.white,
                );
              },
            ),
            onPressed: _controller.toggleTorch,
          ),
          IconButton(
            icon: const Icon(Icons.flip_camera_android, color: Colors.white),
            onPressed: _controller.switchCamera,
          ),
        ],
      ),
      body: Stack(
        children: [
          // Camera view — RotatedBox fixes 90° rotation on Samsung tablets
          RotatedBox(
            quarterTurns: 3,
            child: MobileScanner(
              controller: _controller,
              onDetect: _onDetect,
            ),
          ),

          // Scan overlay
          _ScanOverlay(),

          // Instructions
          Positioned(
            bottom: 80,
            left: 0,
            right: 0,
            child: Column(
              children: [
                if (_errorMessage != null)
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 40),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: AppColors.danger,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      _errorMessage!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                const Text(
                  'Point camera at the PDF417 barcode\non the vehicle license disk',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Transparent overlay with a scan-window cutout
class _ScanOverlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size   = MediaQuery.of(context).size;
    final window = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 - 40),
      width:  size.width * 0.55,
      height: size.height * 0.30,
    );

    return CustomPaint(
      size: Size(size.width, size.height),
      painter: _OverlayPainter(window: window),
    );
  }
}

class _OverlayPainter extends CustomPainter {
  const _OverlayPainter({required this.window});
  final Rect window;

  @override
  void paint(Canvas canvas, Size size) {
    final dimPaint = Paint()..color = Colors.black54;
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(window, const Radius.circular(12)))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path, dimPaint);

    // Corner brackets
    final bracketPaint = Paint()
      ..color   = AppColors.primary
      ..style   = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    const len = 24.0;
    // Top-left
    canvas.drawLine(window.topLeft,
      window.topLeft.translate(len, 0), bracketPaint);
    canvas.drawLine(window.topLeft,
      window.topLeft.translate(0, len), bracketPaint);
    // Top-right
    canvas.drawLine(window.topRight,
      window.topRight.translate(-len, 0), bracketPaint);
    canvas.drawLine(window.topRight,
      window.topRight.translate(0, len), bracketPaint);
    // Bottom-left
    canvas.drawLine(window.bottomLeft,
      window.bottomLeft.translate(len, 0), bracketPaint);
    canvas.drawLine(window.bottomLeft,
      window.bottomLeft.translate(0, -len), bracketPaint);
    // Bottom-right
    canvas.drawLine(window.bottomRight,
      window.bottomRight.translate(-len, 0), bracketPaint);
    canvas.drawLine(window.bottomRight,
      window.bottomRight.translate(0, -len), bracketPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
