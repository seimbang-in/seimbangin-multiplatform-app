import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/models/transaction_model.dart'
    as model; // Gunakan alias untuk menghindari konflik nama
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
  int _selectedIndex = 0;
  final List<String> _tabs = ['All', 'Week', '1 Month', '6 Month'];

  @override
  void initState() {
    super.initState();
    // Sama seperti di HomePage, kita perlu memastikan data transaksi tersedia.
    // Kita panggil event untuk mengambil semua data histori (misal: limit 200).
    context.read<TransactionBloc>().add(GetRecentTransactionsEvent(limit: 200));
  }

  // Logika dari HomeRecentTransactionsSection kita pindahkan ke sini
  // untuk menentukan warna dan ikon secara dinamis.
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

  // Fungsi filter berdasarkan tab tetap kita pertahankan.
  List<model.Data> _filterTransactions(List<model.Data> transactions) {
    final now = DateTime.now();
    switch (_selectedIndex) {
      case 1: // Week
        final weekAgo = now.subtract(const Duration(days: 7));
        return transactions
            .where((t) => DateTime.parse(t.createdAt!).isAfter(weekAgo))
            .toList();
      case 2: // 1 Month
        final monthAgo = now.subtract(const Duration(days: 30));
        return transactions
            .where((t) => DateTime.parse(t.createdAt!).isAfter(monthAgo))
            .toList();
      case 3: // 6 Month
        final sixMonthsAgo = now.subtract(const Duration(days: 180));
        return transactions
            .where((t) => DateTime.parse(t.createdAt!).isAfter(sixMonthsAgo))
            .toList();
      case 0: // All
      default:
        return transactions;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          children: [
            SizedBox(height: 21.r),
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRoundedButton(
                  onPressed: () => routes.replaceNamed(RouteNames.main),
                  widget: Icon(Icons.chevron_left, size: 32.r),
                  backgroundColor: backgroundWhiteColor,
                ),
                Text(
                  'History Transaction',
                  style: blackTextStyle.copyWith(
                      fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
                Image.asset('assets/ic_seimbangin-logo-logreg.png'),
              ],
            ),
            SizedBox(height: 32.r),
            // Tab Bar
            _buildCustomTabBar(),
            SizedBox(height: 20.r),
            // Daftar Transaksi
            _buildTransactionList(),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundGreyColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                margin: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: isSelected ? buttonColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.r),
                child: Center(
                  child: Text(
                    _tabs[index],
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? textWhiteColor : textSecondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildTransactionList() {
    // Gunakan BlocBuilder untuk membangun UI berdasarkan state dari TransactionBloc
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        if (state is TransactionGetSuccess) {
          // Urutkan semua transaksi dari yang terbaru
          final sortedTransactions = List.of(state.transaction.data);
          sortedTransactions.sort((a, b) => DateTime.parse(b.createdAt!)
              .compareTo(DateTime.parse(a.createdAt!)));

          // Terapkan filter berdasarkan tab yang aktif
          final filteredTransactions = _filterTransactions(sortedTransactions);

          if (filteredTransactions.isEmpty) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 50.r),
                child: Text('No transactions for this period.',
                    style: greyTextStyle.copyWith(fontSize: 14.sp)),
              ),
            );
          }

          // Tampilkan daftar transaksi yang sudah difilter
          return Column(
            children: filteredTransactions.map((transaction) {
              // --- LOGIKA UI DARI HOMERECENTTRANSACTIONSECTION DITERAPKAN DI SINI ---
              String categoryForIcon = transaction.category;
              if (transaction.items.isNotEmpty) {
                categoryForIcon = transaction.items.first.category;
              }

              final categoryUI = _getCategoryUIData(categoryForIcon);
              final Color bgColor = categoryUI.$1;
              final String iconPath = categoryUI.$2;

              final total = int.tryParse(transaction.amount) ?? 0;
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
                  title: transaction.name,
                  subtitle: date,
                  amount: "$prefix${NumberFormat.currency(
                    locale: 'id',
                    symbol: 'Rp ',
                    decimalDigits: 0,
                  ).format(total)}",
                  amountColor: amountColor,
                ),
              );
            }).toList(),
          );
        }

        if (state is TransactionFailure) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text(state.message,
                  style: warningTextStyle, textAlign: TextAlign.center),
            ),
          );
        }

        // Default state (loading atau initial)
        return const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 50.0),
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
