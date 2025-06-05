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
            bool isLoading = transactionState is TransactionLoading &&
                !(transactionState is TransactionGetSuccess ||
                    transactionState is HistoryLoadSuccess);

            if (isLoading) {
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
                children: transactions.take(3).map((transaction) {
                  final createdAt =
                      DateTime.parse(transaction.createdAt).toLocal();
                  final timeString = DateFormat('HH:mm').format(createdAt);
                  final total = int.tryParse(transaction.amount) ?? 0;
                  final prefix = transaction.type == 0 ? '+' : '-';
                  String categoryForIcon = transaction.category;
                  if (transaction.items.isNotEmpty &&
                      transaction.items.first.category != null) {
                    categoryForIcon = transaction.items.first.category;
                  }

                  final Color amountColor =
                      transaction.type == 0 ? textGreenColor : textWarningColor;
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
                      icon: Image.asset(
                        iconPath,
                        width: 30.r,
                        height: 30.r,
                      ),
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
            } else if (transactionState is TransactionFailure) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 20.r),
                child: Center(
                  child: Text(
                    "Cannot load recent transactions.",
                    style: greyTextStyle.copyWith(fontSize: 14.sp),
                  ),
                ),
              );
            } else {
              // Termasuk TransactionInitial atau TransactionGetSuccess tapi data kosong
              return Padding(
                padding: EdgeInsets.only(bottom: 12.r),
                child: RecentTransactionCard(
                  // --- PERBAIKAN DI SINI ---
                  // Kartu "No transactions" seharusnya tidak mengarah ke detail
                  // atau jika iya, tidak mengirim state yang salah.
                  // Paling aman adalah tidak memberinya aksi onTap.
                  onTap: null, // atau onTap: () {},
                  backgroundColor: backgroundGreyColor,
                  icon: Icon(Icons.wallet_outlined,
                      size: 30.r, color: textSecondaryColor),
                  title: "No transactions yet",
                  subtitle: "Today",
                  amount: "Rp 0",
                  amountColor: textSecondaryColor,
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
