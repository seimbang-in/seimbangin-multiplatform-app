import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';

class HomeRecentTransactionsSection extends StatelessWidget {
  final Color Function(String) getCategoryColorCallback;

  const HomeRecentTransactionsSection({
    super.key,
    required this.getCategoryColorCallback,
  });

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

                  return RecentTransactionCard(
                    onTap: () {},
                    backgroundIcon: getCategoryColorCallback(categoryForIcon),
                    title: transaction.name,
                    subtitle: "$timeString WIB",
                    amount: "$prefix${NumberFormat.currency(
                      locale: 'id',
                      symbol: 'Rp ',
                      decimalDigits: 0,
                    ).format(total)}",
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
                    backgroundIcon: backgroundGreenColor,
                    title: "Belum ada transaksi",
                    subtitle: "Hari ini",
                    amount: "Rp 0",
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
