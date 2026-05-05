import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/chat_message_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class ChatMessagesSection extends StatelessWidget {
  final ScrollController scrollController;
  final List<ChatMessage> messages;

  const ChatMessagesSection({
    super.key,
    required this.scrollController,
    required this.messages,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: scrollController,
      itemCount: messages.length,
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 16.w),
      itemBuilder: (context, index) {
        final message = messages[index];
        final isUserMessage = message.messageType == "user";

        if (message.messageType == "loading") {
          return const ChatTypingIndicator();
        }

        return Align(
          alignment:
              isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.80),
            padding: EdgeInsets.symmetric(vertical: 12.r, horizontal: 16.r),
            margin: EdgeInsets.symmetric(vertical: 4.r),
            decoration: BoxDecoration(
              color: isUserMessage ? context.color.primaryColor : context.color.backgroundGreyColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18.r),
                topRight: Radius.circular(18.r),
                bottomLeft:
                    isUserMessage ? Radius.circular(18.r) : Radius.circular(0),
                bottomRight:
                    isUserMessage ? Radius.circular(0) : Radius.circular(18.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: isUserMessage
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  message.messageContent,
                  style: (isUserMessage ? context.text.whiteTextStyle : context.text.blackTextStyle)
                      .copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.normal,
                          height: 1.4),
                ),
                SizedBox(height: 6.h),
                Text(
                  message.time,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: isUserMessage
                        ? context.color.textWhiteColor.withOpacity(0.7)
                        : context.color.textSecondaryColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ChatTypingIndicator extends StatelessWidget {
  const ChatTypingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.r, horizontal: 0.r),
        padding: EdgeInsets.symmetric(vertical: 10.r, horizontal: 14.r),
        decoration: BoxDecoration(
          color: context.color.backgroundGreyColor,
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
                  strokeWidth: 2, color: context.color.primaryColor),
            ),
            SizedBox(width: 8.w),
            Text(
              "Blu sedang mengetik...",
              style: context.text.greyTextStyle.copyWith(
                fontSize: 14.sp,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
