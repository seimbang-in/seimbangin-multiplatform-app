import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // Untuk format waktu yang lebih baik
import 'package:seimbangin_app/blocs/chatbot/chatbot_bloc.dart';
import 'package:seimbangin_app/models/chat_message_model.dart'; // Pastikan path ini benar
import 'package:seimbangin_app/shared/theme/theme.dart';

class ChatAdvisorPage extends StatefulWidget {
  const ChatAdvisorPage({super.key});
  @override
  State<ChatAdvisorPage> createState() => _ChatAdvisorPageState();
}

class _ChatAdvisorPageState extends State<ChatAdvisorPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final List<ChatMessage> _messages = [];
  bool _hasChats = false; // Untuk menampilkan welcome screen atau chat

  @override
  void initState() {
    super.initState();
  }

  // void _addInitialAssistantMessage(String message) {
  //   if (!mounted) return;
  //   setState(() {
  //     _messages.add(ChatMessage(
  //       messageContent: message,
  //       messageType: "assistant",
  //       time: DateFormat('HH:mm').format(DateTime.now()),
  //     ));
  //     _hasChats = true;
  //   });
  //   _scrollToBottom();
  // }

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
        backgroundColor: backgroundWhiteColor,
        surfaceTintColor: backgroundWhiteColor,
        centerTitle: true,
        toolbarHeight: 70.r,
        title: Text(
          'Blu: Your AI Advisor',
          style: blackTextStyle.copyWith(
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
      backgroundColor: backgroundWhiteColor,
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
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
              _scrollToBottom();
            }
          }
        },
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: _hasChats ? _buildChatMessages() : _buildWelcomeScreen(),
              ),
              _buildMessageInputField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/img_mascot-login.png', width: 200.w),
          SizedBox(height: 16.h),
          Text(
            "Hi, Nice to meet you!",
            style: blackTextStyle.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            child: Text(
              "I'm Blu, your financial AI advisor. Ask me anything about your finances!",
              textAlign: TextAlign.center,
              style: greyTextStyle.copyWith(fontSize: 14.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return ListView.builder(
      controller: _scrollController,
      itemCount: _messages.length,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      itemBuilder: (context, index) {
        final message = _messages[index];
        final isUserMessage = message.messageType == "user";

        if (message.messageType == "loading") {
          return _buildTypingIndicator();
        }

        return Align(
          alignment:
              isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75),
            padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 14.r),
            margin: EdgeInsets.symmetric(vertical: 4.r),
            decoration: BoxDecoration(
              color: isUserMessage ? primaryColor : backgroundGreyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.r),
                topRight: Radius.circular(18.r),
                bottomLeft: isUserMessage
                    ? Radius.circular(18.r)
                    : Radius.circular(4.r),
                bottomRight: isUserMessage
                    ? Radius.circular(4.r)
                    : Radius.circular(18.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: isUserMessage
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.messageContent,
                  style: (isUserMessage ? whiteTextStyle : blackTextStyle)
                      .copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4.h),
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isUserMessage
                        ? textWhiteColor.withOpacity(0.7)
                        : textSecondaryColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTypingIndicator() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.r, horizontal: 0.r),
        padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 14.r),
        decoration: BoxDecoration(
          color: backgroundGreyColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18.r),
            topRight: Radius.circular(18.r),
            bottomLeft: Radius.circular(4.r),
            bottomRight: Radius.circular(18.r),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: CircularProgressIndicator(
                  strokeWidth: 2, color: primaryColor),
            ),
            SizedBox(width: 8.w),
            Text(
              "Blu is typing...",
              style: greyTextStyle.copyWith(
                fontSize: 14.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInputField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 8.r),
      decoration: BoxDecoration(
        color: backgroundWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: backgroundGreyColor,
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: TextField(
                controller: _messageController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: "Type your messages...",
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  hintStyle: greyTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 14.sp,
                  ),
                ),
                style: blackTextStyle.copyWith(fontSize: 14.sp),
                onSubmitted: (text) => _handleSendMessage(),
              ),
            ),
          ),
          SizedBox(width: 8.w),
          IconButton(
            onPressed: _handleSendMessage,
            icon: Image.asset(
              'assets/pesawat-icon.png',
              width: 24.r,
              height: 24.r,
              color: primaryColor,
            ),
            iconSize: 28.r,
            visualDensity: VisualDensity.compact,
          ),
        ],
      ),
    );
  }
}
