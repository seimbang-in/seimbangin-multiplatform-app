import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class FinancialProfileHeaderSection extends StatelessWidget {
  const FinancialProfileHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20.r),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: backgroundGreyColor,
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            'assets/img_mascot-login.png',
            height: 120.h,
          ),
        ),
        SizedBox(height: 24.r),
        Text(
          'Financial Profile',
          style: blackTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 22.sp,
          ),
        ),
        SizedBox(height: 8.r),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Lengkapi Profil Finansialmu untuk membantu Blu memberikan saran keuangan terbaik!',
            style: greyTextStyle.copyWith(
              fontWeight: FontWeight.normal,
              fontSize: 14.sp,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
