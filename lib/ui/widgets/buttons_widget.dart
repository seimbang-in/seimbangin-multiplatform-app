import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class PrimaryFilledButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? textColor;

  const PrimaryFilledButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 60,
    this.onPressed,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor ?? buttonColor, // Default color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24).r,
          ),
        ),
        child: Text(title,
            style: whiteTextStyle.copyWith(
              color: textColor ?? textWhiteColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            )),
      ),
    );
  }
}

class CustomRoundedButton extends StatelessWidget {
  final double width;
  final double height;
  final bool isEnable;
  final Widget widget;
  final Color backgroundColor;
  final VoidCallback? onPressed;
  const CustomRoundedButton({
    super.key,
    this.width = 60,
    this.height = 60,
    this.isEnable = true,
    required this.widget,
    required this.backgroundColor,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: (isEnable == true)
          ? TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24).r,
                ),
                side: BorderSide(
                  color: backgroundGreyColor,
                  width: 2.w,
                ),
              ),
              child: widget,
            )
          : TextButton(
              onPressed: null,
              style: TextButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24).r,
                ),
                side: BorderSide(
                  color: backgroundGreyColor,
                  width: 2.w,
                ),
              ),
              child: Icon(Icons.chevron_left),
            ),
    );
  }
}

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: buttonColor.withOpacity(0.5),
            blurRadius: 20,
            spreadRadius: 2,
            offset: Offset(0, 4)),
      ]),
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.white,
        elevation: 4,
        shape: CircleBorder(),
        child: Icon(Icons.qr_code_scanner, color: Colors.blue, size: 30),
      ),
    );
  }
}

class AdvisorButton extends StatelessWidget {
  final dynamic onPressedEvent;
  const AdvisorButton({super.key, required this.onPressedEvent});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressedEvent,
      style: OutlinedButton.styleFrom(
          side: BorderSide(color: backgroundWhiteColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16).r,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 14).r,
          backgroundColor: Colors.transparent),
      child: Text(
        "Chat Advisor",
        style: whiteTextStyle.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class AddItemTransactButton extends StatelessWidget {
  final VoidCallback onPressed;
  final double width;
  final double height;
  final String title;

  const AddItemTransactButton({
    super.key,
    required this.onPressed,
    this.width = double.infinity,
    this.height = 60,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: backgroundGreyColor,
          borderRadius: BorderRadius.circular(
            24,
          ).r,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 8.w,
            ),
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(
                  18,
                ).r,
              ),
              child: Icon(
                Icons.add_box_outlined,
                color: textWhiteColor,
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Text(
              title,
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
