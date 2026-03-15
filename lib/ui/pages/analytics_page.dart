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
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/ui/sections/header_section.dart';
import 'package:seimbangin_app/ui/sections/homepage/home_recent_transact_section.dart';

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
  final List<String> mainTabTitles = ["Semua", "Pemasukan", "Pengeluaran"];
  final List<String> secondaryTabTitles = [
    "Hari",
    "Minggu",
    "1 Bulan",
    "6 Bulan"
  ];

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
      if (transaction.createdAt == null) continue;

      final date = DateTime.parse(transaction.createdAt!).toLocal();
      final amount = double.tryParse(transaction.amount) ?? 0.0;

      if (date.isAfter(startOfCurrentMonth) ||
          date.isAtSameMomentAs(startOfCurrentMonth)) {
        // --- Data Bulan Ini ---
        if (transaction.type == 0) {
          currentIncome += amount;
        } else if (transaction.type == 1) {
          currentOutcome += amount;
        }
      } else if ((date.isAfter(startOfLastMonth) ||
              date.isAtSameMomentAs(startOfLastMonth)) &&
          date.isBefore(startOfCurrentMonth)) {
        // --- Data Bulan Lalu ---
        if (transaction.type == 0) {
          lastMonthIncome += amount;
        } else if (transaction.type == 1) {
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
                return Center(
                  child: CircularProgressIndicator(
                    color: primaryColor,
                  ),
                );
              }

              if (state is TransactionFailure) {
                return Center(
                    child: Text('Terjadi Kesalahan: ${state.message}'));
              }

              List<TransactionData> transactions = [];
              if (state is TransactionLoadSuccess) {
                transactions = state.historicalTransactions;
              }

              final comparisonData = _processComparisonData(transactions);

              final categoryData =
                  _processCategoryData(transactions, selectedMainTab);
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                children: [
                  BlocBuilder<HomepageBloc, HomepageState>(
                    builder: (context, homepageState) {
                      if (homepageState is HomePageSuccess) {
                        final user = homepageState.user;
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 24.h),
                          child: HeaderSection(
                            name: user.data.username ?? "Guest",
                            money: user.data.balance.toString() ?? '0',
                            imageUrl: "assets/img_mascot-login.png",
                            isAdviceLoading: homepageState.isAdviceLoading,
                            adviceError: homepageState.adviceError,
                            advice: homepageState.advice,
                            isAdviceExist: user.data.financeProfile != null,
                            financialProfileButtonOntap: () =>
                                routes.pushNamed(RouteNames.financialProfile),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'Pemasukan vs Pengeluaran',
                      style: blackTextStyle.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.h,
                  ),

                  // CARD DATA
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: textWhiteColor,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(20.r),
                        child: AnalyticsBarChart(
                          currentIncome: comparisonData.currentIncome,
                          currentOutcome: comparisonData.currentOutcome,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 18.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'Kategori Transaksi',
                      style: blackTextStyle.copyWith(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Text(
                      'Jumlah transaksi berdasarkan kategori',
                      style: greyTextStyle.copyWith(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 12.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Container(
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
                  ),

                  SizedBox(
                    height: 12.h,
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: categoryData.isEmpty
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
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                SizedBox(height: 16.h),
                                AnalyticsDonutChart(sections: categoryData),
                                SizedBox(height: 24.h),
                                ..._buildLegend(categoryData)
                              ],
                            ),
                          ),
                  ),
                  SizedBox(height: 24.h),
                  // MENGHITUNG LAST TRANSACTIONS SEPERTI PADA HOME PAGE (Padding sudah dihandle di section-nya sendiri)
                  const LastTransactionsSection(),
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
