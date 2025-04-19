part of 'chatbot_bloc.dart';

@immutable
sealed class ChatbotEvent {}

class ChatBotReply extends ChatbotEvent {
  final String message;
  ChatBotReply(this.message);
} 


