import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';

class HomeRecentTransactionsSection extends StatelessWidget {
  const HomeRecentTransactionsSection({super.key});

  // --- HELPER FUNCTION BARU ---
  // Fungsi ini mengambil nama kategori dan mengembalikan data UI-nya (warna dan path ikon).
  // Menggunakan Record `(Color, String)` untuk mengembalikan dua nilai sekaligus.
  (Color, String) _getCategoryUIData(String category) {
    switch (category.toLowerCase()) {
      // Income Categories
      case 'salary':
        return (buttonSalaryColor, 'assets/ic_salary.png');
      case 'freelance':
        return (buttonFreelanceColor, 'assets/ic_freelance.png');
      case 'bonus':
        return (buttonBonusColor, 'assets/ic_bonus.png');
      case 'gift':
        return (buttonBonusColor, 'assets/ic_gift.png');

      // Outcome Categories
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

      // Default jika kategori tidak ditemukan
      default:
        return (
          buttonInternetColor,
          'assets/ic_bonus.png'
        ); // Pastikan Anda punya ikon default
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Recent Transactions",
          style: blackTextStyle.copyWith(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 14.r),
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, transactionState) {
            if (transactionState is TransactionLoading) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.r),
                  child: const CircularProgressIndicator(),
                ),
              );
            } else if (transactionState is TransactionGetSuccess &&
                transactionState.transaction.data.isNotEmpty) {
              final transactions = List.from(transactionState.transaction.data);
              transactions.sort((a, b) => DateTime.parse(b.createdAt)
                  .compareTo(DateTime.parse(a.createdAt)));

              return Column(
                children: transactions.take(5).map((transaction) {
                  final createdAt = DateTime.parse(transaction.createdAt);
                  final timeString = DateFormat('HH:mm').format(createdAt);
                  final total = int.tryParse(transaction.amount) ?? 0;
                  final prefix = transaction.type == 0 ? '+' : '-';
                  String categoryForIcon = transaction.category;
                  if (transaction.items.isNotEmpty) {
                    categoryForIcon = transaction.items.first.category;
                  }

                  final Color amountColor =
                      transaction.type == 0 ? textGreenColor : textWarningColor;

                  // --- LOGIKA DINAMIS DITERAPKAN DI SINI ---
                  // 1. Panggil helper function untuk mendapatkan data UI
                  final categoryUI = _getCategoryUIData(categoryForIcon);
                  final Color bgColor =
                      categoryUI.$1; // Ambil warna dari record
                  final String iconPath =
                      categoryUI.$2; // Ambil path ikon dari record

                  return RecentTransactionCard(
                    onTap: () {},
                    // 2. Teruskan data dinamis ke card
                    backgroundColor: bgColor,
                    icon: Image.asset(
                      iconPath,
                      width: 30.r,
                      height: 30.r,
                      // Anda bisa memberi warna pada aset gambar jika itu adalah ikon monokrom
                      // color: Colors.white,
                    ),
                    title: transaction.name,
                    subtitle: "$timeString WIB",
                    amount: "$prefix${NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(total)}",
                    amountColor: amountColor,
                  );
                }).toList(),
              );
            } else if (transactionState is TransactionFailure) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.r),
                child: Center(
                  child: Text(
                    "Tidak dapat memuat transaksi terbaru.",
                    style: greyTextStyle.copyWith(fontSize: 14.sp),
                  ),
                ),
              );
            } else {
              return Column(
                children: [
                  RecentTransactionCard(
                    onTap: () {},
                    backgroundColor: backgroundGreyColor,
                    icon: Icon(Icons.wallet_outlined,
                        size: 30.r, color: textSecondaryColor),
                    title: "Belum ada transaksi",
                    subtitle: "Hari ini",
                    amount: "Rp 0",
                    amountColor: textSecondaryColor,
                  ),
                ],
              );
            }
          },
        ),
        Center(
          child: TextButton(
            onPressed: () => routes.pushNamed(RouteNames.historyTransact),
            child: Text(
              "See More",
              style: TextStyle(
                color: textBlueColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
