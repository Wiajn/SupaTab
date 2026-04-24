import 'dart:io';
import 'package:camera/camera.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';

import '../../app/router.dart';
import '../../app/theme.dart';
import '../../core/local_db/database.dart';
import '../../main.dart';

class PhotoCaptureScreen extends ConsumerStatefulWidget {
  const PhotoCaptureScreen({super.key, required this.serviceId});

  final String serviceId;

  @override
  ConsumerState<PhotoCaptureScreen> createState() =>
    _PhotoCaptureScreenState();
}

class _PhotoCaptureScreenState extends ConsumerState<PhotoCaptureScreen> {
  CameraController? _camera;
  int _currentStep = 0;
  final List<String?> _capturedPaths = List.filled(PhotoType.values.length, null);
  bool _isCapturing = false;

  static const _photoTypes = PhotoType.values;

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    final back = cameras.firstWhere(
      (c) => c.lensDirection == CameraLensDirection.back,
      orElse: () => cameras.first,
    );
    _camera = CameraController(
      back,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    await _camera!.initialize();
    await _camera!.lockCaptureOrientation(DeviceOrientation.landscapeLeft);
    if (mounted) setState(() {});
  }

  Future<void> _capture() async {
    if (_camera == null || !_camera!.value.isInitialized || _isCapturing) {
      return;
    }

    setState(() => _isCapturing = true);

    try {
      final file  = await _camera!.takePicture();
      final dir   = await getApplicationDocumentsDirectory();
      final dest  = '${dir.path}/service_${widget.serviceId}_${_currentStep}.jpg';
      await File(file.path).copy(dest);

      setState(() {
        _capturedPaths[_currentStep] = dest;
        _isCapturing = false;
      });

      // Small delay then advance
      await Future.delayed(const Duration(milliseconds: 600));
      if (mounted) _advance();
    } catch (e) {
      setState(() => _isCapturing = false);
    }
  }

  void _advance() {
    if (_currentStep < _photoTypes.length - 1) {
      setState(() => _currentStep++);
    } else {
      _saveAndFinish();
    }
  }

  Future<void> _saveAndFinish() async {
    final db = ref.read(appDatabaseProvider);
    final now = DateTime.now();

    for (int i = 0; i < _photoTypes.length; i++) {
      final path = _capturedPaths[i];
      if (path == null) continue;

      await db.into(db.servicePhotos).insert(ServicePhotosCompanion(
        id:          Value(const Uuid().v4()),
        serviceId:   Value(widget.serviceId),
        photoType:   Value(_photoTypes[i].name),
        localPath:   Value(path),
        takenAt:     Value(now),
        syncPending: Value(true),
      ));
    }

    if (mounted) {
      context.go(AppRoute.dashboard);
    }
  }

  @override
  void dispose() {
    _camera?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final type        = _photoTypes[_currentStep];
    final hasCaptured = _capturedPaths[_currentStep] != null;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Row(
        children: [
          // Left: camera
          Expanded(
            flex: 7,
            child: Stack(
              children: [
                if (_camera?.value.isInitialized == true)
                  RotatedBox(
                    quarterTurns: 0,
                    child: CameraPreview(_camera!),
                  )
                else
                  const Center(child: CircularProgressIndicator(
                    color: Colors.white)),

                // Capture button
                Positioned(
                  bottom: 32, left: 0, right: 0,
                  child: Center(
                    child: GestureDetector(
                      onTap: hasCaptured ? null : _capture,
                      child: Container(
                        width: 72, height: 72,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                          color: hasCaptured
                            ? AppColors.success
                            : Colors.white.withOpacity(0.9),
                        ),
                        child: hasCaptured
                          ? const Icon(Icons.check, color: Colors.white, size: 32)
                          : _isCapturing
                            ? const CircularProgressIndicator(color: AppColors.primary)
                            : null,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Right: guidance panel
          Container(
            width: 300,
            color: AppColors.surface,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Container(
                  color: AppColors.primary,
                  width: double.infinity,
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Photo ${_currentStep + 1} of ${_photoTypes.length}',
                        style: const TextStyle(
                          color: Colors.white70, fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        type.label,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),

                // Progress dots
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Wrap(
                    spacing: 6, runSpacing: 6,
                    children: List.generate(_photoTypes.length, (i) {
                      final done = _capturedPaths[i] != null;
                      final active = i == _currentStep;
                      return Container(
                        width: 24, height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: done
                            ? AppColors.success
                            : active
                              ? AppColors.primary
                              : AppColors.surfaceVariant,
                          border: active
                            ? Border.all(
                                color: AppColors.primary, width: 2)
                            : null,
                        ),
                        child: done
                          ? const Icon(Icons.check,
                              color: Colors.white, size: 14)
                          : null,
                      );
                    }),
                  ),
                ),

                const Divider(),

                // Instruction
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('INSTRUCTIONS',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1,
                          color: AppColors.textMuted,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        type.instruction,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.5,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                const Spacer(),

                // Retake / skip options
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (hasCaptured) ...[
                        OutlinedButton.icon(
                          icon: const Icon(Icons.refresh, size: 16),
                          label: const Text('Retake photo'),
                          onPressed: () => setState(() =>
                            _capturedPaths[_currentStep] = null),
                        ),
                        const SizedBox(height: 8),
                        ElevatedButton(
                          onPressed: _advance,
                          child: _currentStep < _photoTypes.length - 1
                            ? const Text('Next photo →')
                            : const Text('Finish & save'),
                        ),
                      ] else
                        TextButton(
                          onPressed: _advance,
                          child: const Text('Skip this photo',
                            style: TextStyle(color: AppColors.textMuted)),
                        ),
                    ],
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
