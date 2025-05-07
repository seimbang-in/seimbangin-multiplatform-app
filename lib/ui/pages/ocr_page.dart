import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class OcrPage extends StatefulWidget {
  const OcrPage({super.key});

  @override
  State<OcrPage> createState() => _OcrPageState();
}

class _OcrPageState extends State<OcrPage> {
  CameraController? cameraController;
  List? cameras;
  int? selectedCameraIndex;
  XFile? capturedImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black, // Warna status bar
      statusBarIconBrightness:
          Brightness.light, // Warna ikon status bar (Android)
      statusBarBrightness: Brightness.light, // Warna ikon status bar (iOS)
    ));
    availableCameras().then((value) {
      cameras = value;
      if (cameras!.isNotEmpty) {
        selectedCameraIndex = 0;
        initCamera(cameras![selectedCameraIndex!]).then((_) {});
      } else {
        print('No camera available!');
      }
    }).catchError((e) {
      print(e.code);
    });
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
    cameraController?.dispose();
    super.dispose();
  }

// init camera function
  Future initCamera(CameraDescription cameraDescription) async {
    if (cameraController != null) {
      await cameraController!.dispose();
    }
    cameraController =
        CameraController(cameraDescription, ResolutionPreset.medium);

    cameraController!.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await cameraController!.initialize();
    } catch (e) {
      print('Camera error $e');
    }
    if (mounted) setState(() {});
  }

// take picture function
  Future<void> takePicture() async {
    if (!cameraController!.value.isInitialized) return;

    try {
      final XFile image = await cameraController!.takePicture();
      routes.pushNamed(
        RouteNames.ocrPreview,
        extra: image.path,
      );
    } catch (e) {
      print('Error taking picture: $e');
    }
  }

  // select from gallery function

  Future<void> _selectFromGallery() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
        imageQuality: 85,
      );

      if (pickedFile != null) {
        routes.pushNamed(
          RouteNames.ocrPreview,
          extra: pickedFile.path,
        );
      }
    } on PlatformException catch (e) {
      print('Error picking image: $e');
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width * 0.7;
    final height = (width * 2) / 2;
    final centerRect = Rect.fromCenter(
      center: Offset(screenSize.width / 2, screenSize.height / 2),
      width: width,
      height: height,
    );
    return Scaffold(
      backgroundColor: textPrimaryColor,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.center,
            child: cameraScreen(),
          ),

          Positioned.fill(
            child: CustomPaint(
              painter: OverlayPainter(centerRect),
            ),
          ),

          // Top buttons
          Positioned(
            top: 60,
            left: 24,
            child: CustomRoundedButton(
              onPressed: () {
                routes.pop();
              },
              widget: Icon(
                Icons.chevron_left,
                size: 32,
              ),
              backgroundColor: backgroundWhiteColor,
            ),
          ),

          // App Logo
          Positioned(
            top: 60,
            right: 24,
            child: Image.asset(
              'assets/ic_seimbangin-logo-logreg.png',
            ),
          ),

          // Shutter Button
          Align(
            alignment: const Alignment(0, 0.35),
            child: GestureDetector(
              onTap: () => takePicture(), // Add camera capture logic
              child: Container(
                width: 80,
                height: 80,
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
            bottom: 30,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                color: textWhiteColor,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  PrimaryFilledButton(
                    title: 'Select From Gallery',
                    onPressed: () {
                      _selectFromGallery();
                    },
                  ),
                  const SizedBox(height: 12),
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
      ),
    );
  }

  Widget cameraScreen() {
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return const CircularProgressIndicator();
    }
    return AspectRatio(
      aspectRatio: 0.8 / cameraController!.value.aspectRatio,
      child: CameraPreview(cameraController!),
    );
  }
}

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
