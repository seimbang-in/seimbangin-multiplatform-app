import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/bottom_navigation.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  XFile? _imageFile;

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

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: secondaryColor, // Warna status bar
      statusBarIconBrightness:
          Brightness.light, // Warna ikon status bar (Android)
      statusBarBrightness: Brightness.light,
    ));
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: ListView(
        children: [
          Container(
            width: double.infinity,
            height: 184,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [secondaryColor, backgroundWhiteColor],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              children: [
                _buildAvatar(),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Mf.humam',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'mfawwazhumam@gmail.com',
                  style: greyTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
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
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // controller: transactPriceController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'Mf.humam',
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
                      borderSide: BorderSide(
                        color: textBlueColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //textfield fullname
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Full Name',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // controller: transactPriceController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'Fawwaz Humam',
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
                      borderSide: BorderSide(
                        color: textBlueColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.name,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //textfield Email
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Email',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // controller: transactPriceController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'mfawwazhumam@gmail.com',
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
                      borderSide: BorderSide(
                        color: textBlueColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                //textfield Phone Number
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Phone Number',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextField(
                  // controller: transactPriceController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: '085947419321',
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
                      borderSide: BorderSide(
                        color: textBlueColor,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.phone,
                  style: blackTextStyle.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                PrimaryFilledButton(
                  title: 'Log Out',
                  onPressed: () {},
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
      bottomNavigationBar: const CustomBottomNavigationBar(),
      floatingActionButton: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: buttonColor.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4)),
        ]),
        child: FloatingActionButton(
            onPressed: () {
              routes.pushNamed(RouteNames.ocr);
            },
            backgroundColor: Colors.white,
            elevation: 4,
            shape: const CircleBorder(),
            child: Image.asset(
              'assets/icon-scan.png',
              width: 24,
              height: 24,
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
}
