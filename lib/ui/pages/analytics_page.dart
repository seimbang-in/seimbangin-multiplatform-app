import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/models/donut_chart_model.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/ui/sections/header_section.dart';
import 'package:seimbangin_app/ui/sections/homepage/home_recent_transact_section.dart';
import 'package:seimbangin_app/ui/sections/analytics/income_outcome_section.dart';
import 'package:seimbangin_app/ui/sections/analytics/transaction_category_section.dart';

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

              final categoryData =
                  _processCategoryData(transactions, selectedMainTab);
              return ListView(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                children: [
                  const IncomeOutcomeSection(),
                  SizedBox(
                    height: 18.h,
                  ),
                  BlocBuilder<HomepageBloc, HomepageState>(
                    builder: (context, homepageState) {
                      if (homepageState is HomePageSuccess) {
                        final user = homepageState.user;
                        return Padding(
                          padding: EdgeInsets.only(
                              left: 20.w, right: 20.w, bottom: 24.h),
                          child: HeaderSection(
                            name: user.data.username.isEmpty
                                ? "Guest"
                                : user.data.username,
                            money: user.data.balance,
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
                  TransactionCategorySection(
                    tabController: _mainTabController,
                    tabTitles: mainTabTitles,
                    categoryData: categoryData,
                    currencyFormatter: _currencyFormatter,
                  ),
                  SizedBox(height: 24.h),
                  const LastTransactionsSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
