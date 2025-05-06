import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/pages/analytics_page.dart';
import 'package:seimbangin_app/ui/pages/chat_advisor_page.dart';
import 'package:seimbangin_app/ui/pages/home_page.dart';
import 'package:seimbangin_app/ui/pages/ocr_page.dart';
import 'package:seimbangin_app/ui/pages/profile_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  List<PersistentTabConfig> _tabs(BuildContext context) => [
        PersistentTabConfig(
          screen: const HomePage(),
          item: ItemConfig(
            icon: Image.asset(
              'assets/logo-home-btn.png',
              width: 24,
              height: 24,
            ),
            title: "Home",
            textStyle: whiteTextStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig(
          screen: const AnalyticsPage(),
          item: ItemConfig(
            icon: Image.asset(
              'assets/logo-analytic-btn.png',
              width: 24,
              height: 24,
            ),
            title: "Analytic",
            textStyle: whiteTextStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig.noScreen(
          onPressed: (p0) => routes.pushNamed(RouteNames.ocr),
          item: ItemConfig(
            icon: Image.asset(
              'assets/icon-scan.png',
              width: 24,
              height: 24,
            ),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig(
          screen: ChatAdvisorPage(),
          item: ItemConfig(
            icon: Image.asset(
              'assets/logo-advisor-btn.png',
              width: 24,
              height: 24,
            ),
            title: "Advisor",
            textStyle: whiteTextStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig(
          screen: BlocProvider.value(
            value: BlocProvider.of<HomepageBloc>(context),
            child: const ProfilePage(),
          ),
          item: ItemConfig(
            icon: Image.asset(
              'assets/logo-profile-btn.png',
              width: 24,
              height: 24,
            ),
            title: "Profile",
            textStyle: whiteTextStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w600,
            ),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) => PersistentTabView(
        tabs: _tabs(context),
        navBarHeight: 70.r,
        navBarBuilder: (navBarConfig) => Style13BottomNavBar(
          navBarConfig: navBarConfig,
          navBarDecoration: NavBarDecoration(
            color: buttonColor,
          ),
        ),
      );
}
