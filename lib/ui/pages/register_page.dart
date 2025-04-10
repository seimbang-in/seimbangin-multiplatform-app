import 'package:flutter/material.dart';
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
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(
              height: 21,
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
                    size: 32,
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
                    fontSize: 28,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 45,
            ),
            TextField(
              // controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundGreyColor,
                hintText: 'Full Name',
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
              height: 16,
            ),
            TextField(
              // controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundGreyColor,
                hintText: 'Username',
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
              height: 16,
            ),
            TextField(
              // controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundGreyColor,
                hintText: 'Email Address',
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
              height: 16,
            ),
            TextField(
              // controller: emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundGreyColor,
                hintText: 'Phone Number',
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
              height: 16,
            ),
            TextField(
              // controller: passwordController,
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
                      ? const Icon(
                          Icons.remove_red_eye_outlined,
                          size: 18,
                        )
                      : const Icon(
                          Icons.remove_red_eye_rounded,
                          size: 18,
                        ),
                ),
                suffixIconColor: textPrimaryColor,
                hintStyle: greyTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide(
                    color: textBlueColor,
                  ),
                ),
              ),
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(
              height: 42,
            ),
            PrimaryFilledButton(
              title: 'Create Account',
              onPressed: () {
                routes.pushNamed(RouteNames.registerWait);
              },
            ),
            const SizedBox(
              height: 22,
            ),
            Row(
              children: [
                Checkbox(
                    value: isChecked,
                    onChanged: (value) {
                      setState(() {
                        isChecked = value ?? false;
                      });
                    }),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'By continuing, you agree to our ',
                          style: blackTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: textPrimaryColor,
                          ),
                        ),
                        TextSpan(
                            text: 'Terms of Service',
                            style: blueTextStyle.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                              decorationColor: textBlueColor,
                            )
                            // recognizer: TapGestureRecognizer()
                            //   ..onTap = widget.onTermsPressed,
                            ),
                        TextSpan(
                          text: ' and ',
                          style: blackTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor,
                          ),
                        ),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: blueTextStyle.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                            decorationColor: textBlueColor,
                          ),
                          // recognizer: TapGestureRecognizer()
                          //   ..onTap = widget.onPrivacyPressed,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            const SizedBox(
              height: 42,
            ),
          ],
        ),
      ),
    );
  }
}
