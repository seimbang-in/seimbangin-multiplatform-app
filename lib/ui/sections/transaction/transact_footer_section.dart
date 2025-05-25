import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionFooterSection extends StatelessWidget {
  final double totalPrice;
  final VoidCallback onAddTransaction;

  const TransactionFooterSection({
    super.key,
    required this.totalPrice,
    required this.onAddTransaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: buttonColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(32),
          topRight: Radius.circular(32),
        ).r,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 34),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Price:',
                  style: whiteTextStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(totalPrice),
                  style: whiteTextStyle.copyWith(
                      fontWeight: FontWeight.w600, fontSize: 14.sp),
                ),
              ],
            ),
            SizedBox(height: 36.r),
            PrimaryFilledButton(
              title: 'Add Transaction',
              onPressed: onAddTransaction,
              backgroundColor: textWhiteColor,
              textColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
