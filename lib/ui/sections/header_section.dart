import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/advice_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';

class HeaderSection extends StatelessWidget {
  final String name;
  final String money;
  final String imageUrl;
  final bool isAdviceLoading;
  final String? adviceError;
  final Advice? advice;
  final bool isAdviceExist;
  final VoidCallback financialProfileButtonOntap;

  const HeaderSection({
    super.key,
    required this.name,
    required this.money,
    required this.imageUrl,
    this.isAdviceLoading = false,
    this.adviceError,
    this.advice,
    this.isAdviceExist = false,
    required this.financialProfileButtonOntap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24.h,
        ),
        Text(
          'AI Advisor',
          style: context.text.blackTextStyle.copyWith(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 24.h,
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            // KONTEN CARD
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.r),
                gradient: LinearGradient(
                  colors: [
                    context.color.secondaryColor,
                    context.color.secondaryColor,
                    context.color.backgroundWhiteColor
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              padding: EdgeInsets.all(20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAdviceContent(context),
                ],
              ),
            ),

            Positioned(
              top: -100.h,
              right: -10.w,
              child: Image.asset(
                "assets/img_onboarding2.png",
                width: 180.w,
              ),
            ),
          ],
        ),
      ],
    );
    // Container(
    //   height: MediaQuery.of(context).size.height * 0.4,
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //         colors: [context.color.primaryColor, context.color.secondaryColor],
    //         begin: Alignment.topCenter,
    //         end: Alignment.bottomCenter),
    //     boxShadow: [
    //       BoxShadow(
    //         color: context.color.backgroundWhiteColor.withOpacity(0.2),
    //         blurRadius: 10,
    //         spreadRadius: 2,
    //         offset: Offset(0, 4),
    //       ),
    //     ],
    //   ),
    // ),
    // Column(
    //   children: [
    //     SizedBox(
    //       width: 100.r,
    //     ),
    //     Padding(
    //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 44).r,
    //       child: Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Row(
    //             children: [
    //               Container(
    //                 width: 60.r,
    //                 height: 60.r,
    //                 decoration: BoxDecoration(
    //                   color: context.color.backgroundWhiteColor,
    //                   borderRadius: BorderRadius.circular(25).r,
    //                 ),
    //                 child: CachedNetworkImage(
    //                   imageUrl: imageUrl,
    //                   fit: BoxFit.cover,
    //                   errorWidget: (context, error, stackTrace) {
    //                     return Icon(
    //                       Icons.person,
    //                       color: context.color.primaryColor,
    //                       size: 36.r,
    //                     );
    //                   },
    //                 ),
    //               ),
    //               SizedBox(
    //                 width: 12.r,
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     "Welcome 👋",
    //                     style: context.text.whiteTextStyle.copyWith(
    //                       fontSize: 12.sp,
    //                       fontWeight: FontWeight.w500,
    //                     ),
    //                   ),
    //                   Text(
    //                     name,
    //                     style: context.text.whiteTextStyle.copyWith(
    //                       fontWeight: FontWeight.bold,
    //                       fontSize: 16.sp,
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //           SizedBox(
    //             width: 80,
    //           ),
    //           Icon(
    //             Icons.notifications_none,
    //             color: Colors.white,
    //             size: 30,
    //           ),
    //         ],
    //       ),
    //     ),
    //     Text(
    //       "Current Balance",
    //       style: context.text.whiteTextStyle.copyWith(
    //         fontSize: 14.sp,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //     SizedBox(
    //       height: 12.r,
    //     ),
    //     Stack(
    //       alignment: Alignment.center,
    //       children: [
    //         Text(
    //           NumberFormat.currency(
    //                   locale: 'id', symbol: 'Rp ', decimalDigits: 0)
    //               .format(
    //             double.parse(money),
    //           ),
    //           style: context.text.whiteTextStyle.copyWith(
    //             fontWeight: FontWeight.bold,
    //             fontSize: 20.sp,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  }

  Widget _buildAdviceContent(BuildContext context) {
    if (isAdviceLoading) {
      return Container(
        height: 50.h,
        alignment: Alignment.centerLeft,
        child: const CircularProgressIndicator(color: Colors.white),
      );
    } else if (adviceError != null) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            color: Colors.white70,
            size: 28.r,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Ups! Layanan AI sedang penuh 🤖",
                  style: context.text.whiteTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Tenang saja, Anda tetap bisa mencatat dan memantau keuangan Anda secara manual sepuasnya!",
                  style: context.text.whiteTextStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.normal,
                    color: Colors.white.withValues(alpha: 0.9),
                  ),
                  softWrap: true,
                ),
              ],
            ),
          ),
        ],
      );
    } else if (advice != null) {
      const String placeholderFromApi =
          "Please complete your financial profile first";

      final bool hasRealAdvice =
          isAdviceExist && advice!.data.trim() != placeholderFromApi;

      if (hasRealAdvice) {
        return Text(
          advice!.data,
          style: context.text.whiteTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
          softWrap: true,
        );
      } else {
        return Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                "Please fill in your financial profile data here first to get Financial AI Advice",
                style: context.text.whiteTextStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
                softWrap: true,
              ),
            ),
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: financialProfileButtonOntap,
              child: Container(
                width: 50.r,
                height: 50.r,
                decoration: BoxDecoration(
                  color: context.color.backgroundWhiteColor,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Center(
                  child: Image.asset(
                    'assets/ic_alert_financialprof.png',
                    width: 24.r,
                  ),
                ),
              ),
            ),
          ],
        );
      }
    } else {
      return Text(
        "Saran AI tidak tersedia saat ini.",
        style: context.text.whiteTextStyle.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
        ),
      );
    }
  }
}

class CurrentBalanceSection extends StatelessWidget {
  final String balance;
  const CurrentBalanceSection({super.key, this.balance = "Rp 2.500.000"});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20).r,
      width: double.infinity,
      child: Column(
        children: [
          Text(
            "Current Balance",
            style: context.text.blackTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            balance,
            style: context.text.blackTextStyle.copyWith(
                fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ],
      ),
    );
  }
}

class RecentTransactionSection extends StatelessWidget {
  final String subtitle;

  const RecentTransactionSection({
    super.key,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Transaction",
          style: context.text.blackTextStyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: context.text.blueTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
