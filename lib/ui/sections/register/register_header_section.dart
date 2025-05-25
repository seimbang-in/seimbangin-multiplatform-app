import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class RegisterHeaderSection extends StatelessWidget {
  final VoidCallback onBack;

  const RegisterHeaderSection({
    super.key,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 21.r),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomRoundedButton(
              onPressed: onBack,
              widget: Icon(
                Icons.chevron_left,
                size: 32.r,
                color: textSecondaryColor,
              ),
              backgroundColor: backgroundWhiteColor,
            ),
            Image.asset('assets/ic_seimbangin-logo-logreg.png'),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/img_mascot-login.png'),
            Text(
              'Create Account',
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 28.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
