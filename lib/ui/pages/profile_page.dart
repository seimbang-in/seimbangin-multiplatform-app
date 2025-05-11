import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/models/user_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        if (state is HomePageSuccess) {
          final user = state.user;
          return _ProfilePageContent(user: user);
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class _ProfilePageContent extends StatefulWidget {
  final User user;
  const _ProfilePageContent({
    required this.user,
  });

  @override
  State<_ProfilePageContent> createState() => __ProfilePageContentState();
}

class __ProfilePageContentState extends State<_ProfilePageContent> {
  XFile? _imageFile;
  bool _isEditingUsername = false;
  bool _isEditingFullName = false;
  bool _isEditingEmail = false;
  bool _isEditingPhone = false;

  late TextEditingController _usernameController;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  Future<void> _editImage() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

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
            title: 'Crop Your Photo',
            aspectRatioLockEnabled: false,
          ),
        ],
      );

      if (croppedFile != null) {
        setState(() {
          _imageFile = XFile(croppedFile.path);
        });
      }
    }
  }

  Future<void> _showLogoutDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap button to close
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding:
              const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                height: 66,
              ),
              Text(
                'Log Out\nYour Account?',
                style: blueTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 28,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              Text(
                'See you again another time!, friend✋🏻',
                style: blackTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: PrimaryFilledButton(
                        title: 'Cancel',
                        backgroundColor: backgroundGreyColor,
                        textColor: textPrimaryColor,
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimaryFilledButton(
                      title: 'Log Out',
                      onPressed: () {
                        Navigator.of(context).pop();
                        // Tambahkan logika logout di sini
                        routes.replaceNamed(RouteNames.login);
                      },
                      backgroundColor: backgroundWarningColor,
                      textColor: textWhiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _usernameController =
        TextEditingController(text: widget.user.data.username);
    _fullNameController =
        TextEditingController(text: widget.user.data.fullName);
    _emailController = TextEditingController(text: widget.user.data.email);
    _phoneController =
        TextEditingController(text: widget.user.data.phoneNumber ?? '');
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: secondaryColor,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: backgroundWhiteColor,
        body: ListView(
          children: [
            Container(
              width: double.infinity,
              height: 195.r,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [secondaryColor, backgroundWhiteColor],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(32),
                  bottomRight: Radius.circular(32),
                ).r,
              ),
              child: Column(
                children: [
                  _buildAvatar(),
                  SizedBox(
                    height: 10.r,
                  ),
                  Text(
                    widget.user.data.fullName!,
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.sp,
                    ),
                  ),
                  SizedBox(
                    height: 4.r,
                  ),
                  Text(
                    widget.user.data.email!,
                    style: greyTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.r,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //textfield username
                  Text(
                    'Username',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.r,
                  ),
                  TextField(
                    // controller: transactPriceController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      hintText: widget.user.data.username,
                      hintStyle: greyTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24).r,
                        borderSide: BorderSide(
                          color: textBlueColor,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //textfield fullname
                  SizedBox(
                    height: 12.r,
                  ),
                  Text(
                    'Fullname',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.r,
                  ),
                  TextField(
                    // controller: transactPriceController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      hintText: widget.user.data.fullName,
                      hintStyle: greyTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24).r,
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24).r,
                        borderSide: BorderSide(
                          color: textBlueColor,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.name,
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //textfield Email
                  SizedBox(
                    height: 10.r,
                  ),
                  Text(
                    'Email',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.r,
                  ),
                  TextField(
                    // controller: transactPriceController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      hintText: widget.user.data.email,
                      hintStyle: greyTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24).r,
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24).r,
                        borderSide: BorderSide(
                          color: textBlueColor,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  //textfield Phone Number
                  SizedBox(
                    height: 10.r,
                  ),
                  Text(
                    'Phone Number',
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(
                    height: 8.r,
                  ),
                  TextField(
                    // controller: transactPriceController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      hintText: '085947419321',
                      hintStyle: greyTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24).r,
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24).r,
                        borderSide: BorderSide(
                          color: textBlueColor,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  PrimaryFilledButton(
                    title: 'Log Out',
                    onPressed: _showLogoutDialog,
                    backgroundColor: backgroundWarningColor,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
          height: 112,
          width: 112,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundGreyColor,
            image: _imageFile != null
                ? DecorationImage(
                    image: FileImage(File(_imageFile!.path)),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
          child: _imageFile == null
              ? Icon(
                  Icons.person,
                  size: 48,
                  color: Colors.grey[600],
                )
              : null,
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: GestureDetector(
            onTap: _editImage,
            child: Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: backgroundWhiteColor,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/ic-edit-profile.png',
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Widget TextField untuk username
  Widget _buildUsernameField() {
    return TextField(
      controller: _usernameController,
      enabled: _isEditingUsername,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundGreyColor,
        hintText: widget.user.data.username,
        hintStyle: greyTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: textBlueColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isEditingUsername ? Icons.check : Icons.edit,
            color: _isEditingUsername ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            setState(() {
              _isEditingUsername = !_isEditingUsername;
              if (!_isEditingUsername) {
                // TODO Simpan perubahan ke backend
                _saveUsernameChanges();
              }
            });
          },
        ),
      ),
      style: blackTextStyle.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildFullNameField() {
    return TextField(
      controller: _fullNameController,
      enabled: _isEditingFullName,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundGreyColor,
        hintText: widget.user.data.username,
        hintStyle: greyTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: textBlueColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isEditingFullName ? Icons.check : Icons.edit,
            color: _isEditingFullName ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            setState(
              () {
                _isEditingFullName = !_isEditingFullName;
                if (!_isEditingFullName) {
                  // TODO FULLNAME
                  _saveFullNameChanges();
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextField(
      controller: _emailController,
      enabled: _isEditingEmail,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundGreyColor,
        hintText: widget.user.data.email,
        hintStyle: greyTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: textBlueColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isEditingEmail ? Icons.check : Icons.edit,
            color: _isEditingEmail ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            setState(
              () {
                _isEditingEmail = !_isEditingEmail;
                if (!_isEditingEmail) {
                  // TODO Email
                  _saveEmailChanges();
                }
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildPhoneNumberField() {
    return TextField(
      controller: _phoneController,
      enabled: _isEditingPhone,
      decoration: InputDecoration(
        filled: true,
        fillColor: backgroundGreyColor,
        hintText: widget.user.data.phoneNumber,
        hintStyle: greyTextStyle.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24),
          borderSide: BorderSide(color: textBlueColor),
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _isEditingPhone ? Icons.check : Icons.edit,
            color: _isEditingPhone ? Colors.green : Colors.grey,
          ),
          onPressed: () {
            setState(
              () {
                _isEditingPhone = !_isEditingPhone;
                if (!_isEditingPhone) {
                  // TODO Phone Number
                  _savePhoneNumberChanges();
                }
              },
            );
          },
        ),
      ),
    );
  }

  void _saveUsernameChanges() {
    // Implementasi logika penyimpanan ke backend
    final newUsername = _usernameController.text;
    print('New username: $newUsername');
    // Panggil API/Bloc untuk update data
  }

  void _saveFullNameChanges() {
    final newFullName = _fullNameController.text;
    print('New full name: $newFullName');
    // Panggil API/Bloc untuk update data
  }

  void _saveEmailChanges() {
    final newEmail = _emailController.text;
    print('New email name: $newEmail');
    // Panggil API/Bloc untuk update data
  }

  void _savePhoneNumberChanges() {
    final newPhoneNumber = _phoneController.text;
    print('New Phone name: $newPhoneNumber');
    // Panggil API/Bloc untuk update data
  }
}
