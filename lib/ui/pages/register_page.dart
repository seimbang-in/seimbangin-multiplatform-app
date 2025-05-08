import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/register/register_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool isObscure = true;
  bool isChecked = false;
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          _dismissLoadingDialog(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
            ),
          );
          routes.pushNamed(RouteNames.login);
        } else if (state is RegisterLoading) {
          _showLoadingDialog(context);
        } else if (state is RegisterFailure) {
          _dismissLoadingDialog(context);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        print('state : $state');
        return Scaffold(
          backgroundColor: backgroundWhiteColor,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                SizedBox(
                  height: 21.r,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRoundedButton(
                      onPressed: () {
                        routes.replaceNamed(RouteNames.login);
                      },
                      widget: Icon(
                        Icons.chevron_left,
                        size: 32.r,
                        color: textSecondaryColor,
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
                      'Create Account',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 28.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45.r,
                ),
                TextField(
                  controller: fullNameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'Full Name',
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
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 16.r,
                ),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'Username',
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
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 16.r,
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'Email Address',
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
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 16.r,
                ),
                TextField(
                  controller: phoneNumberController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
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
                  height: 16.r,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: isObscure,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'Password',
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      icon: isObscure == true
                          ? Icon(
                              Icons.remove_red_eye_rounded,
                              size: 18.r,
                            )
                          : Icon(
                              Icons.remove_red_eye_outlined,
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
                SizedBox(
                  height: 42.r,
                ),
                PrimaryFilledButton(
                  title: 'Create Account',
                  onPressed: () {
                    context.read<RegisterBloc>().add(
                          RegisterButtonPressed(
                            fullname: fullNameController.text,
                            phone: phoneNumberController.text,
                            username: usernameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                          ),
                        );
                  },
                ),
                SizedBox(
                  height: 42.r,
                ),
              ],
            ),
          ),
        );
      },
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
              'Registering Account...',
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
