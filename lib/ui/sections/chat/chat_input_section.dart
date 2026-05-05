import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class ChatInputSection extends StatelessWidget {
  final TextEditingController messageController;
  final VoidCallback onSendMessage;

  const ChatInputSection({
    super.key,
    required this.messageController,
    required this.onSendMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
      decoration: BoxDecoration(
        color: context.color.backgroundWhiteColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            spreadRadius: 0,
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: context.color.backgroundGreySecondaryColor,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: TextField(
                controller: messageController,
                maxLines: 5,
                minLines: 1,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                decoration: InputDecoration(
                  hintText: "Tulis pesan...",
                  border: InputBorder.none,
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                  hintStyle: context.text.greyTextStyle.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: 14.sp,
                  ),
                ),
                style: context.text.blackTextStyle.copyWith(fontSize: 14.sp),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Container(
            height: 48.r,
            width: 48.r,
            decoration: BoxDecoration(
              color: context.color.primaryColor,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              onPressed: onSendMessage,
              icon: Image.asset(
                'assets/pesawat-icon.png',
                width: 20.r,
                height: 20.r,
                color: context.color.textWhiteColor,
              ),
              iconSize: 20.r,
              visualDensity: VisualDensity.compact,
            ),
          ),
        ],
      ),
    );
  }
}
