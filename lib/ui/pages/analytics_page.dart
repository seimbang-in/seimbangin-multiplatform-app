import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/header_section.dart';
import 'package:seimbangin_app/ui/widgets/bar_widget.dart';
import 'package:seimbangin_app/ui/widgets/bottom_navigation.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';
import 'package:seimbangin_app/ui/widgets/chart_widget.dart';

BarChartGroupData makeGroupData(int x, double income, double outcome) {
  return BarChartGroupData(
    x: x,
    barRods: [
      BarChartRodData(
        toY: income,
        color: backgroundGreenColor,
        width: 15,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
      BarChartRodData(
        toY: outcome,
        color: backgroundWarningColor,
        width: 15,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(6),
          topRight: Radius.circular(6),
        ),
      ),
    ],
  );
}

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});
  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int selectedTab = 0;
  String selectedDropdown = "Monthly";
  String selectedType = "All";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 70,
        title: Text(
          'Analytics',
          style: blackTextStyle.copyWith(
              fontWeight: FontWeight.bold, fontSize: 20),
        ),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 32,
          ),
          color: Colors.black,
          onPressed: () {
            routes.pushNamed(RouteNames.home);
          },
        ),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 16),
            child: Image.asset(
              'assets/ic_seimbangin-logo-logreg.png',
              width: 50,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnalyticsTabBar(tabController: _tabController),
                CurrentBalanceSection(
                  balance: "Rp 2.500.000",
                ),
                SizedBox(
                  height: 10,
                ),
                DateAndPeriodSelector(
                    month: "agustus",
                    day: "17",
                    selectedDropdown: selectedDropdown,
                    onDropdownChanged: (value) => {
                          setState(() {
                            selectedDropdown = value!;
                          })
                        }),
                SizedBox(
                  height: 30,
                ),
                AnalyticsBarChart(),
                SizedBox(
                  height: 30,
                ),
                RecentTransactionSection(
                  subtitle: "today",
                ),
                SizedBox(
                  height: 10,
                ),
                RecentTransactionCard(
                    backgroundIcon: buttonColor,
                    title: "Mr.B",
                    subtitle: "12:00 Wib",
                    amount: "-Rp 12.000"),
                RecentTransactionCard(
                    backgroundIcon: buttonColor,
                    title: "Zona Bakso",
                    subtitle: "18:00 Wib",
                    amount: "-Rp 18.000"),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButton: ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
