import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart'; // Tetap dibutuhkan jika header menggunakannya
import 'package:image_picker/image_picker.dart'; // Tetap dibutuhkan jika header menggunakannya
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/models/user_model.dart';
import 'package:seimbangin_app/routes/routes.dart'; // Pastikan import RouteNames
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/profile/profile_action_section.dart'; // Untuk logout
import 'package:seimbangin_app/ui/sections/profile/profile_header_section.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    // Selalu tampilkan SystemUIOverlayStyle di atas Scaffold
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor:
            secondaryColor, // Warna status bar saat di halaman profil
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: backgroundWhiteColor,
        body: BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, state) {
            if (state is HomePageSuccess) {
              return _ProfilePageContent(user: state.user);
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

// Widget konten untuk ProfilePage
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
        // TODO: Tambahkan logika untuk upload _imageFile ke backend dan update BLoC
        // Misalnya: context.read<ProfileBloc>().add(UpdateProfilePictureEvent(_imageFile!));
        // Untuk saat ini, hanya update tampilan lokal.
      }
    }
  }

  Future<void> _showLogoutDialog() async {
    // Implementasi dialog logout Anda
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout',
            style: blackTextStyle.copyWith(fontWeight: FontWeight.bold)),
        content:
            Text('Are you sure you want to logout?', style: blackTextStyle),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel', style: greyTextStyle),
          ),
          TextButton(
            onPressed: () {
              // TODO: Panggil BLoC untuk logout
              // context.read<AuthBloc>().add(LogoutEvent());
              Navigator.of(context).pop();
              routes.goNamed(RouteNames.login);
            },
            child: Text('Logout', style: warningTextStyle),
          ),
        ],
      ),
    );
  }

  // Helper widget untuk membuat container button
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
        margin: EdgeInsets.only(bottom: 16.r), // Jarak antar container
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
                  // Kirim data user ke halaman EditProfilePage
                  routes.pushNamed(RouteNames.profileEdit, extra: widget.user);
                },
              ),
              _buildOptionContainer(
                title: 'Edit Financial Profile',
                icon: Icons.account_balance_wallet_outlined,
                onTap: () {
                  // Arahkan ke halaman profil finansial yang sudah ada
                  routes.pushNamed(RouteNames.financialProfile);
                },
              ),
              SizedBox(height: 24.r), // Beri jarak sebelum tombol logout
              ProfileActionSection(
                onLogout: _showLogoutDialog, // Fungsi logout
              ),
              SizedBox(height: 40.r), // Padding bawah
            ],
          ),
        ),
      ],
    );
  }
}
