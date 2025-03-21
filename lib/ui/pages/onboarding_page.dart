import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  int currentIndex = 0;
  CarouselSliderController _carouselController = CarouselSliderController();

  List<String> titles = [
    'Take Control of Your Money\nMake Your Future',
    'AI-Advisor: Smart Budgeting,\nSmarter Spending',
    'Build Healthy Money Habits &\nAchieve Financial Goals'
  ];

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
                  const SizedBox(
                    height: 94,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/ic_seimbangin-blue-logo.svg',
                        width: 40,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'eimbangin',
                        style: blueTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 28,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 40,
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
                      height: 250,
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
                  const SizedBox(
                    height: 24,
                  ),
                  Column(
                    children: [
                      Text(
                        titles[currentIndex],
                        textAlign: TextAlign.center,
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 32,
                      ),
                      (currentIndex == 1)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 20,
                                  height: 8,
                                  margin: const EdgeInsets.only(
                                    right: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(12),
                                    color: currentIndex == 0
                                        ? secondaryColor
                                        : sliderOnboardingColor,
                                  ),
                                ),
                                Container(
                                  width: 38,
                                  height: 8,
                                  margin: const EdgeInsets.only(
                                    right: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(12),
                                    color: currentIndex == 1
                                        ? secondaryColor
                                        : sliderOnboardingColor,
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(12),
                                    color: currentIndex == 2
                                        ? secondaryColor
                                        : sliderOnboardingColor,
                                  ),
                                ),
                              ],
                            )
                          : (currentIndex == 2)
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 20,
                                      height: 8,
                                      margin: const EdgeInsets.only(
                                        right: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(12),
                                        color: currentIndex == 0
                                            ? secondaryColor
                                            : sliderOnboardingColor,
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 8,
                                      margin: const EdgeInsets.only(
                                        right: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(12),
                                        color: currentIndex == 1
                                            ? secondaryColor
                                            : sliderOnboardingColor,
                                      ),
                                    ),
                                    Container(
                                      width: 38,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(12),
                                        color: currentIndex == 2
                                            ? secondaryColor
                                            : sliderOnboardingColor,
                                      ),
                                    ),
                                  ],
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 38,
                                      height: 8,
                                      margin: const EdgeInsets.only(
                                        right: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(12),
                                        color: currentIndex == 0
                                            ? secondaryColor
                                            : sliderOnboardingColor,
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 8,
                                      margin: const EdgeInsets.only(
                                        right: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(12),
                                        color: currentIndex == 1
                                            ? secondaryColor
                                            : sliderOnboardingColor,
                                      ),
                                    ),
                                    Container(
                                      width: 20,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        borderRadius: BorderRadius.circular(12),
                                        color: currentIndex == 2
                                            ? secondaryColor
                                            : sliderOnboardingColor,
                                      ),
                                    ),
                                  ],
                                ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: (currentIndex == 2)
                  ? PrimaryFilledButton(
                      title: 'Login',
                      onPressed: () {
                        routes.goNamed(RouteNames.login);
                      },
                    )
                  : PrimaryFilledButton(
                      title: 'Next',
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                    ),
            ),
            TextButton(
              onPressed: () {
                routes.goNamed(RouteNames.login);
              },
              child: Text(
                'Skip',
                style: blueTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  decoration: TextDecoration.underline,
                  decorationColor: textBlueColor,
                ),
              ),
            ),
            const SizedBox(
              height: 53,
            ),
          ],
        ),
      ),
    );
  }
}
