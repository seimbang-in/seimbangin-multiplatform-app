import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart'; // <-- 1. TAMBAHKAN IMPORT
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/pages/analytics_page.dart';
import 'package:seimbangin_app/ui/pages/chat_advisor_page.dart';
import 'package:seimbangin_app/ui/pages/home_page.dart';
import 'package:seimbangin_app/ui/pages/profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    context.read<HomepageBloc>().add(HomepageStarted());
    context.read<TransactionBloc>().add(GetRecentTransactionsEvent(limit: 5));
  }

  List<PersistentTabConfig> _tabs() => [
        PersistentTabConfig(
          screen: const HomePage(),
          item: ItemConfig(
            icon:
                Image.asset('assets/logo-home-btn.png', width: 24, height: 24),
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
            icon: Image.asset('assets/logo-analytic-btn.png',
                width: 24, height: 24),
            title: "Analytic",
            textStyle: whiteTextStyle.copyWith(
                fontSize: 12.sp, fontWeight: FontWeight.w600),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig.noScreen(
          onPressed: (p0) => routes.pushNamed(RouteNames.ocr),
          item: ItemConfig(
            icon: Image.asset('assets/icon-scan.png', width: 30, height: 30),
            activeForegroundColor: backgroundWhiteColor,
            inactiveForegroundColor: backgroundWhiteColor,
          ),
        ),
        PersistentTabConfig(
          screen: ChatAdvisorPage(),
          item: ItemConfig(
            icon: Image.asset('assets/logo-advisor-btn.png',
                width: 24, height: 24),
            title: "Advisor",
            textStyle: whiteTextStyle.copyWith(
                fontSize: 12.sp, fontWeight: FontWeight.w600),
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
            icon: Image.asset('assets/logo-profile-btn.png',
                width: 24, height: 24),
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
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        if (state is HomePageSuccess) {
          return PersistentTabView(
            tabs: _tabs(),
            navBarHeight: 70.r,
            navBarBuilder: (navBarConfig) => Style13BottomNavBar(
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

        if (state is HomePageFailure) {
          return Scaffold(
            backgroundColor: backgroundWhiteColor,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Failed to load data',
                    style: blackTextStyle.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 16.h),
                  ElevatedButton(
                    onPressed: () {
                      context.read<HomepageBloc>().add(HomepageStarted());
                    },
                    child: const Text('Try Again'),
                  )
                ],
              ),
            ),
          );
        }

        return Scaffold(
          backgroundColor: backgroundWhiteColor,
          body: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
              strokeWidth: 4,
            ),
          ),
        );
      },
    );
  }
}
