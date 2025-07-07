import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';
import 'package:seimbangin_app/utils/token.dart'; // <-- Import class Token

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  List<String> titles = [
    'Take Control of Your Money\nMake Your Future',
    'AI-Advisor: Smart Budgeting,\nSmarter Spending',
    'Build Healthy Money Habits &\nAchieve Financial Goals'
  ];

  void _finishOnboarding() async {
    await Token.setOnboardingSeen();

    if (mounted) {
      routes.goNamed(RouteNames.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 94.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/ic_seimbangin-blue-logo.svg',
                        width: 40.w,
                      ),
                      SizedBox(
                        width: 6.w,
                      ),
                      Text(
                        'eimbangin',
                        style: blueTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 28.sp,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  CarouselSlider(
                    items: [
                      Image.asset(
                        'assets/img_onboarding1.png',
                      ),
                      Image.asset(
                        'assets/img_onboarding2.png',
                      ),
                      Image.asset(
                        'assets/img_onboarding3.png',
                      )
                    ],
                    options: CarouselOptions(
                      height: 250.h,
                      viewportFraction: 1,
                      enableInfiniteScroll: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                    carouselController: _carouselController,
                  ),
                  SizedBox(
                    height: 24.h,
                  ),
                  Column(
                    children: [
                      Text(
                        titles[currentIndex],
                        textAlign: TextAlign.center,
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: titles.map((url) {
                          int index = titles.indexOf(url);
                          return Container(
                            width: currentIndex == index ? 38.w : 20.w,
                            height: 8.h,
                            margin: const EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 2.0,
                            ).r,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.circular(12.r),
                              color: currentIndex == index
                                  ? secondaryColor
                                  : sliderOnboardingColor,
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ).r,
              child: (currentIndex == 2)
                  ? PrimaryFilledButton(
                      title: 'Login',
                      onPressed: _finishOnboarding, // Panggil method finish
                    )
                  : PrimaryFilledButton(
                      title: 'Next',
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                    ),
            ),
            TextButton(
              onPressed: _finishOnboarding, // Panggil method finish
              child: Text(
                'Skip',
                style: blueTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                  decoration: TextDecoration.underline,
                  decorationColor: textBlueColor,
                ),
              ),
            ),
            SizedBox(
              height: 53.h,
            ),
          ],
        ),
      ),
    );
  }
}
