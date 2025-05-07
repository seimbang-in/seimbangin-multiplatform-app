import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/donut_chart_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/header_section.dart';
import 'package:seimbangin_app/ui/widgets/bar_widget.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';
import 'package:seimbangin_app/ui/widgets/chart_widget.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});
  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage>
    with TickerProviderStateMixin {
  late TabController _mainTabController;
  late TabController _secondaryTabController;
  int selectedMainTab = 0;
  int selectedSecondaryTab = 0;
  String selectedDropdown = "Monthly";
  final List<String> mainTabTitles = ["All", "Income", "Outcome"];
  final List<String> secondaryTabTitles = ["Day", "Week", "1 Month", "6 Month"];
  final incomeData = [
    ChartSection(title: 'Parent', value: 68, color: Colors.amber),
    ChartSection(title: 'Freelance', value: 20, color: Colors.blue),
    ChartSection(title: 'Bonus', value: 12, color: Colors.red),
    ChartSection(title: "kocak", value: 70, color: Colors.greenAccent),
  ];

  @override
  void initState() {
    super.initState();
    _mainTabController =
        TabController(length: mainTabTitles.length, vsync: this);
    _secondaryTabController =
        TabController(length: secondaryTabTitles.length, vsync: this);

    _mainTabController.addListener(() {
      if (!_mainTabController.indexIsChanging) {
        setState(() {
          selectedMainTab = _mainTabController.index;
        });
      }
    });
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _secondaryTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundWhiteColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        toolbarHeight: 70.r,
        title: Text(
          'Analytics',
          style: blackTextStyle.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
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
                AnalyticsTabBar(
                  tabController: _mainTabController,
                  tabTitles: mainTabTitles,
                ),
                Visibility(
                  visible: selectedMainTab == 1 || selectedMainTab == 2,
                  child: AnalyticsTabBar(
                    tabController: _secondaryTabController,
                    tabTitles: secondaryTabTitles,
                  ),
                ),
                if (selectedMainTab == 0) ...[
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
                ],
                if (selectedMainTab == 1 || selectedMainTab == 2)
                  AnalyticsDonutChart(sections: incomeData),
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
    );
  }
}
