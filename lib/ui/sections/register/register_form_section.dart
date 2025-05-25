import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class RegisterFormSection extends StatelessWidget {
  final TextEditingController fullNameController;
  final TextEditingController usernameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;
  final TextEditingController passwordController;
  final String? fullNameError;
  final String? usernameError;
  final String? emailError;
  final String? phoneError;
  final String? passwordError;
  final bool isObscure;
  final VoidCallback onToggleObscure;

  const RegisterFormSection({
    super.key,
    required this.fullNameController,
    required this.usernameController,
    required this.emailController,
    required this.phoneController,
    required this.passwordController,
    this.fullNameError,
    this.usernameError,
    this.emailError,
    this.phoneError,
    this.passwordError,
    required this.isObscure,
    required this.onToggleObscure,
  });

  @override
  Widget build(BuildContext context) {
    // Helper untuk membuat InputDecoration agar tidak berulang
    InputDecoration _buildInputDecoration(
        {required String hintText, String? errorText}) {
      return InputDecoration(
        filled: true,
        fillColor: backgroundGreyColor,
        hintText: hintText,
        errorText: errorText,
        errorStyle: warningTextStyle.copyWith(
            fontSize: 10.sp, fontWeight: FontWeight.w500),
        hintStyle: greyTextStyle.copyWith(
            fontSize: 14.sp, fontWeight: FontWeight.w500),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24).r,
            borderSide: BorderSide.none),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24).r,
            borderSide: BorderSide(color: textBlueColor)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24).r,
            borderSide: BorderSide.none),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(24).r,
            borderSide: BorderSide(color: textBlueColor)),
      );
    }

    return Column(
      children: [
        TextField(
          controller: fullNameController,
          decoration: _buildInputDecoration(
              hintText: 'Full Name', errorText: fullNameError),
          style: blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.r),
        TextField(
          controller: usernameController,
          decoration: _buildInputDecoration(
              hintText: 'Username', errorText: usernameError),
          style: blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.r),
        TextField(
          controller: emailController,
          decoration: _buildInputDecoration(
              hintText: 'Email Address', errorText: emailError),
          keyboardType: TextInputType.emailAddress,
          style: blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.r),
        TextField(
          controller: phoneController,
          decoration: _buildInputDecoration(
              hintText: 'Phone Number', errorText: phoneError),
          keyboardType: TextInputType.phone,
          style: blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.r),
        TextField(
          controller: passwordController,
          obscureText: isObscure,
          decoration: _buildInputDecoration(
                  hintText: 'Password', errorText: passwordError)
              .copyWith(
            suffixIcon: IconButton(
              onPressed: onToggleObscure,
              icon: Icon(
                  isObscure
                      ? Icons.remove_red_eye_rounded
                      : Icons.remove_red_eye_outlined,
                  size: 18.r),
            ),
            suffixIconColor: textPrimaryColor,
          ),
          style: blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
