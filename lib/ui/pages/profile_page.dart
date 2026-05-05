import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/models/user/user_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/blocs/theme/theme_cubit.dart';
import 'package:seimbangin_app/ui/sections/profile/profile_header_section.dart';
import 'package:seimbangin_app/ui/sections/profile/profile_menu_section.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: context.color.secondaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: context.color.backgroundWhiteColor,
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
    );
  }
}

class _ProfilePageContent extends StatefulWidget {
  final UserResponse user;
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
            toolbarColor: context.color.backgroundWhiteColor,
            toolbarWidgetColor: context.color.buttonColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false,
          ),
          IOSUiSettings(
              title: 'Crop Your Photo', aspectRatioLockEnabled: false),
        ],
      );
      if (croppedFile != null) {
        setState(() => _imageFile = XFile(croppedFile.path));
        // TODO: logic add image to backend
      }
    }
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
              ProfileMenuSection(
                title: 'Edit Profile',
                icon: Icons.person_outline,
                onTap: () {
                  routes.pushNamed(RouteNames.profileEdit, extra: widget.user);
                },
              ),
              ProfileMenuSection(
                title: 'Edit Financial Profile',
                icon: Icons.account_balance_wallet_outlined,
                onTap: () {
                  routes.pushNamed(RouteNames.financialProfile);
                },
              ),
              ProfileMenuSection(
                title: 'Kategori Transaksi',
                icon: Icons.category_rounded,
                onTap: () {
                  routes.pushNamed(RouteNames.categoryManagement);
                },
              ),
              SizedBox(height: 16.r),
              BlocBuilder<ThemeCubit, ThemeMode>(
                builder: (context, mode) {
                  final isDark = mode == ThemeMode.dark;
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
                    decoration: BoxDecoration(
                      color: context.color.backgroundWhiteColor,
                      borderRadius: BorderRadius.circular(16).r,
                      border: Border.all(color: context.color.backgroundGreyColor),
                    ),
                    child: SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      value: isDark,
                      onChanged: (value) {
                        context.read<ThemeCubit>().toggleTheme();
                      },
                      title: Text(
                        'Dark Mode',
                        style: context.text.blackTextStyle.copyWith(fontWeight: FontWeight.w600, fontSize: 14.sp),
                      ),
                      secondary: Container(
                        padding: EdgeInsets.all(8.r),
                        decoration: BoxDecoration(
                          color: context.color.backgroundGreyColor,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          isDark ? Icons.dark_mode_outlined : Icons.light_mode_outlined,
                          color: context.color.textPrimaryColor,
                          size: 24.r,
                        ),
                      ),
                      activeColor: context.color.primaryColor,
                    ),
                  );
                },
              ),
              SizedBox(height: 40.r),
            ],
          ),
        ),
      ],
    );
  }
}
