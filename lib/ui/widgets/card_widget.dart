import 'package:flutter/material.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class ArticleCard extends StatelessWidget {
  final String category;
  final String title;
  final String subtitle;
  final String date;
  final String imageUrl;

  const ArticleCard({
    super.key,
    required this.category,
    required this.title,
    required this.subtitle,
    required this.date,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
    );
  }
}

class RecentTransactionCard extends StatelessWidget {
  final Color backgroundIcon;
  final String title;
  final String subtitle;
  final String amount;

  const RecentTransactionCard({
    super.key,
    required this.backgroundIcon,
    required this.title,
    required this.subtitle,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundIcon,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              Center(
                child: Icon(
                  Icons.emoji_food_beverage,
                  color: backgroundWhiteColor,
                  size: 30,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: blackTextStyle.copyWith(fontWeight: FontWeight.bold)),
              Text(subtitle,
                  style: blueTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 12)),
            ],
          ),
        ),
        Spacer(),
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            amount,
            style: warningTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }
}

class IncomeOutcomeCard extends StatelessWidget {
  final int amount;
  final Color backgroundColor;
  final TextStyle colorTextStyle;

  const IncomeOutcomeCard({
    super.key,
    required this.amount,
    required this.backgroundColor,
    required this.colorTextStyle
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(25),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 7,
                left: 7,
                child: Icon(
                  Icons.arrow_downward,
                  size: 16,
                  color: backgroundWhiteColor,
                ),
              ),
              Center(
                child: Icon(
                  Icons.currency_bitcoin_outlined,
                  color: backgroundWhiteColor,
                  size: 30,
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Total Income",
                  style: blackTextStyle.copyWith(fontWeight: FontWeight.bold)),
              Text("Rp $amount",
                  style: colorTextStyle),
            ],
          ),
        )
      ],
    );
  }
}
