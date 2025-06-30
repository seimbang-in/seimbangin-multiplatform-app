import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/login/login_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/services/login_service.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/login/login_footer_section.dart';
import 'package:seimbangin_app/ui/sections/login/login_form_section.dart';
import 'package:seimbangin_app/ui/sections/login/login_header_section.dart';
import 'package:seimbangin_app/ui/widgets/alert_dialog_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // --- STATE AND CONTROLLERS ---
  bool isObscure = true;
  bool _isIdentifierValid = true;
  bool _isPassValid = true;
  bool _isFormSubmitted = false;
  final TextEditingController identifierController = TextEditingController();
  final AuthService authService =
      AuthService(); // Tidak digunakan di contoh ini
  final TextEditingController passwordController = TextEditingController();

  // --- LOGIC ---
  void _validateForm() {
    setState(() {
      _isFormSubmitted = true;
      _isIdentifierValid = identifierController.text.isNotEmpty;
      _isPassValid = passwordController.text.isNotEmpty;
    });
  }

  bool get _isFormValid =>
      identifierController.text.isNotEmpty &&
      passwordController.text.isNotEmpty;

  void _onLoginPressed() {
    _validateForm();
    if (_isFormValid) {
      context.read<LoginBloc>().add(
            LoginButtonPressed(
              identifier: identifierController.text,
              password: passwordController.text,
            ),
          );
    }
  }

  void _onRegisterPressed() {
    routes.pushNamed(RouteNames.register);
  }

  @override
  void dispose() {
    identifierController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            AlertDialogWidget.showLoading(context, message: 'Logging In...');
          } else if (state is LoginSuccess || state is LoginFailure) {
            AlertDialogWidget.dismiss(context);
          }

          if (state is LoginSuccess) {
            identifierController.clear();
            passwordController.clear();
            setState(() {
              _isFormSubmitted = false;
              _isIdentifierValid = true;
              _isPassValid = true;
            });
            routes.pushNamed(RouteNames.main);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: backgroundWarningColor,
              ),
            );
          }
        },
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24).r,
            children: [
              // SECTION 1: HEADER
              const LoginHeaderSection(),
              SizedBox(height: 45.h),

              // SECTION 2: FORM
              LoginFormSection(
                phoneController: identifierController,
                passwordController: passwordController,
                isObscure: isObscure,
                isPhoneValid: _isIdentifierValid,
                isPassValid: _isPassValid,
                isFormSubmitted: _isFormSubmitted,
                onToggleObscure: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              ),
              SizedBox(height: 42.h),

              // SECTION 3: FOOTER
              LoginFooterSection(
                onLogin: _onLoginPressed,
                onGoogleSignIn: () {
                  // TODO: Implement Google Sign-In logic
                },
                onRegister: _onRegisterPressed,
              ),
              SizedBox(height: 42.h),
            ],
          ),
        ),
      ),
    );
  }
}
