import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';
import 'package:seimbangin_app/ui/sections/ocr/ocr_overlay_painter.dart';
import 'package:seimbangin_app/ui/sections/ocr/ocr_camera_controls_section.dart';

enum CameraStatus { initial, loading, success, failure }

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  CameraStatus _cameraStatus = CameraStatus.initial;
  CameraController? _cameraController;
  String? _errorMessage;
  final ImagePicker _picker = ImagePicker();

  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;
  FlashMode _currentFlashMode = FlashMode.off;

  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));

    _initializeCamera();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _cameraController;

    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory and prevent camera hogging when app is in background
      cameraController.dispose();
      _cameraController = null;
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera carefully when app comes back
      _initializeCamera(_selectedCameraIndex);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _initializeCamera([int cameraIndex = 0]) async {
    if (!mounted) return;

    setState(() {
      _cameraStatus = CameraStatus.loading;
    });

    try {
      if (_cameras.isEmpty) {
        _cameras = await availableCameras();
        if (_cameras.isEmpty) {
          throw CameraException(
              'No Camera Found', 'No camera is available on this device.');
        }
      }

      _selectedCameraIndex = cameraIndex < _cameras.length ? cameraIndex : 0;
      final cameraDescription = _cameras[_selectedCameraIndex];

      await _cameraController?.dispose();

      _cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await _cameraController!.initialize();
      await _cameraController!.setFlashMode(_currentFlashMode);

      if (mounted) {
        setState(() {
          _cameraStatus = CameraStatus.success;
        });
      }
    } on CameraException catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "Error: ${e.code}\n${e.description}";
          _cameraStatus = CameraStatus.failure;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "An unexpected error occurred: $e";
          _cameraStatus = CameraStatus.failure;
        });
      }
    }
  }

  void _switchCamera() {
    if (_cameras.length > 1) {
      final nextCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      _initializeCamera(nextCameraIndex);
    }
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) {
      return;
    }

    final newFlashMode =
        _currentFlashMode == FlashMode.off ? FlashMode.torch : FlashMode.off;

    try {
      await _cameraController!.setFlashMode(newFlashMode);
      if (mounted) {
        setState(() {
          _currentFlashMode = newFlashMode;
        });
      }
    } catch (e) {
      print("Error setting flash mode: $e");
    }
  }

  Future<void> takePicture() async {
    if (_cameraStatus != CameraStatus.success ||
        _cameraController == null ||
        !_cameraController!.value.isInitialized) {
      return;
    }
    if (_cameraController!.value.isTakingPicture) {
      return;
    }

    try {
      final XFile image = await _cameraController!.takePicture();

      if (_currentFlashMode == FlashMode.torch) {
        await _toggleFlash(); // Turn off flash after taking picture if it was torch
      }

      if (mounted) {
        routes.pushReplacementNamed(
          RouteNames.ocrPreview,
          extra: image.path,
        );
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  Future<void> _selectFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null && mounted) {
        routes.pushReplacementNamed(
          RouteNames.ocrPreview,
          extra: pickedFile.path,
        );
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_cameraStatus) {
      case CameraStatus.loading:
      case CameraStatus.initial:
        return const Center(
            child: CircularProgressIndicator(color: Colors.white));
      case CameraStatus.failure:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, color: Colors.redAccent, size: 60.r),
              SizedBox(height: 16.h),
              Text('Gagal memuat kamera',
                  style: context.text.whiteTextStyle.copyWith(
                      fontSize: 18.sp, fontWeight: FontWeight.bold)),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_errorMessage!,
                      style: context.text.whiteTextStyle.copyWith(
                          fontSize: 12.sp, color: Colors.grey),
                      textAlign: TextAlign.center),
                ),
              SizedBox(height: 24.h),
              PrimaryFilledButton(
                title: 'Coba Lagi',
                onPressed: _initializeCamera,
              ),
            ],
          ),
        );
      case CameraStatus.success:
        return _buildCameraView();
    }
  }

  Widget _buildCameraView() {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * 0.8;
    final height = (width * 3) / 2;
    final centerRect = Rect.fromCenter(
      center: Offset(screenSize.width / 2, screenSize.height / 2.2),
      width: width,
      height: height,
    );

    return Stack(
      children: [
        // Camera Preview
        Positioned.fill(
          child: Center(
            child: AspectRatio(
              aspectRatio: 1 / _cameraController!.value.aspectRatio,
              child: CameraPreview(_cameraController!),
            ),
          ),
        ),

        // Overlay Paint
        Positioned.fill(
          child: CustomPaint(
            painter: OcrOverlayPainter(centerRect),
          ),
        ),

        // Scanning Animation Line
        AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            final dy = _animationController.value * centerRect.height;
            return Positioned(
              top: centerRect.top + dy,
              left: centerRect.left,
              right: screenSize.width - centerRect.right,
              child: child!,
            );
          },
          child: Container(
            height: 3,
            decoration: BoxDecoration(
              color: context.color.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: context.color.primaryColor.withOpacity(0.6),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ],
            ),
          ),
        ),

        // Text Instruction
        Positioned(
          top: centerRect.bottom + 20.r,
          left: 0,
          right: 0,
          child: Text(
            "Posisikan struk tagihan di dalam kotak",
            textAlign: TextAlign.center,
            style: context.text.whiteTextStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        // Top Header Base
        Positioned(
          top: 50.r,
          left: 20.r,
          right: 20.r,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomRoundedButton(
                onPressed: () => routes.pushReplacementNamed(RouteNames.main),
                widget: Icon(Icons.close_rounded,
                    size: 28.r, color: context.color.textSecondaryColor),
                backgroundColor: context.color.backgroundWhiteColor,
              ),
              Image.asset('assets/ic_seimbangin-logo-logreg.png', height: 62.h),
            ],
          ),
        ),

        // Bottom Controls Container
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: OcrCameraControlsSection(
            cameraCount: _cameras.length,
            currentFlashMode: _currentFlashMode,
            onSwitchCamera: _switchCamera,
            onTakePicture: takePicture,
            onToggleFlash: _toggleFlash,
            onSelectFromGallery: _selectFromGallery,
          ),
        ),
      ],
    );
  }
}
