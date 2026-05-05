import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/chatbot/chatbot_bloc.dart';
import 'package:seimbangin_app/models/chat_message_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/chat/chat_welcome_section.dart';
import 'package:seimbangin_app/ui/sections/chat/chat_input_section.dart';
import 'package:seimbangin_app/ui/sections/chat/chat_messages_section.dart';

class ChatAdvisorPage extends StatefulWidget {
  const ChatAdvisorPage({super.key});
  @override
  State<ChatAdvisorPage> createState() => _ChatAdvisorPageState();
}

class _ChatAdvisorPageState extends State<ChatAdvisorPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _hasChats = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final userMessage = ChatMessage(
        messageContent: _messageController.text.trim(),
        messageType: "user",
        time: DateFormat('HH:mm').format(DateTime.now()),
      );

      // Pesan loading sementara
      final loadingMessage = ChatMessage(
        messageContent: "...",
        messageType: "loading",
        time: "",
      );

      if (mounted) {
        setState(() {
          _messages.add(userMessage);
          _messages.add(loadingMessage);
          _hasChats = true;
        });
      }

      // Kirim event ke BLoC
      context
          .read<ChatbotBloc>()
          .add(ChatBotReply(_messageController.text.trim()));
      _messageController.clear();
      _scrollToBottom();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.backgroundWhiteColor,
        surfaceTintColor: context.color.backgroundWhiteColor,
        centerTitle: true,
        toolbarHeight: 70.r,
        title: Text(
          'Blu: Your AI Advisor',
          style: context.text.blackTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0.5,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 24.r),
            child: Image.asset(
              'assets/ic_seimbangin-logo-logreg.png',
              width: 40.w,
              height: 40.h,
            ),
          ),
        ],
      ),
      backgroundColor: context.color.backgroundWhiteColor,
      body: BlocListener<ChatbotBloc, ChatbotState>(
        listener: (context, state) {
          if (state is ChatbotSuccess) {
            if (mounted) {
              setState(() {
                _messages.removeWhere((msg) => msg.messageType == "loading");

                _messages.add(
                  ChatMessage(
                    messageContent: state.reply,
                    messageType: "assistant",
                    time: DateFormat('HH:mm').format(DateTime.now()),
                  ),
                );
              });
              _scrollToBottom();
            }
          } else if (state is ChatbotFailure) {
            if (mounted) {
              setState(() {
                _messages.removeWhere((msg) => msg.messageType == "loading");

                // Graceful AI Fallback Message
                _messages.add(
                  ChatMessage(
                    messageContent:
                        "Ups, mohon maaf! Layanan pemroses bahasa alami saya sedang mengalami gangguan sementara (atau mencapai limit). 🙏\n\nSembari menunggu saya pulih, fitur pencatatan transaksi manual tetap dapat Anda gunakan dengan lancar di menu utama lho!",
                    messageType: "assistant",
                    time: DateFormat('HH:mm').format(DateTime.now()),
                  ),
                );
              });
              _scrollToBottom();
            }
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _hasChats
                    ? ChatMessagesSection(
                        scrollController: _scrollController,
                        messages: _messages,
                      )
                    : const ChatWelcomeSection(),
              ),
              ChatInputSection(
                messageController: _messageController,
                onSendMessage: _handleSendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
