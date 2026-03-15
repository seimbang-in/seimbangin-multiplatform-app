import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class ChatWelcomeSection extends StatelessWidget {
  const ChatWelcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img_mascot-login.png', width: 220.w),
          SizedBox(height: 24.h),
          Text(
            "Halo! Salam kenal!",
            style: blackTextStyle.copyWith(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              "Saya Blu, AI penasihat keuangan Anda.\nTanyakan apa saja seputar keuangan Anda!",
              textAlign: TextAlign.center,
              style: greyTextStyle.copyWith(fontSize: 14.sp, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}
