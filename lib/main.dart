import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seimbangin_app/blocs/chatbot/chatbot_bloc.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/blocs/login/login_bloc.dart';
import 'package:seimbangin_app/blocs/logout/logout_bloc.dart';
import 'package:seimbangin_app/blocs/ocr/ocr_bloc.dart';
import 'package:seimbangin_app/blocs/register/register_bloc.dart';
import 'package:seimbangin_app/blocs/statistics/statistics_bloc.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/services/auth/register/register_service.dart';
import 'package:seimbangin_app/services/chatbot_service.dart';
import 'package:seimbangin_app/services/auth/login/login_service.dart';
import 'package:seimbangin_app/services/auth/logout/logout_service.dart';
import 'package:seimbangin_app/services/ocr_service.dart';
import 'package:seimbangin_app/services/statistics_service.dart';
import 'package:seimbangin_app/services/transaction/transaction_service.dart';
import 'package:seimbangin_app/services/user_service.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('en_EN', null);
  await dotenv.load(fileName: '.env');
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
    ],
  ).then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(authService: LoginService()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(logoutService: LogoutService()),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(authService: RegisterService()),
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
        ),
        BlocProvider(
            create: (context) =>
                StatisticsBloc(statisticsService: StatisticsService()))
      ],
      child: ScreenUtilInit(
        designSize: const Size(390, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: routes,
          );
        },
      ),
    );
  }
}
