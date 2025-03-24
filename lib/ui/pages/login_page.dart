import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
                ),
                Image.asset(
                  'assets/ic_seimbangin-logo-logreg.png',
                ),
              ],
            ),
            Image.asset('assets/img_mascot-login.png'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                  size: 14,
                ),
                hintText: 'Phone Number',
                hintStyle: greyTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
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
                  size: 14,
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
                          size: 14,
                        )
                      : const Icon(
                          Icons.remove_red_eye_rounded,
                          size: 14,
                        ),
                ),
                suffixIconColor: textPrimaryColor,
                hintStyle: greyTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
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
                      fontSize: 10,
                      decoration: TextDecoration.underline,
                      decorationColor: textBlueColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 63,
            ),
            PrimaryFilledButton(
              title: 'Login',
              onPressed: () {},
            )
          ],
        ),
      ),
    );
  }
}
