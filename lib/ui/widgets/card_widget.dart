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
  // 1. Ganti nama 'backgroundIcon' menjadi 'backgroundColor' agar lebih jelas
  final Color backgroundColor;
  // 2. Tambahkan parameter 'icon' yang bertipe Widget
  final Widget icon;
  final String title;
  final String subtitle;
  final String amount;
  final VoidCallback? onTap;
  final Color? amountColor;

  const RecentTransactionCard({
    super.key,
    required this.backgroundColor,
    required this.icon, // Jadikan 'icon' sebagai parameter wajib
    required this.title,
    required this.subtitle,
    required this.amount,
    this.onTap,
    this.amountColor,
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
                // Gunakan parameter backgroundColor
                color: backgroundColor,
                borderRadius: BorderRadius.circular(25).r,
              ),
              child: Center(
                // 3. Gunakan widget 'icon' yang diterima dari parameter
                child: icon,
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
              style: blackTextStyle.copyWith(
                color: amountColor ?? textGreenColor,
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

class DetailAnalytic extends StatelessWidget {
  final String price;
  final bool isIncome;
  const DetailAnalytic({
    super.key,
    required this.price,
    required this.isIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          price,
          overflow: TextOverflow.ellipsis,
          style: blackTextStyle.copyWith(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 4.h,
        ),
        // CONTAINER TIPE
        Container(
          decoration: BoxDecoration(
            color: backgroundBlueColor,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              CircleAvatar(
                radius: 14.r,
                backgroundColor:
                    isIncome == true ? textGreenColor : textWarningColor,
                child: Icon(
                  isIncome == true
                      ? Icons.keyboard_arrow_up_outlined
                      : Icons.keyboard_arrow_down_outlined,
                  color: textWhiteColor,
                ),
              ),
              SizedBox(
                width: 6.w,
              ),
              Text(
                isIncome == true ? 'Pemasukan' : 'Pengeluaran',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w500,
                  fontSize: 10.sp,
                ),
              ),
              SizedBox(
                width: 12.w,
              ),
            ],
          ),
        )
      ],
    );
  }
}

class StaticNoTransaction extends StatelessWidget {
  final VoidCallback? onTap;
  const StaticNoTransaction({
    super.key,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      width: double.infinity,
      decoration: BoxDecoration(
        color: textWhiteColor,
        borderRadius: BorderRadius.circular(18.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Belum Ada Transaksi',
                style: blueTextStyle.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(
                height: 4.h,
              ),
              Text(
                'Anda belum melakukan transaksi sama sekali',
                style: greyTextStyle.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: onTap,
            child: Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                gradient: LinearGradient(
                  colors: [
                    gradientBlueStartColor,
                    gradientBlueEndColor,
                  ],
                ),
              ),
              child: Center(
                child: Icon(
                  Icons.add,
                  size: 24.r,
                  color: skyBlueColor,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
