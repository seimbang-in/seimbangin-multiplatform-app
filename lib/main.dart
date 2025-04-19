import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/blocs/login/login_bloc.dart';
import 'package:seimbangin_app/blocs/register/register_bloc.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/services/login_service.dart';
import 'package:seimbangin_app/services/transaction_service.dart';
import 'package:seimbangin_app/services/user_service.dart';
import 'package:seimbangin_app/ui/pages/home_page.dart';
import 'package:seimbangin_app/ui/pages/login_page.dart';
import 'package:seimbangin_app/ui/pages/register_page.dart';
import 'package:seimbangin_app/ui/pages/transactions_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(authService: AuthService()),
          child: const LoginPage(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(authService: AuthService()),
          child: const RegisterPage(),
        ),
        BlocProvider(
          create: (context) {
            final bloc = HomepageBloc(userService: UserService());
            // bloc.add(HomepageStarted());
            return bloc;
          },
          child: HomePage(),
        ),
        BlocProvider(
          create: (context) =>
              TransactionBloc(transactionService: TransactionService()),
          child: const TransactionsPage(),
        ),
        BlocProvider(
            create: (context) => ChatbotBloc(chatbotService: ChatbotService()),
            child: ChatAdvisorPage(),
          )
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: routes,
      ),
    );
  }
}
