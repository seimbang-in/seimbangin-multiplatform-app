import 'package:flutter/material.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class AnalyticsTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> tabTitles;

  const AnalyticsTabBar({
    super.key,
    required this.tabController,
    required this.tabTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      decoration: BoxDecoration(
        color: backgroundGreyColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TabBar(
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorColor: Colors.transparent,
        controller: tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: buttonColor,
        ),
        labelColor: textWhiteColor,
        labelStyle: whiteTextStyle.copyWith(fontWeight: FontWeight.w500),
        unselectedLabelColor: blackTextStyle.color,
        unselectedLabelStyle:
            blackTextStyle.copyWith(fontWeight: FontWeight.w500),
        dividerColor: Colors.transparent,
        tabs: tabTitles.map((title) => Tab(text: title)).toList(),
      ),
    );
  }
}


