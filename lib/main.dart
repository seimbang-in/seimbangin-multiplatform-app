import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seimbangin_app/blocs/chatbot/chatbot_bloc.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/blocs/login/login_bloc.dart';
import 'package:seimbangin_app/blocs/ocr/ocr_bloc.dart';
import 'package:seimbangin_app/blocs/register/register_bloc.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/services/chatbot_service.dart';
import 'package:seimbangin_app/services/login_service.dart';
import 'package:seimbangin_app/services/ocr_service.dart';
import 'package:seimbangin_app/services/transaction_service.dart';
import 'package:seimbangin_app/services/user_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
        ),
        BlocProvider(
          create: (context) => RegisterBloc(authService: AuthService()),
        ),
        BlocProvider(
            create: (context) => HomepageBloc(userService: UserService())),
        BlocProvider(
          create: (context) =>
              TransactionBloc(transactionService: TransactionService()),
        ),
        BlocProvider(
          create: (context) => ChatbotBloc(chatbotService: ChatbotService()),
        ),
        BlocProvider(
          create: (context) => OcrBloc(ocrService: OcrService()),
        )
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: routes,
        ),
      ),
    );
  }
}
