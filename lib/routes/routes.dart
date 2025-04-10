import 'package:go_router/go_router.dart';
import 'package:seimbangin_app/ui/pages/analytics_page.dart';
import 'package:seimbangin_app/ui/pages/home_page.dart';
import 'package:seimbangin_app/ui/pages/login_page.dart';
import 'package:seimbangin_app/ui/pages/ocr_page.dart';
import 'package:seimbangin_app/ui/pages/ocr_preview_page.dart';
import 'package:seimbangin_app/ui/pages/onboarding_page.dart';
import 'package:seimbangin_app/ui/pages/register_page.dart';
import 'package:seimbangin_app/ui/pages/splash_page.dart';

part 'name_route.dart';

final routes = GoRouter(routes: [
  GoRoute(
    path: '/',
    name: RouteNames.splash,
    builder: (context, state) => SplashPage(),
  ),
  GoRoute(
    path: '/onboarding',
    name: RouteNames.onboarding,
    builder: (context, state) => const OnBoardingPage(),
  ),
  GoRoute(
    path: '/login',
    name: RouteNames.login,
    builder: (context, state) => const LoginPage(),
  ),
  GoRoute(
    path: '/register',
    name: RouteNames.register,
    builder: (context, state) => const RegisterPage(),
    routes: [],
  ),
  GoRoute(
    path: '/analytics',
    name: RouteNames.analytics,
    builder: (context, state) => AnalyticsPage(),
  ),
  GoRoute(
    path: '/home',
    name: RouteNames.home,
    builder: (context, state) => const HomePage(),
    routes: [
      GoRoute(
        path: 'ocr',
        name: RouteNames.ocr,
        builder: (context, state) => const OcrPage(),
        routes: [
          GoRoute(
            path: 'ocr-preview',
            name: RouteNames.ocrPreview,
            builder: (context, state) {
              final path = state.extra as String;
              return OcrPreviewPage(path: path);
            },
          ),
        ],
      ),
    ],
  ),
]);
