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
              width: 100,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                        color: backgroundWhiteColor,
                        borderRadius: BorderRadius.circular(25)),
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.person, // Ikon fallback
                          color: primaryColor,
                          size: 36,
                        );
                      },
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome 👋", style: whiteTextStyle),
                      Text(name,
                          style: whiteTextStyle.copyWith(
                              fontWeight: FontWeight.bold)),
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
            SizedBox(height: 10),
            Text("Current Balance",
                style: whiteTextStyle.copyWith(fontWeight: FontWeight.bold)),
            SizedBox(
              height: 10,
            ),
            Stack(
              alignment: Alignment.center,
              children: [
                Text(
                    NumberFormat.currency(
                            locale: 'id', symbol: 'Rp ', decimalDigits: 0)
                        .format(double.parse(money)),
                    style: whiteTextStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 18)),
              ],
            ),
          ],
        ),
        Positioned(
          right: MediaQuery.of(context).size.width * 0.25,
          bottom: MediaQuery.of(context).size.height * 0.062,
          child: IconButton(
            icon: Icon(Icons.visibility_outlined),
            iconSize: 20,
            color: backgroundWhiteColor,
            onPressed: () {},
          ),
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
      padding: EdgeInsets.symmetric(vertical: 20),
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
