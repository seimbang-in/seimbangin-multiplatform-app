import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart'; // HomepageBloc mungkin masih dibutuhkan untuk ProfilePage
// import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart'; // Tidak perlu dispatch dari sini lagi
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/pages/analytics_page.dart';
import 'package:seimbangin_app/ui/pages/chat_advisor_page.dart';
import 'package:seimbangin_app/ui/pages/home_page.dart';
import 'package:seimbangin_app/ui/pages/profile_page.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
  }

  List<PersistentTabConfig> _tabs(BuildContext context) => [
        PersistentTabConfig(
          screen: const HomePage(),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/ic_home.svg',
              width: 24.r,
            ),
            title: "Home",
            textStyle: whiteTextStyle.copyWith(
                fontSize: 12.sp, fontWeight: FontWeight.w600),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig(
          screen: const AnalyticsPage(),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/ic_analytic.svg',
              width: 24.r,
            ),
            title: "Analytic",
            textStyle: whiteTextStyle.copyWith(
                fontSize: 12.sp, fontWeight: FontWeight.w600),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig.noScreen(
          onPressed: (barContext) => routes.pushNamed(RouteNames.ocr),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/ic_scan.svg',
              width: 30.r,
            ),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig(
          screen: const ChatAdvisorPage(),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/ic_advisor.svg',
              width: 24.r,
            ),
            title: "Advisor",
            textStyle: whiteTextStyle.copyWith(
                fontSize: 12.sp, fontWeight: FontWeight.w600),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig(
          screen: BlocProvider.value(
            value: BlocProvider.of<HomepageBloc>(
                context), // Mengambil HomepageBloc dari context MainPage
            child: const ProfilePage(),
          ),
          item: ItemConfig(
            icon: SvgPicture.asset(
              'assets/ic_profile.svg',
              width: 24.r,
            ),
            title: "Profile",
            textStyle: whiteTextStyle.copyWith(
                fontSize: 12.sp, fontWeight: FontWeight.w600),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
      ];

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: _tabs(context), // Kirim context ke _tabs jika diperlukan
      navBarBuilder: (navBarConfig) => Style13BottomNavBar(
        height: 70.r,
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r),
            topRight: Radius.circular(24.r),
          ),
        ),
      ),
    );
  }
}
