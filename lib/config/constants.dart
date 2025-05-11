class Constant {
  static const String baseUrlApi = 'https://seimbangin.vercel.app';
  static const String loginEndpoint = '$baseUrlApi/auth/login';
  static const String registerEndpoint = '$baseUrlApi/auth/register';
  static const String getUserProfileEndpoint = '$baseUrlApi/user/profile';
  static const String getUserAdviceEndpoint = '$baseUrlApi/advisor';
  static const String chatbotReplyEndpoint = '$baseUrlApi/chatbot';
  static const String addTransactionEndpoint = '$baseUrlApi/transaction';
  static const String ocrEndpoint = '$baseUrlApi/ocr';
  static const String updateUserProfileEndpoint =
      '$baseUrlApi/financial-profile';
  static const String statisticsMonthlyEndpoint =
      '$baseUrlApi/statistic/monthly';
}
