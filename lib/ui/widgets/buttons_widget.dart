import 'package:flutter/material.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class PrimaryFilledButton extends StatelessWidget {
  final String title;
  final double width;
  final double height;
  final bool isEnable;
  final VoidCallback? onPressed;

  const PrimaryFilledButton({
    super.key,
    required this.title,
    this.width = double.infinity,
    this.height = 60,
    this.isEnable = true,
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
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                title,
                style: whiteTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          : TextButton(
              onPressed: null,
              style: TextButton.styleFrom(
                backgroundColor: backgroundGreyColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
              child: Text(
                title,
                style: whiteTextStyle.copyWith(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
    );
  }
}
