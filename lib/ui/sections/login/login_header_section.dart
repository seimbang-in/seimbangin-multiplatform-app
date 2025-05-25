import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class LoginHeaderSection extends StatelessWidget {
  const LoginHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 21.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Image.asset('assets/ic_seimbangin-logo-logreg.png'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/img_mascot-login.png'),
            Text(
              'Welcome',
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Let’s get started with Seimbangin',
              style: greyTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
