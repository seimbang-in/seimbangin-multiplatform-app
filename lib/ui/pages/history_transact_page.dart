import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';
import 'package:collection/collection.dart';

class HistoryTransactPage extends StatefulWidget {
  const HistoryTransactPage({super.key});

  @override
  State<HistoryTransactPage> createState() => _HistoryTransactPageState();
}

class _HistoryTransactPageState extends State<HistoryTransactPage> {
  final _scrollController = ScrollController();
  String? _selectedMonth;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);

    final currentState = context.read<TransactionBloc>().state;
    if (currentState is! TransactionLoadSuccess ||
        currentState.historicalTransactions.isEmpty) {
      context.read<TransactionBloc>().add(FetchHistoryTransactions());
    }
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      final currentState = context.read<TransactionBloc>().state;
      if (currentState is TransactionLoadSuccess &&
          !currentState.hasReachedMax) {
        context.read<TransactionBloc>().add(FetchHistoryTransactions());
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  Future<void> _onRefresh() async {
    context
        .read<TransactionBloc>()
        .add(FetchHistoryTransactions(isRefresh: true));
  }

  Map<String, List<TransactionData>> _groupTransactionsByMonth(
      List<TransactionData> transactions) {
    final now = DateTime.now();
    final monthYearFormat = DateFormat('MMMM yyyy', 'en_EN');

    return groupBy(transactions, (TransactionData transaction) {
      final date = DateTime.parse(transaction.createdAt!).toLocal();
      if (date.year == now.year && date.month == now.month) {
        return 'This Month';
      }
      return monthYearFormat.format(date);
    });
  }

  /// Helper untuk mendapatkan warna dan ikon berdasarkan kategori transaksi.
  (Color, String) _getCategoryUIData(String category) {
    switch (category.toLowerCase()) {
      case 'salary':
        return (buttonSalaryColor, 'assets/ic_salary.png');
      case 'freelance':
        return (buttonFreelanceColor, 'assets/ic_freelance.png');
      case 'bonus':
        return (buttonBonusColor, 'assets/ic_bonus.png');
      case 'gift':
        return (buttonBonusColor, 'assets/ic_gift.png');
      case 'parent':
        return (buttonParentColor, 'assets/ic_parents.png');
      case 'food':
        return (buttonFoodColor, 'assets/ic_food.png');
      case 'transportation':
      case 'transport':
        return (buttonTransportationColor, 'assets/ic_transportation.png');
      case 'shopping':
        return (buttonShoppingColor, 'assets/ic_shopping.png');
      case 'health':
        return (buttonHealthColor, 'assets/ic_health.png');
      case 'education':
        return (buttonEducationColor, 'assets/ic_education.png');
      case 'housing':
        return (buttonHousingColor, 'assets/ic_housing.png');
      case 'internet':
        return (buttonInternetColor, 'assets/ic_internet.png');
      default:
        return (buttonInternetColor, 'assets/ic_bonus.png');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: backgroundWhiteColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: 70.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w, top: 8.h, bottom: 8.h),
          child: CustomRoundedButton(
            onPressed: () => Navigator.of(context).pop(),
            widget:
                Icon(Icons.chevron_left, size: 28.r, color: textSecondaryColor),
            backgroundColor: backgroundWhiteColor,
          ),
        ),
        title: Text(
          'Histori Transaksi',
          style: blackTextStyle.copyWith(
              fontSize: 18.sp, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: _buildTransactionList(),
    );
  }

  Widget _buildTransactionList() {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionLoadSuccess) {
          if (state.historicalTransactions.isEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long,
                            size: 60.r, color: textSecondaryColor),
                        SizedBox(height: 16.h),
                        Text(
                          'Belum ada transaksi.',
                          style: greyTextStyle.copyWith(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          final groupedTransactions =
              _groupTransactionsByMonth(state.historicalTransactions);
          final groupKeys = groupedTransactions.keys.toList();

          if (groupKeys.isEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.receipt_long,
                            size: 60.r, color: textSecondaryColor),
                        SizedBox(height: 16.h),
                        Text(
                          'Belum ada transaksi.',
                          style: greyTextStyle.copyWith(fontSize: 16.sp),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }

          final String currentSelectedMonth = _selectedMonth ??
              (groupKeys.contains('This Month')
                  ? 'This Month'
                  : groupKeys.first);

          // Pastikan jika _selectedMonth tidak ada di groupKeys (misal krn refresh), kita ambil yang pertama
          final String validSelectedMonth =
              groupKeys.contains(currentSelectedMonth)
                  ? currentSelectedMonth
                  : groupKeys.first;

          final transactionsInMonth =
              groupedTransactions[validSelectedMonth] ?? [];

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Periode',
                        style: blackTextStyle.copyWith(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: backgroundGreyColor,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: DropdownButton<String>(
                          value: validSelectedMonth,
                          underline: const SizedBox(),
                          icon: Padding(
                            padding: EdgeInsets.only(left: 8.w),
                            child: Icon(Icons.keyboard_arrow_down,
                                color: textSecondaryColor),
                          ),
                          items: groupKeys.map((String month) {
                            return DropdownMenuItem<String>(
                              value: month,
                              child: Text(
                                month,
                                style: blackTextStyle.copyWith(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedMonth = newValue;
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(20.w, 8.h, 20.w, 100.h),
                    itemCount: transactionsInMonth.length +
                        (state.hasReachedMax ? 0 : 1),
                    itemBuilder: (context, index) {
                      if (index == transactionsInMonth.length) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      final transaction = transactionsInMonth[index];
                      final total = int.tryParse(transaction.amount) ?? 0;
                      final prefix = transaction.type == 0 ? '+' : '-';
                      final amountColor = transaction.type == 0
                          ? textGreenColor
                          : textWarningColor;
                      final date = DateFormat('d MMMM y', 'en_EN').format(
                          DateTime.parse(transaction.createdAt!).toLocal());

                      String categoryForIcon = 'others';

                      if (transaction.items.isNotEmpty &&
                          transaction.items.first.category.isNotEmpty) {
                        categoryForIcon = transaction.items.first.category;
                      } else if (transaction.category.isNotEmpty) {
                        categoryForIcon = transaction.category;
                      }

                      final categoryUI = _getCategoryUIData(categoryForIcon);
                      final Color bgColor = categoryUI.$1;
                      final String iconPath = categoryUI.$2;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.r),
                        child: RecentTransactionCard(
                          onTap: () => routes.pushNamed(
                              RouteNames.transactionDetail,
                              extra: transaction),
                          backgroundColor: bgColor,
                          icon:
                              Image.asset(iconPath, width: 30.r, height: 30.r),
                          title: transaction.name,
                          subtitle: date,
                          amount:
                              "$prefix${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(total)}",
                          amountColor: amountColor,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }

        if (state is TransactionFailure) {
          return Center(child: Text(state.message));
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
