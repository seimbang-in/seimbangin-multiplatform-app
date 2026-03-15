import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
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

  final List<Map<String, String>> onboardingData = [
    {
      'title': 'Pegang Kendali Keuanganmu',
      'subtitle':
          'Lacak setiap pemasukan dan pengeluaran\ndengan mudah dalam satu genggaman.',
    },
    {
      'title': 'Penasihat AI & Anggaran Cerdas',
      'subtitle':
          'Dapatkan saran personal dari Asisten AI\nuntuk mencapai target finansialmu.',
    },
    {
      'title': 'Bangun Kebiasaan Finansial Sehat',
      'subtitle':
          'Mulai perjalanan keuanganmu sekarang\ndan wujudkan masa lalu yang lebih baik.',
    }
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
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 50.h,
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
                        height: 300.h,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: onboardingData.asMap().entries.map((entry) {
                        int index = entry.key;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          width: currentIndex == index ? 32.w : 10.w,
                          height: 10.h,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 4.0,
                          ).r,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: currentIndex == index
                                ? secondaryColor
                                : sliderOnboardingColor,
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 24.h,
                    ),
                    Column(
                      key: ValueKey<int>(currentIndex),
                      children: [
                        Text(
                          onboardingData[currentIndex]['title']!,
                          textAlign: TextAlign.center,
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w700,
                            fontSize: 20.sp,
                          ),
                        ).animate().fadeIn(duration: 400.ms).slideY(
                            begin: 0.2,
                            end: 0,
                            duration: 400.ms,
                            curve: Curves.easeOutQuad),
                        SizedBox(
                          height: 16.h,
                        ),
                        Text(
                          onboardingData[currentIndex]['subtitle']!,
                          textAlign: TextAlign.center,
                          style: greyTextStyle.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14.sp,
                            height: 1.3,
                          ),
                        )
                            .animate()
                            .fadeIn(delay: 200.ms, duration: 400.ms)
                            .slideY(
                                begin: 0.2,
                                end: 0,
                                duration: 400.ms,
                                curve: Curves.easeOutQuad),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ).r,
              child: (currentIndex == 2)
                  ? PrimaryFilledButton(
                      title: 'Mulai Sekarang',
                      onPressed: _finishOnboarding, // Panggil method finish
                    )
                  : PrimaryFilledButton(
                      title: 'Selanjutnya',
                      onPressed: () {
                        _carouselController.nextPage();
                      },
                    ),
            ),
            SizedBox(height: 12.h),
            TextButton(
              onPressed: _finishOnboarding, // Panggil method finish
              child: Text(
                'Lewati',
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
