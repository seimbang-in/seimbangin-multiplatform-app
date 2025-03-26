import 'package:flutter/material.dart';
import 'package:seimbangin_app/routes/routes.dart';
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
                RoundedButton(
                  onPressed: () {},
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
                  'Welcome',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 28,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  'Let’s get started with Seimbangin',
                  style: greyTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
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
                prefixIcon: Icon(
                  Icons.phone,
                  size: 18,
                ),
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
                prefixIcon: Icon(
                  Icons.lock_outline_rounded,
                  size: 18,
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Recovery Password',
                    style: blueTextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      decorationColor: textBlueColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 42,
            ),
            PrimaryFilledButton(
              title: 'Login',
              onPressed: () {},
            ),
            const SizedBox(
              height: 22,
            ),
            Center(
              child: Text(
                'Or Sign Up With',
                style: greyTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: RoundedButton(
                onPressed: () {},
                widget: Image.asset('assets/ic_google.png'),
                backgroundColor: backgroundGreyColor,
              ),
            ),
            const SizedBox(
              height: 31,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
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
                      fontSize: 12,
                      decoration: TextDecoration.underline,
                      decorationColor: textBlueColor,
                    ),
                  ),
                ),
              ],
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
