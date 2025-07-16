import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:seimbangin_app/models/user/user_model.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart'
    as model;
import 'package:seimbangin_app/ui/pages/analytics_page.dart';
import 'package:seimbangin_app/ui/pages/chat_advisor_page.dart';
import 'package:seimbangin_app/ui/pages/financial_profile_page.dart';
import 'package:seimbangin_app/ui/pages/history_transact_page.dart';
import 'package:seimbangin_app/ui/pages/home_page.dart';
import 'package:seimbangin_app/ui/pages/login_page.dart';
import 'package:seimbangin_app/ui/pages/ocr_page.dart';
import 'package:seimbangin_app/ui/pages/ocr_preview_page.dart';
import 'package:seimbangin_app/ui/pages/onboarding_page.dart';
import 'package:seimbangin_app/ui/pages/profile_edit_page.dart';
import 'package:seimbangin_app/ui/pages/profile_page.dart';
import 'package:seimbangin_app/ui/pages/register_page.dart';
import 'package:seimbangin_app/ui/pages/splash_page.dart';
import 'package:seimbangin_app/ui/pages/transaction_detail_page.dart';
import 'package:seimbangin_app/ui/pages/transaction_struct_page.dart';
import 'package:seimbangin_app/ui/pages/transaction_success.dart';
import 'package:seimbangin_app/ui/pages/transaction_page.dart';
import 'package:seimbangin_app/ui/pages/main_page.dart';

part 'name_route.dart';

final routes = GoRouter(
  routes: [
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
      path: '/main',
      name: RouteNames.main,
      builder: (context, state) => MainPage(),
    ),
    GoRoute(
      path: '/analytics',
      name: RouteNames.analytics,
      builder: (context, state) => AnalyticsPage(),
    ),
    GoRoute(
      path: '/profile',
      name: RouteNames.profile,
      builder: (context, state) => ProfilePage(),
      routes: [
        GoRoute(
          path: 'profileEdit',
          name: RouteNames.profileEdit,
          builder: (context, state) {
            final userData = state.extra as UserResponse?;

            // Handle jika data tidak ada (sebagai pengaman)
            if (userData == null) {
              print("Error: UserData tidak ditemukan untuk ProfileEditPage.");
              return const Scaffold(
                body: Center(child: Text("Error: User data not provided.")),
              );
            }
            // Kirim userData ke ProfileEditPage
            return ProfileEditPage(userData: userData);
          },
        ),
      ],
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
            GoRoute(
              path: 'transaction',
              name: RouteNames.transaction,
              builder: (context, state) => const TransactionsPage(),
            ),
            GoRoute(
              path: 'transactionDetail',
              name: RouteNames.transactionDetail,
              builder: (context, state) {
                final transactionData = state.extra as model.TransactionData;
                if (transactionData == null) {
                  return Scaffold(
                    body: Center(
                        child: Text("Error: Transaction data not provided.")),
                  );
                }
                return TransactionDetailPage(transactionData: transactionData);
              },
            ),
            GoRoute(
              path: 'transactionStruct',
              name: RouteNames.transactionStruct,
              builder: (context, state) => TransactionStructPage(),
            ),
            GoRoute(
              path: 'transactionSuccess',
              name: RouteNames.transactionSuccess,
              builder: (context, state) => TransactionSuccessPage(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/chat-advisor',
      name: RouteNames.chatAdvisor,
      builder: (context, state) => const ChatAdvisorPage(),
    ),
    GoRoute(
      path: '/financialProfile',
      name: RouteNames.financialProfile,
      builder: (context, state) => const FinancialProfilePage(),
    ),
    GoRoute(
      path: '/historyTransact',
      name: RouteNames.historyTransact,
      builder: (context, state) => const HistoryTransactPage(),
    ),
  ],
);
