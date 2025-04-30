import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/login/login_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/services/login_service.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isObscure = true;
  final TextEditingController phoneNumController = TextEditingController();
  final AuthService authService = AuthService();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            _showLoadingDialog(context);
          } else if (state is LoginSuccess || state is LoginFailure) {
            _dismissLoadingDialog(context);
          }
          print('State received in listener: $state');
          if (state is LoginSuccess) {
            print('Login Success');
            routes.pushNamed(RouteNames.home);
          } else if (state is LoginFailure) {
            print('Login Failed: ${state.error}');
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
                backgroundColor: backgroundWarningColor,
              ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            print('State received in builder: $state');
            return SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24).r,
                children: [
                  SizedBox(
                    height: 21.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRoundedButton(
                        onPressed: () {},
                        widget: Icon(
                          Icons.chevron_left,
                          size: 32.r,
                        ),
                        backgroundColor: backgroundWhiteColor,
                      ),
                      Image.asset(
                        'assets/ic_seimbangin-logo-logreg.png',
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/img_mascot-login.png'),
                      Text(
                        'Welcome',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 28.sp,
                        ),
                      ),
                      SizedBox(
                        height: 4.h,
                      ),
                      Text(
                        'Let’s get started with Seimbangin',
                        style: greyTextStyle.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 12.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 45.h,
                  ),
                  TextField(
                    controller: phoneNumController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      prefixIcon: Icon(
                        Icons.phone,
                        size: 18.r,
                      ),
                      hintText: 'Phone Number',
                      hintStyle: greyTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24).r,
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
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
                    height: 16.h,
                  ),
                  TextField(
                    controller: passwordController,
                    obscureText: isObscure,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      prefixIcon: Icon(
                        Icons.lock_outline_rounded,
                        size: 18.r,
                      ),
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isObscure = !isObscure;
                          });
                        },
                        icon: isObscure == true
                            ? Icon(
                                Icons.remove_red_eye_outlined,
                                size: 18.r,
                              )
                            : Icon(
                                Icons.remove_red_eye_rounded,
                                size: 18.r,
                              ),
                      ),
                      suffixIconColor: textPrimaryColor,
                      hintStyle: greyTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24).r,
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24).r,
                        borderSide: BorderSide(
                          color: textBlueColor,
                        ),
                      ),
                    ),
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Recovery Password',
                          style: blueTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: textBlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 42.h,
                  ),
                  PrimaryFilledButton(
                    title: 'Login',
                    onPressed: () {
                      try {
                        context.read<LoginBloc>().add(LoginButtonPressed(
                            identifier: phoneNumController.text,
                            password: passwordController.text));
                      } catch (e) {
                        print('Error: $e');
                      }
                    },
                  ),
                  SizedBox(
                    height: 22.h,
                  ),
                  Center(
                    child: Text(
                      'Or Sign Up With',
                      style: greyTextStyle.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 16.h,
                  ),
                  Center(
                    child: CustomRoundedButton(
                      onPressed: () {},
                      widget: Image.asset('assets/ic_google.png'),
                      backgroundColor: backgroundGreyColor,
                    ),
                  ),
                  SizedBox(
                    height: 31.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          routes.pushNamed(RouteNames.register);
                        },
                        child: Text(
                          'Register',
                          style: blueTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 12.sp,
                            decoration: TextDecoration.underline,
                            decorationColor: textBlueColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 42.h,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        // backgroundColor: backgroundWhiteColor,
        contentPadding: const EdgeInsets.all(24).r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24).r,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: primaryColor,
              strokeWidth: 4,
            ),
            SizedBox(height: 16.h),
            Text(
              'Logging In...',
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dismissLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
