import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

// Langkah 1: Buat enum untuk merepresentasikan state kamera dengan jelas
enum CameraStatus { initial, loading, success, failure }

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  // Langkah 2: Gunakan variabel state yang baru
  CameraStatus _cameraStatus = CameraStatus.initial;
  CameraController? _cameraController;
  String? _errorMessage;

  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // Atur UI status bar saat masuk halaman
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ));
    // Panggil satu fungsi inisialisasi yang bersih
    _initializeCamera();
  }

  @override
  void dispose() {
    // Kembalikan UI status bar ke default saat keluar halaman
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    _cameraController?.dispose();
    super.dispose();
  }

  // Langkah 3: Gabungkan semua logika inisialisasi ke satu fungsi async
  Future<void> _initializeCamera() async {
    // Jangan lakukan apa pun jika widget sudah di-dispose
    if (!mounted) return;

    setState(() {
      _cameraStatus = CameraStatus.loading;
    });

    try {
      final cameras = await availableCameras();
      if (cameras.isEmpty) {
        throw CameraException(
            'No Camera Found', 'No camera is available on this device.');
      }

      final cameraDescription = cameras[0]; // Gunakan kamera belakang utama

      // Hancurkan controller lama jika ada sebelum membuat yang baru
      await _cameraController?.dispose();

      _cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.medium,
        enableAudio: false, // Matikan audio jika tidak diperlukan
      );

      await _cameraController!.initialize();

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
      print("Camera Error: ${e.code} ${e.description}");
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = "An unexpected error occurred: $e";
          _cameraStatus = CameraStatus.failure;
        });
      }
      print("Unexpected Error: $e");
    }
  }

  // Fungsi takePicture dan _selectFromGallery tetap sama, tetapi lebih aman
  Future<void> takePicture() async {
    // Pemeriksaan state yang lebih aman
    if (_cameraStatus != CameraStatus.success ||
        _cameraController == null ||
        !_cameraController!.value.isTakingPicture) {
      return;
    }

    try {
      final XFile image = await _cameraController!.takePicture();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textPrimaryColor,
      body: _buildBody(),
    );
  }

  // Langkah 4: Gunakan state enum untuk membangun UI yang sesuai
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
              Text(
                'Failed to initialize camera',
                style: whiteTextStyle,
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _errorMessage!,
                    style: whiteTextStyle.copyWith(fontSize: 12.sp),
                    textAlign: TextAlign.center,
                  ),
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

  // UI utama kamera hanya akan di-build saat state success
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
          child: AspectRatio(
            aspectRatio: _cameraController!.value.aspectRatio,
            child: CameraPreview(_cameraController!),
          ),
        ),

        // Overlay
        Positioned.fill(
          child: CustomPaint(
            painter: OverlayPainter(centerRect),
          ),
        ),

        // Top buttons
        Positioned(
          top: 60.r,
          left: 24.r,
          child: CustomRoundedButton(
            onPressed: () => routes.pushReplacementNamed(RouteNames.main),
            widget: Icon(
              Icons.chevron_left,
              size: 32.r,
              color: textSecondaryColor,
            ),
            backgroundColor: backgroundWhiteColor,
          ),
        ),

        // App Logo
        Positioned(
          top: 60.r,
          right: 24.r,
          child: Image.asset('assets/ic_seimbangin-logo-logreg.png'),
        ),

        // Shutter Button
        Align(
          alignment: const Alignment(0, 0.35),
          child: GestureDetector(
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
        ),

        // Bottom Container
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
                  onPressed: _selectFromGallery,
                ),
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
      ..addRRect(
        RRect.fromRectAndRadius(centerRect, const Radius.circular(12)),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant OverlayPainter oldDelegate) {
    return oldDelegate.centerRect != centerRect;
  }
}
