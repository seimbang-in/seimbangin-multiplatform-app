import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/user_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class ProfileEditPage extends StatelessWidget {
  final User userData;

  const ProfileEditPage({super.key, required this.userData});

  Widget _buildProfileFieldBlock(
    BuildContext context, {
    required String label,
    required String? value,
    required VoidCallback onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.r),
        InkWell(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 18.r, horizontal: 18.r),
            decoration: BoxDecoration(
              color: backgroundGreyColor,
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    value ?? 'Not set',
                    style: greyTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8.r),
                Icon(Icons.edit_rounded, color: textSecondaryColor, size: 22.r),
              ],
            ),
          ),
        ),
        SizedBox(height: 20.r),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final userProfileData = userData.data;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarPrimaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: backgroundWhiteColor,
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 20.r),
            children: [
              // --- HEADER CUSTOM ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRoundedButton(
                    onPressed: () => routes.pop(),
                    widget: Icon(
                      Icons.chevron_left,
                      size: 32.r,
                      color: textSecondaryColor,
                    ),
                    backgroundColor: backgroundWhiteColor,
                  ),
                  Text(
                    'Edit Profile',
                    style: blackTextStyle.copyWith(
                      fontSize:
                          16.sp, // Ukuran font disesuaikan dengan header lama
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Image.asset('assets/ic_seimbangin-logo-logreg.png'),
                ],
              ),
              SizedBox(height: 24.r),
              // --- AKHIR DARI HEADER CUSTOM ---

              _buildProfileFieldBlock(
                context,
                label: 'Username',
                value: userProfileData.username,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Navigate to Edit Username Page (TODO)')),
                  );
                },
              ),
              _buildProfileFieldBlock(
                context,
                label: 'Full Name',
                value: userProfileData.fullName,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Navigate to Edit Full Name Page (TODO)')),
                  );
                },
              ),
              _buildProfileFieldBlock(
                context,
                label: 'Email',
                value: userProfileData.email,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Navigate to Edit Email Page (TODO)')),
                  );
                },
              ),
              _buildProfileFieldBlock(
                context,
                label: 'Phone Number',
                value: userProfileData.phoneNumber,
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content:
                            Text('Navigate to Edit Phone Number Page (TODO)')),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
