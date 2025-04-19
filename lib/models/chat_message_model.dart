class ChatMessage {
  final String messageContent;
  final String messageType; // "user" or "assistant"
  final String time;

  ChatMessage({
    required this.messageContent,
    required this.messageType,
    required this.time,
  });

  Map<String, dynamic> toJson() {
    return {
      'messageContent': messageContent,
      'messageType': messageType,
      'time': time,
    };
  }

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      messageContent: json['messageContent'],
      messageType: json['messageType'],
      time: json['time'],
    );
  }
}