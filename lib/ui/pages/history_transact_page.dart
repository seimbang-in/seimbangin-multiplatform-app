import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';

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

    if (context.read<TransactionBloc>().state is! HistoryLoadSuccess) {
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
      if (currentState is HistoryLoadSuccess && !currentState.hasReachedMax) {
        context.read<TransactionBloc>().add(FetchHistoryTransactions());
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

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
        return (buttonGiftColor, 'assets/ic_parents.png');
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

  Future<void> _onRefresh() async {
    context.read<TransactionBloc>().add(FetchHistoryTransactions());
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
            onPressed: () => routes.replaceNamed(RouteNames.main),
            widget:
                Icon(Icons.chevron_left, size: 32.r, color: textSecondaryColor),
            backgroundColor: backgroundWhiteColor,
          ),
        ),
        title: Text(
          'History Transaction',
          style: blackTextStyle.copyWith(
              fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 24.r),
            child: Image.asset('assets/ic_seimbangin-logo-logreg.png'),
          ),
        ],
      ),
      body: _buildTransactionList(),
    );
  }

  Widget _buildTransactionList() {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        bool isLoadingFirstTime =
            state is TransactionLoading && state is! HistoryLoadSuccess;

        if (isLoadingFirstTime) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is TransactionFailure) {
          return Center(
              child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text('Failed to fetch transactions: ${state.message}',
                textAlign: TextAlign.center),
          ));
        }

        if (state is HistoryLoadSuccess) {
          if (state.transactions.isEmpty) {
            return Center(
              child: RefreshIndicator(
                // Izinkan refresh meskipun kosong
                onRefresh: _onRefresh,
                child: ListView(
                  children: [
                    SizedBox(
                        height: MediaQuery.of(context).size.height *
                            0.3), // Pusatkan teks
                    const Center(child: Text('No transactions found.')),
                  ],
                ),
              ),
            );
          }

          final displayedTransactions = List.of(state.transactions);
          displayedTransactions.sort((a, b) => DateTime.parse(b.createdAt!)
              .compareTo(DateTime.parse(a.createdAt!)));

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.fromLTRB(24.r, 20.r, 24.r, 20.r),
              itemCount: state.hasReachedMax
                  ? displayedTransactions.length
                  : displayedTransactions.length + 1,
              itemBuilder: (BuildContext context, int index) {
                if (index >= displayedTransactions.length) {
                  // Ini adalah item terakhir untuk loading indicator
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                final transaction = displayedTransactions[
                    index]; // Gunakan data yang sudah diurutkan
                String categoryForIcon = transaction.category ?? 'others';
                if (transaction.items != null &&
                    transaction.items!.isNotEmpty &&
                    transaction.items!.first.category != null) {
                  categoryForIcon = transaction.items!.first.category!;
                }

                final categoryUI = _getCategoryUIData(categoryForIcon);
                final Color bgColor = categoryUI.$1;
                final String iconPath = categoryUI.$2;

                final total = int.tryParse(transaction.amount ?? '0') ?? 0;
                final prefix = transaction.type == 0 ? '+' : '-';
                final amountColor =
                    transaction.type == 0 ? textGreenColor : textWarningColor;
                final date = DateFormat(
                        'd MMMM yyyy, HH:mm') // Format tanggal lebih lengkap
                    .format(DateTime.parse(transaction.createdAt!));

                return Padding(
                  padding: EdgeInsets.only(bottom: 16.r),
                  child: RecentTransactionCard(
                    // --- PERUBAHAN DI SINI ---
                    onTap: () {
                      // Navigasi ke halaman detail dengan mengirim objek 'transaction'
                      routes.pushNamed(RouteNames.transactionDetail,
                          extra: transaction);
                    },
                    // --- AKHIR PERUBAHAN ---
                    backgroundColor: bgColor,
                    icon: Image.asset(iconPath, width: 30.r, height: 30.r),
                    title: transaction.name!,
                    subtitle: date,
                    amount:
                        "$prefix${NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(total)}",
                    amountColor: amountColor,
                  ),
                );
              },
            ),
          );
        }
        // State default jika belum ada apa-apa (misal, TransactionInitial)
        return const Center(child: CircularProgressIndicator());
      },
    );
  }
}
