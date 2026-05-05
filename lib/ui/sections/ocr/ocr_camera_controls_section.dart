import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class OcrCameraControlsSection extends StatelessWidget {
  final int cameraCount;
  final FlashMode currentFlashMode;
  final VoidCallback onSwitchCamera;
  final VoidCallback onTakePicture;
  final VoidCallback onToggleFlash;
  final VoidCallback onSelectFromGallery;

  const OcrCameraControlsSection({
    super.key,
    required this.cameraCount,
    required this.currentFlashMode,
    required this.onSwitchCamera,
    required this.onTakePicture,
    required this.onToggleFlash,
    required this.onSelectFromGallery,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.only(top: 32.r, bottom: 40.r, left: 24.r, right: 24.r),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.0),
            Colors.black.withOpacity(0.85)
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Switch Camera Button
              if (cameraCount > 1)
                GestureDetector(
                  onTap: onSwitchCamera,
                  child: CircleAvatar(
                    radius: 28.r,
                    backgroundColor: Colors.white.withOpacity(0.2),
                    child: Icon(Icons.flip_camera_ios_rounded,
                        color: Colors.white, size: 28.r),
                  ),
                )
              else
                SizedBox(width: 56.r),

              // Shutter Button
              GestureDetector(
                onTap: onTakePicture,
                child: Container(
                  width: 76.r,
                  height: 76.r,
                  padding: EdgeInsets.all(4.r),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              // Flash Button
              GestureDetector(
                onTap: onToggleFlash,
                child: CircleAvatar(
                  radius: 28.r,
                  backgroundColor: currentFlashMode == FlashMode.torch
                      ? Colors.white
                      : Colors.white.withOpacity(0.2),
                  child: Icon(
                    currentFlashMode == FlashMode.torch
                        ? Icons.flash_on_rounded
                        : Icons.flash_off_rounded,
                    color: currentFlashMode == FlashMode.torch
                        ? Colors.black
                        : Colors.white,
                    size: 28.r,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 36.r),
          // Alternative Input Block
          Container(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16).r,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24).r,
            ),
            child: Column(
              children: [
                PrimaryFilledButton(
                  title: 'Pilih dari Galeri',
                  onPressed: onSelectFromGallery,
                  icon: Icons.photo_library_rounded,
                ),
                SizedBox(height: 12.r),
                PrimaryFilledButton(
                  title: 'Masukan Manual',
                  backgroundColor: context.color.backgroundGreyColor,
                  textColor: context.color.textPrimaryColor,
                  icon: Icons.edit_note_rounded,
                  onPressed: () {
                    routes.pushReplacementNamed(RouteNames.transaction);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
