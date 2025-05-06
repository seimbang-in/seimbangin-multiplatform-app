import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';

class IncomeOutcomeSection extends StatelessWidget {
  final String incomeAmount;
  final String outcomeAmount;
  const IncomeOutcomeSection(
      {super.key, required this.incomeAmount, required this.outcomeAmount});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(15).r,
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
            borderRadius: BorderRadius.circular(30).r,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IncomeOutcomeCard(
                incomeOrOutcome: "Income",
                amount: incomeAmount,
                backgroundColor: backgroundOldGreenColor,
                colorTextStyle: greenTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
                icon: Icons.arrow_upward_rounded,
              ),
              IncomeOutcomeCard(
                incomeOrOutcome: "Outcome",
                amount: outcomeAmount,
                backgroundColor: backgroundOldWarningColor,
                colorTextStyle: warningTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
                icon: Icons.arrow_downward_rounded,
              ),
            ],
          ),
        ),
        Positioned(
          right: -120.r,
          bottom: -60.r,
          child: Image.asset(
            "assets/img_mascot-login.png",
            width: 250.r,
          ),
        ),
      ],
    );
  }
}
