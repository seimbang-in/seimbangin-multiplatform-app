import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class IncomeOutcomeSection extends StatefulWidget {
  final String balance;
  final String incomeAmount;
  final String outcomeAmount;

  const IncomeOutcomeSection({
    super.key,
    required this.balance,
    required this.incomeAmount,
    required this.outcomeAmount,
  });

  @override
  State<IncomeOutcomeSection> createState() => _IncomeOutcomeSectionState();
}

class _IncomeOutcomeSectionState extends State<IncomeOutcomeSection> {
  bool _isObscured = false;

  String _formatCurrency(String value) {
    if (value.isEmpty || value == 'null') return 'Rp 0';
    final doubleVal = double.tryParse(value) ?? 0;
    return NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0)
        .format(doubleVal);
  }

  String _getDisplayText(String value) {
    if (_isObscured) {
      return 'Rp ••••••••';
    }
    return _formatCurrency(value);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: 32.h,
            left: 20.w,
            right: 20.w,
            bottom: 12.h,
          ),
          child: Row(
            children: [
              Text(
                'Saldo',
                style: blackTextStyle.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child: Icon(
                  _isObscured ? Icons.visibility_off : Icons.visibility,
                  color: Colors.black54,
                  size: 24.sp,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18.r),
              gradient: LinearGradient(
                colors: [
                  darkPrimaryColor,
                  secondaryColor,
                  buttonColor,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            padding: EdgeInsets.all(20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ==== Shape ===
                Container(
                  width: MediaQuery.sizeOf(context).width * 0.55.w,
                  height: 11.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    gradient: LinearGradient(
                      colors: [
                        primaryColor,
                        secondaryColor,
                        darkPrimaryColor,
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),

                // === Row Saldo
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _getDisplayText(widget.balance),
                      style: whiteTextStyle.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.asset(
                      'assets/icon_app.png',
                      width: 48.w,
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      width: 25.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.r),
                        color: darkPrimaryColor,
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/ic_updown.svg',
                          width: 15.w,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 6.w,
                    ),
                    Text(
                      'Saldo saat ini',
                      style: whiteTextStyle.copyWith(),
                    )
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // PENGELUARAN COLUMN
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getDisplayText(widget.outcomeAmount),
                          style: whiteTextStyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        // PENGELUARAN CONTAINER
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.h,
                            vertical: 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: darkPrimaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 12.r,
                                backgroundColor: textWarningColor,
                                child: Icon(Icons.arrow_drop_up_sharp),
                              ),
                              SizedBox(
                                width: 6.h,
                              ),
                              Text(
                                "Pengeluaran",
                                style: whiteTextStyle,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    // END OF PENGELUARAN COLUMN

                    // PEMASUKAN COLUMN
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _getDisplayText(widget.incomeAmount),
                          style: whiteTextStyle.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        // PENGELUARAN CONTAINER
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.h,
                            vertical: 4.w,
                          ),
                          decoration: BoxDecoration(
                            color: darkPrimaryColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 12.r,
                                backgroundColor: backgroundOldGreenColor,
                                child: Icon(Icons.arrow_drop_down_sharp),
                              ),
                              SizedBox(
                                width: 6.h,
                              ),
                              Text(
                                "Pemasukan",
                                style: whiteTextStyle,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                    // END OF PEMASUKAN COLUMN
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
