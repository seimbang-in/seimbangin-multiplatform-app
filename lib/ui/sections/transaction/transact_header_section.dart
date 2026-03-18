import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionHeaderSection extends StatelessWidget {
  const TransactionHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomRoundedButton(
          onPressed: () {
            if (routes.canPop()) {
              routes.pop();
            } else {
              routes.pushReplacementNamed(RouteNames.main);
            }
          },
          widget: Icon(
            Icons.chevron_left,
            size: 32.r,
            color: context.color.textSecondaryColor,
          ),
          backgroundColor: context.color.backgroundWhiteColor,
        ),
        Text(
          'Tambah Transaksi',
          style: context.text.blackTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 18.sp,
          ),
        ),
        Image.asset(
          'assets/ic_seimbangin-logo-logreg.png',
        ),
      ],
    );
  }
}
