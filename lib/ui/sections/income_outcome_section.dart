import 'package:flutter/material.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';

class IncomeOutcomeSection extends StatelessWidget {
  const IncomeOutcomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none, 
      children: [
        Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: backgroundWhiteColor,
            boxShadow: [
              BoxShadow(
                color: buttonColor.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 2,
                offset: Offset(0, 4),
              )
            ],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IncomeOutcomeCard(
                amount: 0,
                backgroundColor: backgroundGreenColor,
                colorTextStyle:
                    greenTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
              IncomeOutcomeCard(
                amount: 240000,
                backgroundColor: textWarningColor,
                colorTextStyle:
                    warningTextStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Positioned(
          right: -120,
          bottom: -60,
          child: Image.asset(
            "assets/img_mascot-login.png",
            width: 250,
          ),
        ),
      ],
    );
  }
}
