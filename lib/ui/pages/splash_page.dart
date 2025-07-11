import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/utils/token.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkStatusAndNavigate();
  }

  Future<void> _checkStatusAndNavigate() async {
    await Future.delayed(const Duration(seconds: 3));

    final bool hasSeenOnboarding = await Token.getOnboardingSeen();

    if (!mounted) return;

    if (!hasSeenOnboarding) {
      routes.goNamed(RouteNames.onboarding);
      return;
    }

    final String? token = await Token.getToken();

    if (!mounted) return;

    if (token != null) {
      routes.goNamed(RouteNames.main);
    } else {
      routes.goNamed(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [primaryColor, secondaryColor],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              top: false,
              child: ShaderMask(
                blendMode: BlendMode.dstIn,
                shaderCallback: (Rect bound) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      backgroundWhiteColor.withAlpha(50),
                      backgroundWhiteColor.withAlpha(255),
                    ],
                    stops: const [0.0, 0.6],
                  ).createShader(bound);
                },
                child: SvgPicture.asset(
                  'assets/bg_splash-pattern.svg',
                  height: MediaQuery.of(context).size.height / 2.8,
                  fit: BoxFit.fitWidth,
                  colorFilter: ColorFilter.mode(
                    backgroundWhiteColor.withAlpha(150),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/ic_seimbangin-white-logo.svg',
                        width: 40,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'eimbangin',
                        style: whiteTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
