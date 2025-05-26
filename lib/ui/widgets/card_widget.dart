import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class ArticleCard extends StatelessWidget {
  final String category;
  final String title;
  final String subtitle;
  final String date;
  final String imageUrl;
  final VoidCallback? onTap;

  const ArticleCard({
    super.key,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.imageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: backgroundGreyColor,
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  imageUrl,
                  width: 70,
                  height: 70,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),

              // Text Content
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        date,
                        style: blackTextStyle.copyWith(
                          fontSize: 8,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    // Category
                    Text(
                      category,
                      style: buttonTextStyle.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(
                      title,
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: blackTextStyle.copyWith(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.clip,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecentTransactionCard extends StatelessWidget {
  final Color backgroundIcon;
  final String title;
  final String subtitle;
  final String amount;
  final VoidCallback? onTap;

  const RecentTransactionCard({
    super.key,
    required this.backgroundIcon,
    required this.title,
    required this.subtitle,
    required this.amount,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0).r,
        child: Row(
          children: [
            Container(
              width: 60.r,
              height: 60.r,
              decoration: BoxDecoration(
                color: backgroundIcon,
                borderRadius: BorderRadius.circular(25).r,
              ),
              child: Center(
                child: Icon(
                  Icons.emoji_food_beverage_outlined,
                  color: backgroundWhiteColor,
                  size: 30.r,
                ),
              ),
            ),
            SizedBox(width: 16.r),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 4.r),
                  Text(
                    subtitle,
                    style: blueTextStyle.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 10.sp,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 16.r),
            Text(
              amount,
              style: warningTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class IncomeOutcomeCard extends StatelessWidget {
  final String amount;
  final Color backgroundColor;
  final TextStyle colorTextStyle;
  final String incomeOrOutcome;
  final IconData icon;

  const IncomeOutcomeCard(
      {super.key,
      required this.amount,
      required this.backgroundColor,
      required this.colorTextStyle,
      required this.incomeOrOutcome,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 60.r,
          height: 60.r,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(25).r,
          ),
          child: Stack(
            children: [
              Positioned(
                top: 7,
                left: 7,
                child: Icon(
                  icon,
                  size: 16,
                  color: backgroundWhiteColor,
                ),
              ),
              Center(
                  child: Image.asset(
                'assets/logo-money.png',
                width: 24.r,
                height: 24.r,
              ))
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20).r,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Total $incomeOrOutcome",
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                ),
              ),
              Text(
                NumberFormat.currency(
                  locale: 'id',
                  symbol: 'Rp ',
                  decimalDigits: 0,
                ).format(
                  double.tryParse(amount) ?? 0.0,
                ),
                style: colorTextStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class DateAndPeriodSelector extends StatelessWidget {
  final String month;
  final String day;
  final String selectedDropdown;
  final Function(String?) onDropdownChanged;

  const DateAndPeriodSelector({
    super.key,
    required this.month,
    required this.day,
    required this.selectedDropdown,
    required this.onDropdownChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              month,
              style: blackTextStyle.copyWith(fontWeight: FontWeight.w500),
            ),
            Text(
              day,
              style: blackTextStyle.copyWith(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: backgroundGreyColor,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Row(
            children: [
              SizedBox(width: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: backgroundGreyColor,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: DropdownButton<String>(
                  style: blackTextStyle.copyWith(fontSize: 14),
                  dropdownColor: backgroundGreyColor,
                  underline: SizedBox(),
                  iconSize: 16,
                  isDense: true,
                  value: selectedDropdown,
                  items: ["Monthly", "Weekly", "Daily"]
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
                              style: blackTextStyle.copyWith(fontSize: 14),
                            ),
                          ))
                      .toList(),
                  onChanged: onDropdownChanged,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
