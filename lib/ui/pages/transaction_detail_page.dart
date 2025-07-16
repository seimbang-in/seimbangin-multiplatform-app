import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart'
    as model;
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

// Helper Widget untuk Dotted Divider
class DottedDivider extends StatelessWidget {
  final double height;
  final Color color;
  final double dashWidth;

  const DottedDivider({
    super.key,
    this.height = 1,
    this.color = Colors.grey,
    this.dashWidth = 5.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: height,
              child: DecoratedBox(
                decoration: BoxDecoration(color: color),
              ),
            );
          }),
        );
      },
    );
  }
}

class TransactionDetailPage extends StatefulWidget {
  final model.TransactionData transactionData;
  const TransactionDetailPage({super.key, required this.transactionData});

  @override
  State<TransactionDetailPage> createState() => _TransactionDetailPageState();
}

class _TransactionDetailPageState extends State<TransactionDetailPage> {
  bool _isDetailsExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isOutcome = widget.transactionData.type == 1;
    final double totalAmount =
        double.tryParse(widget.transactionData.amount) ?? 0.0;
    final DateTime transactionDate = DateTime.parse(
        widget.transactionData.createdAt ?? DateTime.now().toIso8601String());

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                textButtonColor,
                textWhiteColor,
              ],
            ),
          ),
          child: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRoundedButton(
                        onPressed: () => routes.pop(),
                        widget: Icon(
                          Icons.chevron_left,
                          size: 32.r,
                          color: textSecondaryColor,
                        ),
                        backgroundColor: backgroundWhiteColor,
                      ),
                      Text(
                        'Detail Transaction',
                        style: whiteTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      ),
                      Image.asset('assets/ic_seimbangin-logo-logreg.png'),
                    ],
                  ),
                  SizedBox(height: 32.h),

                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 32)
                            .r,
                    decoration: BoxDecoration(
                      color: backgroundWhiteColor,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 20,
                            spreadRadius: 5)
                      ],
                      borderRadius: BorderRadius.circular(32.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Transaction',
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            widget.transactionData.name,
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 28.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('dd MMMM yyyy')
                                  .format(transactionDate),
                              style: greyTextStyle.copyWith(fontSize: 12.sp),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Icon(Icons.circle,
                                  size: 4, color: textSecondaryColor),
                            ),
                            Text(
                              DateFormat('HH:mm').format(transactionDate),
                              style: greyTextStyle.copyWith(fontSize: 12.sp),
                            ),
                          ],
                        ),
                        SizedBox(height: 12.h),
                        const DottedDivider(),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Container(
                              height: 14.h,
                              width: 14.w,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isOutcome
                                    ? backgroundWarningColor
                                    : textGreenColor,
                              ),
                              child: Icon(
                                isOutcome
                                    ? Icons.arrow_upward_rounded
                                    : Icons.arrow_downward_rounded,
                                color: textWhiteColor,
                                size: 8.sp,
                              ),
                            ),
                            SizedBox(width: 4.h),
                            Text(
                              isOutcome ? 'Outcome' : 'Income',
                              style: (isOutcome
                                      ? warningTextStyle
                                      : greenTextStyle)
                                  .copyWith(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 12.h),
                        Container(
                          height: 32.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(12).r),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10).r,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  isOutcome ? 'Total Outcome' : 'Total Income',
                                  style: whiteTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0)
                                      .format(totalAmount),
                                  style: whiteTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 18.h),
                        const Divider(),
                        SizedBox(height: 18.h),

                        InkWell(
                          onTap: () => setState(
                              () => _isDetailsExpanded = !_isDetailsExpanded),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Detail Transactions',
                                    style: blackTextStyle.copyWith(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14.sp)),
                                AnimatedRotation(
                                  turns: _isDetailsExpanded ? 0.5 : 0,
                                  duration: const Duration(milliseconds: 300),
                                  child: Icon(Icons.expand_more,
                                      color: textSecondaryColor),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Daftar Item
                        Column(
                          children: widget.transactionData.items
                              .asMap()
                              .entries
                              .map((entry) {
                            int index = entry.key;
                            final item = entry.value;

                            // Tampilkan item jika expanded, atau hanya jika item pertama
                            final bool isVisible =
                                _isDetailsExpanded || index == 0;

                            return AnimatedCrossFade(
                              firstChild: _buildItemTile(item),
                              secondChild: Container(),
                              crossFadeState: isVisible
                                  ? CrossFadeState.showFirst
                                  : CrossFadeState.showSecond,
                              duration: const Duration(milliseconds: 300),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 64.h),
                  PrimaryFilledButton(
                    onPressed: () {},
                    title: 'Share',
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper untuk membangun setiap baris item
  Widget _buildItemTile(model.TransactionItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.itemName,
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.w500, fontSize: 12.sp),
                ),
                Text(
                  'Qty: ${item.quantity}',
                  style: greyTextStyle.copyWith(fontSize: 10.sp),
                ),
              ],
            ),
          ),
          Text(
            NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                .format(double.tryParse(item.price) ?? 0),
            style: blackTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 12.sp,
                color: buttonColor),
          ),
        ],
      ),
    );
  }
}
