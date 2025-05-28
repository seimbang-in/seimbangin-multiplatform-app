import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/advice_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class AiAdvisorSection extends StatelessWidget {
  final Advice advice;
  final bool isAdviceExist;
  final VoidCallback financialProfileButtonOntap;

  const AiAdvisorSection({
    super.key,
    required this.advice,
    required this.isAdviceExist,
    required this.financialProfileButtonOntap,
  });

  @override
  Widget build(BuildContext context) {
    const String placeholderFromApi =
        "Please complete your financial profile first";

    final bool hasRealAdvice =
        isAdviceExist && advice.data.trim() != placeholderFromApi;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft),
        borderRadius: BorderRadius.circular(24).r,
      ),
      padding: const EdgeInsets.all(24),
      child: hasRealAdvice
          ? _buildLayoutWithAdvice(context)
          : _buildLayoutWithoutAdvice(context),
    );
  }

  Widget _buildLayoutWithAdvice(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          advice.data,
          style: whiteTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
          softWrap: true,
        ),
        SizedBox(height: 20.r),
        AdvisorButton(onPressedEvent: () {
          routes.pushNamed(RouteNames.chatAdvisor);
        }),
      ],
    );
  }

  Widget _buildLayoutWithoutAdvice(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Text(
            "Please fill in your financial profile data here first to get Financial AI Advice",
            style: whiteTextStyle.copyWith(
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
            softWrap: true,
          ),
        ),
        SizedBox(width: 16.r),
        GestureDetector(
          onTap: financialProfileButtonOntap,
          child: Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              color: backgroundWhiteColor,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Image.asset(
              'assets/ic_alert_financialprof.png',
              width: 24.r,
            ),
          ),
        ),
      ],
    );
  }
}
