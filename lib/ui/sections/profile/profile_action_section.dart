import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class ProfileActionSection extends StatelessWidget {
  final VoidCallback onLogout;
  const ProfileActionSection({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24).r,
      child: PrimaryFilledButton(
        title: 'Log Out',
        onPressed: onLogout,
        backgroundColor: backgroundWarningColor,
      ),
    );
  }
}
