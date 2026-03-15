import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class LoginFooterSection extends StatelessWidget {
  final VoidCallback onLogin;
  final VoidCallback onRegister;

  const LoginFooterSection({
    super.key,
    required this.onLogin,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryFilledButton(
          title: 'Masuk',
          onPressed: onLogin,
        ),
        SizedBox(height: 31.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Belum punya akun?",
              style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w600, fontSize: 12.sp),
            ),
            TextButton(
              onPressed: onRegister,
              child: Text(
                'Daftar',
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
