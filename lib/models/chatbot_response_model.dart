// Chatbot response model
class ChatbotResponse {
  final String status;
  final int code;
  final String message;
  final ChatbotData data;

  ChatbotResponse({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory ChatbotResponse.fromJson(Map<String, dynamic> json) {
    return ChatbotResponse(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: ChatbotData.fromJson(json['data']),
    );
  }
}

class ChatbotData {
  final String reply;

  ChatbotData({required this.reply});

  factory ChatbotData.fromJson(Map<String, dynamic> json) {
    return ChatbotData(
      reply: json['reply'],
    );
  }
}