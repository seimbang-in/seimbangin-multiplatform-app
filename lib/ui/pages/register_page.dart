import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/register/register_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/register/register_footer_page.dart';
import 'package:seimbangin_app/ui/sections/register/register_form_section.dart';
import 'package:seimbangin_app/ui/sections/register/register_header_section.dart';
import 'package:seimbangin_app/ui/widgets/alert_dialog_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // --- STATE & CONTROLLERS ---
  bool isObscure = true;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // --- ERROR STATE ---
  String? _fullNameError;
  String? _usernameError;
  String? _emailError;
  String? _phoneError;
  String? _passwordError;

  // --- VALIDATION LOGIC ---
  bool _validateForm() {
    bool isFullNameValid = fullNameController.text.isNotEmpty;
    bool isUsernameValid = usernameController.text.isNotEmpty;
    bool isEmailValid =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
            .hasMatch(emailController.text);
    bool isPhoneValid = phoneNumberController.text.length >= 11 &&
        phoneNumberController.text.length <= 13;
    bool isPasswordValid = passwordController.text.length >= 8;

    setState(() {
      _fullNameError = isFullNameValid ? null : '*Full name cannot be empty';
      _usernameError = isUsernameValid ? null : '*Username cannot be empty';
      _emailError = emailController.text.isEmpty
          ? '*Email cannot be empty'
          : (isEmailValid ? null : '*Email is invalid');
      _phoneError = phoneNumberController.text.isEmpty
          ? '*Phone number cannot be empty'
          : (isPhoneValid ? null : '*Phone must be 11-13 digits');
      _passwordError = passwordController.text.isEmpty
          ? '*Password cannot be empty'
          : (isPasswordValid
              ? null
              : '*Password must be at least 8 characters');
    });

    return isFullNameValid &&
        isUsernameValid &&
        isEmailValid &&
        isPhoneValid &&
        isPasswordValid;
  }

  // --- ACTION ---
  void _onCreateAccountPressed() {
    if (_validateForm()) {
      context.read<RegisterBloc>().add(
            RegisterButtonPressed(
              fullname: fullNameController.text,
              phone: phoneNumberController.text,
              username: usernameController.text,
              email: emailController.text,
              password: passwordController.text,
            ),
          );
    }
  }

  @override
  void dispose() {
    fullNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoading) {
          AlertDialogWidget.showLoading(context,
              message: 'Registering Account...');
        } else if (state is RegisterSuccess) {
          AlertDialogWidget.dismiss(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
          routes.pushReplacementNamed(RouteNames.login);
        } else if (state is RegisterFailure) {
          AlertDialogWidget.dismiss(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      child: Scaffold(
        backgroundColor: backgroundWhiteColor,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              // SECTION 1: HEADER
              RegisterHeaderSection(
                onBack: () => routes.replaceNamed(RouteNames.login),
              ),
              SizedBox(height: 45.r),

              // SECTION 2: FORM
              RegisterFormSection(
                fullNameController: fullNameController,
                usernameController: usernameController,
                emailController: emailController,
                phoneController: phoneNumberController,
                passwordController: passwordController,
                fullNameError: _fullNameError,
                usernameError: _usernameError,
                emailError: _emailError,
                phoneError: _phoneError,
                passwordError: _passwordError,
                isObscure: isObscure,
                onToggleObscure: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              SizedBox(height: 42.r),

              // SECTION 3: ACTION
              RegisterActionSection(
                onCreateAccount: _onCreateAccountPressed,
              ),
              SizedBox(height: 62.r),
            ],
          ),
        ),
      ),
    );
  }
}
