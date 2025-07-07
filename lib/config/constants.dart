import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constant {
  static String loginEndpoint = '${dotenv.env['BASE_URL']}/auth/login';
  static String logoutEndpoint = '${dotenv.env['BASE_URL']}/auth/logout';
  static String registerEndpoint = '${dotenv.env['BASE_URL']}/auth/register';
  static String getUserProfileEndpoint =
      '${dotenv.env['BASE_URL']}/user/profile';
  static String getUserAdviceEndpoint = '${dotenv.env['BASE_URL']}/advisor';
  static String chatbotReplyEndpoint = '${dotenv.env['BASE_URL']}/chatbot';
  static String addTransactionEndpoint =
      '${dotenv.env['BASE_URL']}/transaction';
  static String ocrEndpoint = '${dotenv.env['BASE_URL']}/ocr';
  static String getTransactionEndpoint =
      '${dotenv.env['BASE_URL']}/transaction';
  static String updateUserProfileEndpoint =
      '${dotenv.env['BASE_URL']}/financial-profile';
  static String statisticsMonthlyEndpoint =
      '${dotenv.env['BASE_URL']}/statistic/monthly';
}
