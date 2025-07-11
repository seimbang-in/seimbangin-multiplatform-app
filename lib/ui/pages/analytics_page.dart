import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/donut_chart_model.dart';
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarPrimaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        backgroundColor: backgroundGreySecondaryColor,
        // appBar: AppBar(
        //   backgroundColor: Colors.transparent,
        //   automaticallyImplyLeading: false,
        //   centerTitle: true,
        //   toolbarHeight: 70.r,
        //   title: Text(
        //     'Analytics',
        //     style: blackTextStyle.copyWith(
        //       fontWeight: FontWeight.bold,
        //       fontSize: 20.sp,
        //     ),
        //   ),
        //   elevation: 0,
        //   actions: [
        //     Container(
        //       margin: EdgeInsets.only(right: 16),
        //       child: Image.asset(
        //         'assets/ic_seimbangin-logo-logreg.png',
        //         width: 50,
        //       ),
        //     ),
        //   ],
        // ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(20.r),
            children: [
              SizedBox(
                height: 24.h,
              ),
              Text(
                'Bulan Lalu vs Sekarang',
                style: blackTextStyle.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 12.h,
              ),

              // CONTAINER
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: textWhiteColor,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Sekarang',
                        style: greyTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),

                      // SEKARANG
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DetailAnalytic(
                            price: 'Rp 320.000',
                            isIncome: true,
                          ),
                          DetailAnalytic(
                            price: 'Rp 9.200.000',
                            isIncome: false,
                          )
                        ],
                      ),

                      SizedBox(
                        height: 12.h,
                      ),

                      Text(
                        'Bulan Lalu',
                        style: greyTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8.h,
                      ),

                      // Bulan Lalu
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          DetailAnalytic(
                            price: 'Rp 0.0',
                            isIncome: true,
                          ),
                          DetailAnalytic(
                            price: 'Rp 0.0',
                            isIncome: false,
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
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
          style: blackTextStyle.copyWith(
            fontSize: 18.sp,
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
