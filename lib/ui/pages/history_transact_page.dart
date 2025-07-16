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
        leadingWidth: 80.r,
        leading: Padding(
          padding: EdgeInsets.only(left: 24.r),
          child: CustomRoundedButton(
            onPressed: () => Navigator.of(context).pop(),
            widget:
                Icon(Icons.chevron_left, size: 32.r, color: textSecondaryColor),
            backgroundColor: backgroundWhiteColor,
          ),
        ),
        title: Text(
          'Transactions History',
          style: blackTextStyle.copyWith(
              fontSize: 18.sp, fontWeight: FontWeight.bold),
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
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.3),
                  const Center(child: Text('There is no transaction yet.')),
                ],
              ),
            );
          }

          final groupedTransactions =
              _groupTransactionsByMonth(state.historicalTransactions);
          final groupKeys = groupedTransactions.keys.toList();

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(24.r, 20.r, 24.r, 100.r),
              itemCount: groupKeys.length + (state.hasReachedMax ? 0 : 1),
              itemBuilder: (context, groupIndex) {
                if (groupIndex == groupKeys.length) {
                  return const Center(
                      child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator()));
                }

                final month = groupKeys[groupIndex];
                final transactionsInMonth = groupedTransactions[month]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: groupIndex == 0 ? 0 : 24.r, bottom: 12.r),
                      child: Text(
                        month,
                        style: blackTextStyle.copyWith(
                            fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...transactionsInMonth.map((transaction) {
                      final total = int.tryParse(transaction.amount) ?? 0;
                      final prefix = transaction.type == 0 ? '+' : '-';
                      final amountColor = transaction.type == 0
                          ? textGreenColor
                          : textWarningColor;
                      final date = DateFormat('d MMMM y', 'en_EN').format(
                          DateTime.parse(transaction.createdAt!).toLocal());

                      String categoryForIcon = 'others'; // Nilai default

                      if (transaction.items.isNotEmpty &&
                          transaction.items.first.category != null &&
                          transaction.items.first.category.isNotEmpty) {
                        categoryForIcon = transaction.items.first.category;
                      } else if (transaction.category.isNotEmpty) {
                        categoryForIcon = transaction.category;
                      }

                      final categoryUI = _getCategoryUIData(categoryForIcon);
                      final Color bgColor = categoryUI.$1;
                      final String iconPath = categoryUI.$2;

                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.r),
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
                              "$prefix${NumberFormat.currency(locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0).format(total)}",
                          amountColor: amountColor,
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
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
