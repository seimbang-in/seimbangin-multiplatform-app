import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeaderSection extends StatelessWidget {
  final String name;
  final String money;
  final String imageUrl;

  const HeaderSection({
    super.key,
    required this.name,
    required this.money,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
            boxShadow: [
              BoxShadow(
                color: backgroundWhiteColor.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
        ),
        Column(
          children: [
            SizedBox(
              width: 100.r,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 44).r,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 60.r,
                        height: 60.r,
                        decoration: BoxDecoration(
                          color: backgroundWhiteColor,
                          borderRadius: BorderRadius.circular(25).r,
                        ),
                        child: Image.network(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(
                              Icons.person, // Ikon fallback
                              color: primaryColor,
                              size: 36.r,
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 12.r,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome 👋",
                            style: whiteTextStyle.copyWith(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            name,
                            style: whiteTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Icon(
                    Icons.notifications_none,
                    color: Colors.white,
                    size: 30,
                  ),
                ],
              ),
            ),
            Text(
              "Current Balance",
              style: whiteTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 12.r,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  NumberFormat.currency(
                          locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                      .format(
                    double.parse(money),
                  ),
                  style: whiteTextStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
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
            style: blackTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            balance,
            style: blackTextStyle.copyWith(
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
          style: blackTextStyle.copyWith(
              fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: blueTextStyle.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
