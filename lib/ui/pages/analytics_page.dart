import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/models/donut_chart_model.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
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

  final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  // COLOR LIST FOR CATEGORIES
  final List<Color> _categoryColors = [
    Colors.amber,
    Colors.blue,
    Colors.red,
    Colors.greenAccent,
    Colors.purple,
    Colors.orange,
    Colors.teal,
    Colors.pink,
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

    context
        .read<TransactionBloc>()
        .add(FetchHistoryTransactions(isRefresh: true));
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _secondaryTabController.dispose();
    super.dispose();
  }

  ({
    double currentIncome,
    double currentOutcome,
    double lastMonthIncome,
    double lastMonthOutcome
  }) _processComparisonData(List<TransactionData> transactions) {
    double currentIncome = 0;
    double currentOutcome = 0;
    double lastMonthIncome = 0;
    double lastMonthOutcome = 0;

    final now = DateTime.now();
    // Batas awal bulan ini (misal: 1 Nov 2025)
    final startOfCurrentMonth = DateTime(now.year, now.month, 1);
    // Batas awal bulan lalu (misal: 1 Okt 2025)
    final startOfLastMonth = DateTime(now.year, now.month - 1, 1);

    for (final transaction in transactions) {
      final createdAt = DateTime.tryParse(transaction.createdAt ?? '');
      if (createdAt == null) continue;

      final amount = double.tryParse(transaction.amount) ?? 0.0;

      if (createdAt.isAfter(startOfCurrentMonth)) {
        // --- Data Bulan Ini ---
        if (transaction.type == 0) {
          // 0 = Income
          currentIncome += amount;
        } else if (transaction.type == 1) {
          // 1 = Outcome
          currentOutcome += amount;
        }
      } else if (createdAt.isAfter(startOfLastMonth)) {
        // --- Data Bulan Lalu ---
        if (transaction.type == 0) {
          // 0 = Income
          lastMonthIncome += amount;
        } else if (transaction.type == 1) {
          // 1 = Outcome
          lastMonthOutcome += amount;
        }
      }
    }

    return (
      currentIncome: currentIncome,
      currentOutcome: currentOutcome,
      lastMonthIncome: lastMonthIncome,
      lastMonthOutcome: lastMonthOutcome
    );
  }

  List<ChartSection> _processCategoryData(
      List<TransactionData> transactions, int tabIndex) {
    final Map<String, double> categoryTotals = {};

    for (final transaction in transactions) {
      // FILTER DATA INDEX
      if (tabIndex == 1 && transaction.type != 0) continue;
      if (tabIndex == 2 && transaction.type != 1) continue;

      // GET CATEGORIES FROM ITEMS
      for (final item in transaction.items) {
        final String category =
            item.category.isNotEmpty ? item.category : 'others';
        final double subtotal = double.tryParse(item.subtotal) ?? 0.0;

        categoryTotals.update(
          category,
          (value) => value + subtotal,
          ifAbsent: () => subtotal,
        );
      }
    }

    if (categoryTotals.isEmpty) {
      return []; // return empty list
    }

    return categoryTotals.entries.map((entry) {
      return ChartSection(
        title: entry.key,
        value: entry.value,
        color: _getColorForCategory(entry.key),
      );
    }).toList()
      ..sort((a, b) => b.value.compareTo(a.value));
  }

  Color _getColorForCategory(String category) {
    int hash = category.hashCode;
    return _categoryColors[hash.abs() % _categoryColors.length];
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarPrimaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: backgroundGreySecondaryColor,
        body: SafeArea(
          child: BlocBuilder<TransactionBloc, TransactionState>(
            builder: (context, state) {
              if (state is TransactionLoading &&
                  state is! TransactionLoadSuccess) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is TransactionFailure) {
                return Center(child: Text('Error: ${state.message}'));
              }

              List<TransactionData> transactions = [];
              if (state is TransactionLoadSuccess) {
                transactions = state.historicalTransactions;
              }

              final comparisonData = _processComparisonData(transactions);

              final categoryData =
                  _processCategoryData(transactions, selectedMainTab);
              return ListView(
                padding: EdgeInsets.all(20.r),
                children: [
                  Text(
                    'Last Month vs Now',
                    style: blackTextStyle.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),

                  // CARD DATA
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
                            'Now',
                            style: greyTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),

                          // --- IMPLEMENT THIS MONTH DATA
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DetailAnalytic(
                                price: _currencyFormatter
                                    .format(comparisonData.currentIncome),
                                isIncome: true,
                              ),
                              DetailAnalytic(
                                price: _currencyFormatter
                                    .format(comparisonData.currentOutcome),
                                isIncome: false,
                              )
                            ],
                          ),

                          SizedBox(
                            height: 12.h,
                          ),

                          Text(
                            'Last Month',
                            style: greyTextStyle.copyWith(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),

                          // --- IMPLEMENT LAST MONTH DATA
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              DetailAnalytic(
                                price: _currencyFormatter
                                    .format(comparisonData.lastMonthIncome),
                                isIncome: true,
                              ),
                              DetailAnalytic(
                                price: _currencyFormatter
                                    .format(comparisonData.lastMonthOutcome),
                                isIncome: false,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 18.h,
                  ),

                  Text(
                    'Transaction Categories',
                    style: blackTextStyle.copyWith(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    'Number of transactions by category',
                    style: greyTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  SizedBox(
                    height: 12.h,
                  ),

                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: textWhiteColor,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: TabBar(
                      controller: _mainTabController,
                      indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: primaryColor,
                      ),
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorPadding: EdgeInsets.all(4.r),
                      labelColor: textWhiteColor,
                      unselectedLabelColor: textPrimaryColor,
                      labelStyle: whiteTextStyle.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                      unselectedLabelStyle: blackTextStyle.copyWith(
                          fontSize: 12.sp, fontWeight: FontWeight.bold),
                      tabs: mainTabTitles
                          .map((title) => Tab(text: title))
                          .toList(),
                    ),
                  ),

                  SizedBox(
                    height: 12.h,
                  ),

                  categoryData.isEmpty
                      ? StaticNoTransaction(
                          onTap: () => print(
                            'You clicked add transaction on static no transact card!',
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(
                            color: textWhiteColor,
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          padding: EdgeInsets.all(16.r),
                          child: Column(
                            children: [
                              AnalyticsDonutChart(sections: categoryData),
                              SizedBox(height: 16.h),
                              ..._buildLegend(categoryData)
                            ],
                          ),
                        ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  List<Widget> _buildLegend(List<ChartSection> data) {
    return data.map((section) {
      return Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.h,
              color: section.color,
            ),
            SizedBox(width: 8.w),
            Text(
              section.title.substring(0, 1).toUpperCase() +
                  section.title.substring(1),
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              _currencyFormatter.format(section.value),
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
