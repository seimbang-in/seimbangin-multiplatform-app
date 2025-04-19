part of 'chatbot_bloc.dart';

@immutable
sealed class ChatbotState {}

final class ChatbotInitial extends ChatbotState {}

class ChatbotLoading extends ChatbotState {
  final String message;
  ChatbotLoading(this.message);
}

class ChatbotSuccess extends ChatbotState {
  final String message;
  final String reply;
  ChatbotSuccess(this.message, this.reply);
}

class ChatbotFailure extends ChatbotState {
  final String message;
  ChatbotFailure(this.message);
}
