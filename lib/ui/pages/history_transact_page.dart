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
    // Panggil event untuk memuat data halaman pertama
    context.read<TransactionBloc>().add(FetchHistoryTransactions());
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
      context.read<TransactionBloc>().add(FetchHistoryTransactions());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Trigger saat 80% scroll tercapai untuk memuat data lebih awal
    return currentScroll >= (maxScroll * 0.8);
  }

  // Fungsi ini tetap ada untuk konsistensi UI
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
      default:
        return (buttonInternetColor, 'assets/ic_bonus.png');
    }
  }

  // Fungsi refresh untuk pull-to-refresh
  Future<void> _onRefresh() async {
    // Kita perlu event baru yang membawa parameter `isRefresh: true`
    // atau cara lain untuk mereset state di BLoC.
    // Untuk saat ini, kita panggil ulang event fetch awal.
    // NOTE: Ini akan berfungsi, tetapi untuk penyempurnaan,
    // BLoC bisa dibuat lebih canggih untuk handle event refresh secara eksplisit.
    context.read<TransactionBloc>().add(FetchHistoryTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      appBar: AppBar(
        // 1. Membuat AppBar lebih tinggi
        scrolledUnderElevation: 0,
        backgroundColor: backgroundWhiteColor,
        elevation: 0,
        automaticallyImplyLeading:
            false, // Kita akan handle tombol kembali secara manual

        // 2. Memberi padding pada tombol kembali di kiri
        leadingWidth: 80.r, // Beri ruang lebih untuk tombol
        leading: Padding(
          padding: EdgeInsets.only(left: 24.r),
          child: CustomRoundedButton(
            onPressed: () => routes.replaceNamed(RouteNames.main),
            widget: Icon(Icons.chevron_left, size: 32.r),
            backgroundColor: backgroundWhiteColor,
          ),
        ),

        // Title tetap di tengah
        title: Text(
          'History Transaction',
          style: blackTextStyle.copyWith(
              fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,

        // 3. Memberi padding pada logo di kanan
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
        // State awal saat loading pertama kali
        if (state is TransactionLoading && state is! HistoryLoadSuccess) {
          return const Center(child: CircularProgressIndicator());
        }

        // State jika gagal memuat
        if (state is TransactionFailure) {
          return Center(
              child: Text('Failed to fetch transactions: ${state.message}'));
        }

        // State sukses utama untuk menampilkan list
        if (state is HistoryLoadSuccess) {
          if (state.transactions.isEmpty) {
            return const Center(child: Text('No transactions found.'));
          }

          return RefreshIndicator(
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 24.r, vertical: 20.r),
              itemCount: state.hasReachedMax
                  ? state.transactions.length
                  : state.transactions.length + 1,
              itemBuilder: (BuildContext context, int index) {
                // Item terakhir adalah loading indicator (jika ada data lagi)
                if (index >= state.transactions.length) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                // Tampilkan kartu transaksi
                final transaction = state.transactions[index];
                String categoryForIcon = transaction.category ?? 'others';
                if (transaction.items != null &&
                    transaction.items!.isNotEmpty) {
                  categoryForIcon =
                      transaction.items!.first.category ?? 'others';
                }

                final categoryUI = _getCategoryUIData(categoryForIcon);
                final Color bgColor = categoryUI.$1;
                final String iconPath = categoryUI.$2;

                final total = int.tryParse(transaction.amount ?? '0') ?? 0;
                final prefix = transaction.type == 0 ? '+' : '-';
                final amountColor =
                    transaction.type == 0 ? textGreenColor : textWarningColor;
                final date = DateFormat('d MMMM yyyy, HH:mm')
                    .format(DateTime.parse(transaction.createdAt!));

                return Padding(
                  padding: EdgeInsets.only(bottom: 16.r),
                  child: RecentTransactionCard(
                    onTap: () {},
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
