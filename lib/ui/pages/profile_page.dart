import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/blocs/logout/logout_bloc.dart';
import 'package:seimbangin_app/models/user_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/profile/profile_action_section.dart';
import 'package:seimbangin_app/ui/sections/profile/profile_header_section.dart';
import 'package:seimbangin_app/ui/widgets/alert_dialog_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: secondaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: BlocListener<LogoutBloc, LogoutState>(
        listener: (context, state) {
          if (state is! LogoutLoading) {
            AlertDialogWidget.dismiss(context);
          }

          if (state is LogoutLoading) {
            AlertDialogWidget.showLoading(context, message: "Logging out...");
          } else if (state is LogoutSuccess) {
            routes.goNamed(RouteNames.login);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Logout berhasil!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is LogoutFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: backgroundWarningColor,
              ),
            );

            routes.goNamed(RouteNames.login);
          }
        },
        child: Scaffold(
          backgroundColor: backgroundWhiteColor,
          body: BlocBuilder<HomepageBloc, HomepageState>(
            builder: (context, state) {
              if (state is HomePageSuccess) {
                return _ProfilePageContent(user: state.user);
              }
              // Tampilkan loading jika data user belum siap
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}

class _ProfilePageContent extends StatefulWidget {
  final User user;
  const _ProfilePageContent({required this.user});

  @override
  State<_ProfilePageContent> createState() => __ProfilePageContentState();
}

class __ProfilePageContentState extends State<_ProfilePageContent> {
  XFile? _imageFile;

  Future<void> _editImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 85);
    if (pickedFile != null) {
      final CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Crop Your Photo',
            toolbarColor: backgroundWhiteColor,
            toolbarWidgetColor: buttonColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
              title: 'Crop Your Photo', aspectRatioLockEnabled: false),
        ],
      );
      if (croppedFile != null) {
        setState(() => _imageFile = XFile(croppedFile.path));
        // TODO: Tambahkan logika untuk upload _imageFile ke backend
      }
    }
  }

  Future<void> _showLogoutDialog() async {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text('Logout',
            style: blackTextStyle.copyWith(fontWeight: FontWeight.bold)),
        content:
            Text('Are you sure you want to logout?', style: blackTextStyle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text('Cancel', style: greyTextStyle),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();

              context.read<LogoutBloc>().add(LogoutButtonPressed());
            },
            child: Text('Logout', style: warningTextStyle),
          ),
        ],
      ),
    );
  }

  Widget _buildOptionContainer({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 18.r),
        margin: EdgeInsets.only(bottom: 16.r),
        decoration: BoxDecoration(
          color: backgroundGreyColor,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: textSecondaryColor, size: 24.r),
            SizedBox(width: 12.r),
            Expanded(
              child: Text(
                title,
                style: blackTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(Icons.chevron_right, color: textSecondaryColor, size: 24.r),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        ProfileHeaderSection(
          user: widget.user,
          imageFile: _imageFile,
          onEditImage: _editImage,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 30.r),
          child: Column(
            children: [
              _buildOptionContainer(
                title: 'Edit Profile',
                icon: Icons.person_outline,
                onTap: () {
                  routes.pushNamed(RouteNames.profileEdit, extra: widget.user);
                },
              ),
              _buildOptionContainer(
                title: 'Edit Financial Profile',
                icon: Icons.account_balance_wallet_outlined,
                onTap: () {
                  routes.pushNamed(RouteNames.financialProfile);
                },
              ),
              SizedBox(height: 24.r),
              ProfileActionSection(
                onLogout: _showLogoutDialog,
              ),
              SizedBox(height: 40.r),
            ],
          ),
        ),
      ],
    );
  }
}
