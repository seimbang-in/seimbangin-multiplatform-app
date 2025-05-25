import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class LoginFooterSection extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onGoogleSignIn;
  final VoidCallback onRegister;

  const LoginFooterSection({
    super.key,
    required this.onLogin,
    required this.onGoogleSignIn,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryFilledButton(
          title: 'Login',
          onPressed: onLogin,
        ),
        SizedBox(height: 22.h),
        Text(
          'Or Sign Up With',
          style: greyTextStyle.copyWith(
              fontSize: 12.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 16.h),
        Center(
          child: CustomRoundedButton(
            onPressed: onGoogleSignIn,
            widget: Image.asset('assets/ic_google.png'),
            backgroundColor: backgroundGreyColor,
          ),
        ),
        SizedBox(height: 31.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't have an account?",
              style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 12.sp),
            ),
            TextButton(
              onPressed: onRegister,
              child: Text(
                'Register',
                style: blueTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
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
