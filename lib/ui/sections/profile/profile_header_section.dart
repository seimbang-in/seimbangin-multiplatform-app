import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/models/user_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class ProfileHeaderSection extends StatelessWidget {
  final User user;
  final XFile? imageFile;
  final VoidCallback onEditImage;

  const ProfileHeaderSection({
    super.key,
    required this.user,
    this.imageFile,
    required this.onEditImage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 220.r, // Sesuaikan tinggi agar lebih pas
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [secondaryColor, backgroundWhiteColor],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ).r,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildAvatar(),
          SizedBox(height: 10.r),
          Text(
            user.data.fullName ?? 'User Name',
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
          SizedBox(height: 4.r),
          Text(
            user.data.email ?? 'user@email.com',
            style: greyTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk avatar dipindahkan ke dalam section ini
  Widget _buildAvatar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 112,
          width: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundGreyColor,
            border: Border.all(color: Colors.white, width: 4),
            image: imageFile != null
                ? DecorationImage(
                    image: FileImage(File(imageFile!.path)),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: imageFile == null
              ? Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.grey[600],
                )
              : null,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: onEditImage,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: backgroundWhiteColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/ic-edit-profile.png',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
