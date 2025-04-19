import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/services/chatbot_service.dart';

part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  final ChatbotService chatbotService;
  ChatbotBloc({required this.chatbotService}) : super(ChatbotInitial()) {
    on<ChatbotEvent>((event, emit) {});
    on<ChatBotReply>(_getChatbotReply);
  }

  Future<void> _getChatbotReply(
    ChatBotReply event,
    Emitter<ChatbotState> emit,
  ) async {
    try {
      emit(ChatbotLoading("Loading..."));
      final response = await chatbotService.getChatbotResponse(event.message);
      emit(ChatbotSuccess("berhasil mendapatkan response", response));
    } catch (e) {
      emit(ChatbotFailure("Failed to get response: $e"));
    }
  }
}
