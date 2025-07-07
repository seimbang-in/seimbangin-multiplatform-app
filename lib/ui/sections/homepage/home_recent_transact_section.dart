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
        // Fallback untuk kategori 'others' atau yang tidak dikenal
        return (buttonInternetColor, 'assets/ic_bonus.png');
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
            // Kondisi 1: State sukses dan data berhasil dimuat.
            if (transactionState is TransactionLoadSuccess) {
              // Jika daftar transaksi terkini kosong, tampilkan kartu informasi.
              if (transactionState.recentTransactions.isEmpty) {
                return RecentTransactionCard(
                  onTap: null, // Tidak ada aksi saat diklik
                  backgroundColor: backgroundGreyColor,
                  icon: Icon(Icons.wallet_outlined,
                      size: 30.r, color: textSecondaryColor),
                  title: "No transactions yet",
                  subtitle: "Your recent transactions will appear here",
                  amount: "",
                  amountColor: textSecondaryColor,
                );
              }

              // Jika ada data, tampilkan dalam bentuk list.
              return Column(
                children:
                    transactionState.recentTransactions.map((transaction) {
                  final createdAt =
                      DateTime.parse(transaction.createdAt!).toLocal();
                  final timeString = DateFormat('d MMMM y').format(createdAt);
                  final total = int.tryParse(transaction.amount) ?? 0;
                  final prefix = transaction.type == 0 ? '+' : '-';
                  final Color amountColor =
                      transaction.type == 0 ? textGreenColor : textWarningColor;

                  // Logika yang sudah diperbaiki untuk menentukan kategori
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
                    padding: EdgeInsets.only(bottom: 12.r),
                    child: RecentTransactionCard(
                      onTap: () {
                        routes.pushNamed(RouteNames.transactionDetail,
                            extra: transaction);
                      },
                      backgroundColor: bgColor,
                      icon: Image.asset(iconPath, width: 30.r, height: 30.r),
                      title: transaction.name,
                      subtitle: timeString,
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
            // Kondisi 2: Gagal memuat data.
            else if (transactionState is TransactionFailure) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.r),
                  child: Text(
                    "Cannot load recent transactions.",
                    style: greyTextStyle.copyWith(fontSize: 14.sp),
                  ),
                ),
              );
            }
            // Kondisi 3: Sedang memuat atau state awal.
            else {
              return Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.r),
                  child: const CircularProgressIndicator(),
                ),
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
