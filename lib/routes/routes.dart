import 'package:go_router/go_router.dart';
import 'package:seimbangin_app/ui/pages/onboarding_page.dart';
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
]);
