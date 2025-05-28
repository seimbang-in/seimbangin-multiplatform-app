import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

// Enum untuk merepresentasikan state kamera dengan jelas
enum CameraStatus { initial, loading, success, failure }

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  // Variabel State
  CameraStatus _cameraStatus = CameraStatus.initial;
  CameraController? _cameraController;
  String? _errorMessage;
  final ImagePicker _picker = ImagePicker();

  // State untuk fitur tambahan
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;
  FlashMode _currentFlashMode = FlashMode.off;

  @override
  void initState() {
    super.initState();
    // Atur UI status bar saat masuk halaman
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));
    // Panggil fungsi inisialisasi kamera
    _initializeCamera();
  }

  @override
  void dispose() {
    // Kembalikan UI status bar ke default saat keluar halaman
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _cameraController?.dispose();
    super.dispose();
  }

  // --- FUNGSI-FUNGSI LOGIKA KAMERA ---

  /// Menginisialisasi controller kamera dengan indeks kamera yang dipilih.
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

  /// Mengganti kamera antara depan dan belakang.
  void _switchCamera() {
    if (_cameras.length > 1) {
      final nextCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
      _initializeCamera(nextCameraIndex);
    }
  }

  /// Mengubah mode flash antara on (torch) dan off.
  Future<void> _toggleFlash() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized)
      return;

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

  /// Mengambil gambar dari kamera.
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
      // 1. Ambil gambar
      final XFile image = await _cameraController!.takePicture();

      // -- PERUBAHAN DI SINI --
      // 2. Cek jika flash sedang menyala, lalu matikan.
      // Kita panggil _toggleFlash() agar state juga ikut terupdate.
      if (_currentFlashMode == FlashMode.torch) {
        await _toggleFlash();
      }
      // -- AKHIR DARI PERUBAHAN --

      // 3. Pindah ke halaman preview setelah semua proses selesai
      if (mounted) {
        routes.pushNamed(
          RouteNames.ocrPreview,
          extra: image.path,
        );
      }
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  /// Memilih gambar dari galeri.
  Future<void> _selectFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 85,
      );

      if (pickedFile != null && mounted) {
        routes.pushNamed(
          RouteNames.ocrPreview,
          extra: pickedFile.path,
        );
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }

  // --- UI BUILD METHODS ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textPrimaryColor,
      body: _buildBody(),
    );
  }

  /// Membangun UI berdasarkan state kamera saat ini.
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
              Text('Failed to initialize camera', style: whiteTextStyle),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(_errorMessage!,
                      style: whiteTextStyle.copyWith(fontSize: 12.sp),
                      textAlign: TextAlign.center),
                ),
              SizedBox(height: 24.h),
              PrimaryFilledButton(
                title: 'Try Again',
                onPressed: _initializeCamera,
              ),
            ],
          ),
        );
      case CameraStatus.success:
        return _buildCameraView();
    }
  }

  /// Membangun UI utama saat kamera berhasil diinisialisasi.
  Widget _buildCameraView() {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * 0.7;
    final height = (width * 2) / 2;
    final centerRect = Rect.fromCenter(
      center: Offset(screenSize.width / 2, screenSize.height / 2),
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

        // Overlay
        Positioned.fill(
          child: CustomPaint(painter: OverlayPainter(centerRect)),
        ),

        // Top buttons
        Positioned(
          top: 60.r,
          left: 24.r,
          child: CustomRoundedButton(
            onPressed: () => routes.pushReplacementNamed(RouteNames.main),
            widget:
                Icon(Icons.chevron_left, size: 32.r, color: textSecondaryColor),
            backgroundColor: backgroundWhiteColor,
          ),
        ),
        Positioned(
          top: 60.r,
          right: 24.r,
          child: Image.asset('assets/ic_seimbangin-logo-logreg.png'),
        ),

        // Kontrol Kamera: Ganti Kamera, Shutter, Flash
        Align(
          alignment: const Alignment(0, 0.35),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Tombol Ganti Kamera (kiri)
              if (_cameras.length > 1) // Hanya tampilkan jika ada > 1 kamera
                GestureDetector(
                  onTap: _switchCamera,
                  child: Container(
                    width: 60.r,
                    height: 60.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: textWhiteColor,
                    ),
                    child: Image.asset(
                      'assets/ic_switch_cam.png',
                    ),
                  ),
                )
              else // Beri ruang kosong agar shutter tetap di tengah
                SizedBox(width: 36.r),

              // Tombol Shutter (tengah)
              GestureDetector(
                onTap: takePicture,
                child: Container(
                  width: 80.r,
                  height: 80.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: textWhiteColor,
                  ),
                  child: Image.asset('assets/ic_camera.png'),
                ),
              ),

              // Tombol Flash (kanan)
              GestureDetector(
                onTap: _toggleFlash,
                child: Container(
                  width: 60.r,
                  height: 60.r,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: textWhiteColor,
                  ),
                  child: Image.asset(
                    'assets/ic_flash.png',
                  ),
                ),
              )
            ],
          ),
        ),

        // Bottom Container (Pilih dari galeri / manual)
        Positioned(
          bottom: 30.r,
          left: 20.r,
          right: 20.r,
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8).r,
            decoration: BoxDecoration(
              color: textWhiteColor,
              borderRadius: BorderRadius.circular(24).r,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryFilledButton(
                    title: 'Select From Gallery',
                    onPressed: _selectFromGallery),
                SizedBox(height: 12.r),
                PrimaryFilledButton(
                  title: 'Add Manual',
                  backgroundColor: backgroundGreyColor,
                  textColor: textPrimaryColor,
                  onPressed: () {
                    routes.pushNamed(RouteNames.transaction);
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

// Class OverlayPainter tidak perlu diubah
class OverlayPainter extends CustomPainter {
  final Rect centerRect;
  OverlayPainter(this.centerRect);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(centerRect, const Radius.circular(12)))
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant OverlayPainter oldDelegate) {
    return oldDelegate.centerRect != centerRect;
  }
}
