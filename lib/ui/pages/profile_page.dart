import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/models/user_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/profile/profile_action_section.dart';
import 'package:seimbangin_app/ui/sections/profile/profile_form_section.dart';
import 'package:seimbangin_app/ui/sections/profile/profile_header_section.dart';

// Enum untuk mengelola state field mana yang sedang diedit.
enum EditableProfileField { none, username, fullName, email, phone }

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
          // Teruskan data user ke widget konten yang sebenarnya
          return _ProfilePageContent(user: state.user);
        }
        // Tampilkan loading jika data user belum siap
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}

// Widget ini bertanggung jawab untuk state dan logika halaman profil
class _ProfilePageContent extends StatefulWidget {
  final User user;
  const _ProfilePageContent({required this.user});

  @override
  State<_ProfilePageContent> createState() => __ProfilePageContentState();
}

class __ProfilePageContentState extends State<_ProfilePageContent> {
  // --- STATE ---
  XFile? _imageFile;
  EditableProfileField _editingField = EditableProfileField.none;

  late TextEditingController _usernameController;
  late TextEditingController _fullNameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  // --- LIFECYCLE ---
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

  // --- LOGIC METHODS ---
  void _toggleEditMode(EditableProfileField field) {
    setState(() {
      if (_editingField == field) {
        // TODO: Panggil BLoC/API untuk update profile di sini
        print(
            "Saving changes for ${field.name} with value: ${_getControllerForField(field).text}");
        _editingField = EditableProfileField.none; // Kembali ke mode view
      } else {
        if (_editingField != EditableProfileField.none) {
          // TODO: Logika untuk menyimpan field sebelumnya jika diperlukan
          print("Saving previous field: ${_editingField.name}");
        }
        _editingField = field; // Masuk ke mode edit untuk field yang baru
      }
    });
  }

  // Helper untuk mendapatkan controller yang sesuai
  TextEditingController _getControllerForField(EditableProfileField field) {
    switch (field) {
      case EditableProfileField.username:
        return _usernameController;
      case EditableProfileField.fullName:
        return _fullNameController;
      case EditableProfileField.email:
        return _emailController;
      case EditableProfileField.phone:
        return _phoneController;
      case EditableProfileField.none:
        return TextEditingController(); // Seharusnya tidak terjadi
    }
  }

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
      }
    }
  }

  Future<void> _showLogoutDialog() async {
    // Implementasi dialog logout Anda di sini
  }

  // --- BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: secondaryColor,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: backgroundWhiteColor,
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            // SECTION 1: HEADER
            ProfileHeaderSection(
              user: widget.user,
              imageFile: _imageFile,
              onEditImage: _editImage,
            ),
            SizedBox(height: 20.r),

            // SECTION 2: FORM
            ProfileFormSection(
              user: widget.user,
              editingField: _editingField,
              onToggleEditMode: _toggleEditMode,
              usernameController: _usernameController,
              fullNameController: _fullNameController,
              emailController: _emailController,
              phoneController: _phoneController,
            ),
            SizedBox(height: 40.h),

            // SECTION 3: ACTION
            ProfileActionSection(
              onLogout: _showLogoutDialog,
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
