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
                ? context.color.backgroundPinkColor
                : context.color.backgroundGreyColor,
            prefixIcon: Icon(Icons.person, size: 18.r),
            hintText: 'Username, No. HP, atau Email',
            errorText: isFormSubmitted && !isPhoneValid
                ? '*Username tidak boleh kosong'
                : null,
            hintStyle: isFormSubmitted && !isPhoneValid
                ? context.text.warningTextStyle.copyWith(
                    fontSize: 14.sp, fontWeight: FontWeight.w500)
                : context.text.greyTextStyle.copyWith(
                    fontSize: 14.sp, fontWeight: FontWeight.w500),
            errorStyle: context.text.warningTextStyle.copyWith(
                fontSize: 10.sp, fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide(color: context.color.textBlueColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide.none),
          ),
          keyboardType: TextInputType.text,
          style: context.text.blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.h),
        TextField(
          controller: passwordController,
          obscureText: isObscure,
          decoration: InputDecoration(
            filled: true,
            fillColor: isFormSubmitted && !isPassValid
                ? context.color.backgroundPinkColor
                : context.color.backgroundGreyColor,
            prefixIcon: Icon(Icons.lock_outline_rounded, size: 18.r),
            hintText: 'Kata Sandi',
            errorText: isFormSubmitted && !isPassValid
                ? '*Kata sandi tidak boleh kosong'
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
                ? context.text.warningTextStyle.copyWith(
                    fontSize: 14.sp, fontWeight: FontWeight.w500)
                : context.text.greyTextStyle.copyWith(
                    fontSize: 14.sp, fontWeight: FontWeight.w500),
            errorStyle: context.text.warningTextStyle.copyWith(
                fontSize: 10.sp, fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide(color: context.color.textBlueColor)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide.none),
          ),
          style: context.text.blackTextStyle.copyWith(
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
                'Lupa Kata Sandi?',
                style: context.text.blueTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: context.color.textBlueColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
