import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/chatbot/chatbot_bloc.dart';
import 'package:seimbangin_app/models/chat_message_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class ChatAdvisorPage extends StatefulWidget {
  const ChatAdvisorPage({super.key});
  @override
  State<ChatAdvisorPage> createState() => _ChatAdvisorPageState();
}

class _ChatAdvisorPageState extends State<ChatAdvisorPage> {
  // int _selectedIndex = 2;
  bool _hasChats = false;
  final TextEditingController _messageController = TextEditingController();

  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _handleSendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        _messages.add(
          ChatMessage(
            messageContent: _messageController.text,
            messageType: "user",
            time: "${DateTime.now().hour}:${DateTime.now().minute}",
          ),
        );
        _hasChats = true;
        context.read<ChatbotBloc>().add(
              ChatBotReply(_messageController.text),
            );
        _messageController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 70.r,
        title: Text(
          'AI Advisor',
          style: blackTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
        actions: [
          Container(
            margin: EdgeInsets.only(right: 24),
            child: Image.asset(
              'assets/ic_seimbangin-logo-logreg.png',
              width: 50,
            ),
          ),
        ],
      ),
      backgroundColor: backgroundWhiteColor,
      body: BlocConsumer<ChatbotBloc, ChatbotState>(
        listener: (context, state) {
          if (state is ChatbotSuccess) {
            setState(() {
              print("Current State: $state");
              _messages.add(
                ChatMessage(
                  messageContent: state.reply,
                  messageType: "assistant",
                  time: "${DateTime.now().hour}:${DateTime.now().minute}",
                ),
              );
            });
          } else if (state is ChatbotFailure) {
            print("Current State: $state");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ChatbotLoading) {
            print("Current State: $state");
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: _hasChats
                          ? _buildChatMessages()
                          : _buildWelcomeScreen(),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 150.h,
                            margin: const EdgeInsets.all(32).r,
                            decoration: BoxDecoration(
                              color: backgroundGreyColor, // Warna abu-abu
                              borderRadius: BorderRadius.circular(20)
                                  .r, // Radius melingkar
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ).r,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: TextField(
                                    controller: _messageController,
                                    maxLines: null,
                                    decoration: InputDecoration(
                                      hintText: "Ask with Advisor...",
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(top: 8).r,
                                      hintStyle: greyTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                    style: blackTextStyle.copyWith(
                                      fontSize: 16.sp,
                                      color: Colors.black, // Warna teks
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                  ],
                ),
                Positioned(
                  bottom: MediaQuery.of(context).size.width * 0.14,
                  right: MediaQuery.of(context).size.width * 0.1,
                  child: IconButton(
                    onPressed: () {
                      _handleSendMessage();
                    },
                    icon: Image.asset(
                      'assets/pesawat-icon.png',
                      width: 24.r,
                      height: 24.r,
                    ),
                    iconSize: 32.r, // Ukuran area klik
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset(
                'assets/img_mascot-login.png',
                width: 200.w,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            "Hi, Nice to meet you",
            style: blackTextStyle.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatMessages() {
    return ListView.builder(
      itemCount: _messages.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16).r,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(
            left: _messages[index].messageType == "user" ? 80 : 0,
            right: _messages[index].messageType == "user" ? 0 : 80,
          ).r,
          margin: const EdgeInsets.symmetric(vertical: 8).r,
          child: Column(
            crossAxisAlignment: _messages[index].messageType == "user"
                ? CrossAxisAlignment.end
                : CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(16).r,
                decoration: BoxDecoration(
                  color: _messages[index].messageType == "user"
                      ? Colors.blue
                      : Colors.grey[300],
                  borderRadius: BorderRadius.circular(20).r,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (_messages[index].messageType != "user")
                      Container(
                        width: 30.w,
                        height: 30.h,
                        margin: const EdgeInsets.only(right: 8).r,
                        decoration: const BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            "A-I",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                      ),
                    Flexible(
                      child: Text(_messages[index].messageContent,
                          style: whiteTextStyle.copyWith(
                            fontWeight: FontWeight.bold,
                            color: _messages[index].messageType == "user"
                                ? Colors.white
                                : Colors.black,
                          )),
                    ),
                  ],
                ),
              ),
              if (_messages[index].messageType == "user")
                Padding(
                  padding: const EdgeInsets.only(top: 4, right: 8).r,
                  child: Text(
                    _messages[index].time,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
