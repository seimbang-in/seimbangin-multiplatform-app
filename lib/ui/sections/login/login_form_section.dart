// lib/ui/pages/login/sections/_form_section.dart

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class LoginFormSection extends StatelessWidget {
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final bool isObscure;
  final bool isPhoneValid;
  final bool isPassValid;
  final bool isFormSubmitted;
  final VoidCallback onToggleObscure;

  const LoginFormSection({
    super.key,
    required this.phoneController,
    required this.passwordController,
    required this.isObscure,
    required this.isPhoneValid,
    required this.isPassValid,
    required this.isFormSubmitted,
    required this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: phoneController,
          decoration: InputDecoration(
            filled: true,
            fillColor: isFormSubmitted && !isPhoneValid
                ? backgroundPinkColor
                : backgroundGreyColor,
            prefixIcon: Icon(Icons.phone, size: 18.r),
            hintText: 'Phone Number',
            errorText: isFormSubmitted && !isPhoneValid
                ? '*Phone number cannot be empty'
                : null,
            hintStyle: isFormSubmitted && !isPhoneValid
                ? warningTextStyle.copyWith(
                    fontSize: 14.sp, fontWeight: FontWeight.w500)
                : greyTextStyle.copyWith(
                    fontSize: 14.sp, fontWeight: FontWeight.w500),
            errorStyle: warningTextStyle.copyWith(
                fontSize: 10.sp, fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide(color: textBlueColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide.none),
          ),
          keyboardType: TextInputType.phone,
          style: blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.h),
        TextField(
          controller: passwordController,
          obscureText: isObscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: isFormSubmitted && !isPassValid
                ? backgroundPinkColor
                : backgroundGreyColor,
            prefixIcon: Icon(Icons.lock_outline_rounded, size: 18.r),
            hintText: 'Password',
            errorText: isFormSubmitted && !isPassValid
                ? '*Password cannot be empty'
                : null,
            suffixIcon: IconButton(
              onPressed: onToggleObscure,
              icon: Icon(
                isObscure
                    ? Icons.remove_red_eye_outlined
                    : Icons.remove_red_eye_rounded,
                size: 18.r,
              ),
            ),
            hintStyle: isFormSubmitted && !isPassValid
                ? warningTextStyle.copyWith(
                    fontSize: 14.sp, fontWeight: FontWeight.w500)
                : greyTextStyle.copyWith(
                    fontSize: 14.sp, fontWeight: FontWeight.w500),
            errorStyle: warningTextStyle.copyWith(
                fontSize: 10.sp, fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide(color: textBlueColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide.none),
          ),
          style: blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                // TODO: Implement recovery password logic
              },
              child: Text(
                'Recovery Password',
                style: blueTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: textBlueColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
