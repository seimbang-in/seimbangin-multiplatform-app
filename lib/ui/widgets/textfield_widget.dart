import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class EditableProfileTextField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isEditing;
  final VoidCallback onEditToggle;
  final TextInputType keyboardType;
  final String hintText;

  const EditableProfileTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.isEditing,
    required this.onEditToggle,
    this.keyboardType = TextInputType.text,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: blackTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(height: 8.r),
        TextField(
          controller: controller,
          enabled:
              isEditing, // TextField bisa diedit atau tidak tergantung state ini
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundGreyColor,
            hintText: hintText,
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            // Tampilan border saat disabled
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24.r),
              borderSide: BorderSide(color: textBlueColor),
            ),
            // Suffix icon yang berubah sesuai mode edit
            suffixIcon: IconButton(
              icon: Icon(
                isEditing ? Icons.check_circle : Icons.edit, // Ganti ikon
                color: isEditing
                    ? textGreenColor
                    : textSecondaryColor, // Ganti warna
              ),
              onPressed: onEditToggle, // Panggil callback saat ditekan
            ),
          ),
          keyboardType: keyboardType,
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            // Ubah warna teks saat disabled agar terlihat seperti teks biasa
            color: isEditing ? textPrimaryColor : textSecondaryColor,
          ),
        ),
      ],
    );
  }
}
