// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:seimbangin_app/models/user_model.dart';
// import 'package:seimbangin_app/ui/pages/profile_page.dart'; // Impor enum
// import 'package:seimbangin_app/ui/widgets/textfield_widget.dart';

// class ProfileFormSection extends StatefulWidget {
//   final User user;
//   final EditableProfileField editingField;
//   final ValueChanged<EditableProfileField> onToggleEditMode;
//   final TextEditingController usernameController;
//   final TextEditingController fullNameController;
//   final TextEditingController emailController;
//   final TextEditingController phoneController;

//   const ProfileFormSection({
//     super.key,
//     required this.user,
//     required this.editingField,
//     required this.onToggleEditMode,
//     required this.usernameController,
//     required this.fullNameController,
//     required this.emailController,
//     required this.phoneController,
//   });

//   @override
//   State<ProfileFormSection> createState() => _ProfileFormSectionState();
// }

// class _ProfileFormSectionState extends State<ProfileFormSection> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 24),
//       child: Column(
//         children: [
//           EditableProfileTextField(
//             label: 'Username',
//             controller: widget.usernameController,
//             hintText: widget.user.data.username ?? 'Enter username',
//             isEditing: widget.editingField == EditableProfileField.username,
//             onEditToggle: () =>
//                 widget.onToggleEditMode(EditableProfileField.username),
//           ),
//           SizedBox(height: 12.r),
//           EditableProfileTextField(
//             label: 'Full Name',
//             controller: widget.fullNameController,
//             hintText: widget.user.data.fullName ?? 'Enter full name',
//             isEditing: widget.editingField == EditableProfileField.fullName,
//             onEditToggle: () =>
//                 widget.onToggleEditMode(EditableProfileField.fullName),
//           ),
//           SizedBox(height: 12.r),
//           EditableProfileTextField(
//             label: 'Email',
//             controller: widget.emailController,
//             hintText: widget.user.data.email ?? 'Enter email',
//             isEditing: widget.editingField == EditableProfileField.email,
//             keyboardType: TextInputType.emailAddress,
//             onEditToggle: () =>
//                 widget.onToggleEditMode(EditableProfileField.email),
//           ),
//           SizedBox(height: 12.r),
//           EditableProfileTextField(
//             label: 'Phone Number',
//             controller: widget.phoneController,
//             hintText: widget.user.data.phoneNumber ?? 'Enter phone number',
//             isEditing: widget.editingField == EditableProfileField.phone,
//             keyboardType: TextInputType.phone,
//             onEditToggle: () =>
//                 widget.onToggleEditMode(EditableProfileField.phone),
//           ),
//         ],
//       ),
//     );
//   }
// }
