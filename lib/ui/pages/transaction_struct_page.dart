import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/models/ocr_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/pages/transactions_page.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionStructPage extends StatelessWidget {
  const TransactionStructPage({super.key});

  @override
  Widget build(BuildContext context) {
    //     final List<Map<String, dynamic>> transactions = [
    //   {'name': 'Nasi Goreng', 'qty': 2, 'price': 25000},
    //   {'name': 'Es Teh', 'qty': 1, 'price': 5000},
    //   {'name': 'Ayam Bakar', 'qty': 1, 'price': 35000},
    //   {'name': 'Sate Ayam', 'qty': 2, 'price': 30000},
    // ];

    final OcrModel ocrModel = GoRouterState.of(context).extra as OcrModel;
    final List<Item> transactions = ocrModel.data.items.map((i) {
      return Item(
        name: i.itemName,
        quantity: i.quantity.toString(),
        price: i.price.toString(),
        category: i.category,
      );
    }).toList();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              backgroundWhiteColor,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRoundedButton(
                      onPressed: () => routes.pop(),
                      widget: const Icon(Icons.chevron_left, size: 32),
                      backgroundColor: backgroundWhiteColor,
                    ),
                    Text(
                      'Transaction Details',
                      style: whiteTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    Image.asset('assets/ic_seimbangin-logo-logreg.png'),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  decoration: BoxDecoration(
                    color: backgroundWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 16,
                        spreadRadius: 2,
                      ),
                    ],
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(32),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Transaction',
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          ocrModel.data.store,
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      Row(
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy').format(ocrModel.data.date),
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 8,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            '•',
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 8,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            TimeOfDay.now().toString(),
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Divider(),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: [
                          Container(
                            height: 14,
                            width: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: backgroundWarningColor,
                            ),
                            child: Icon(
                              Icons.arrow_upward_rounded,
                              color: textWhiteColor,
                              size: 6,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            'Outcome',
                            style: warningTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Container(
                        height: 32,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Outcome',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                              Text(
                                NumberFormat.currency(
                                  locale: 'id',
                                  symbol: 'Rp ',
                                  decimalDigits: 0,
                                ).format(ocrModel.data.total),
                                style: whiteTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      Divider(),
                      const SizedBox(
                        height: 18,
                      ),
                      Text(
                        'Detail Transactions',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: transactions.length,
                          separatorBuilder: (context, index) => Divider(),
                          itemBuilder: (context, index) {
                            final item = transactions[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item.name,
                                style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10,
                                ),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Qty: ${item.quantity}',
                                    style: greyTextStyle.copyWith(
                                      fontSize: 10,
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0,
                                    ).format(int.parse(item.price)),
                                    style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: buttonColor,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 24),
                      BlocListener<TransactionBloc, TransactionState>(
                        listener: (context, state) {
                          if (state is TransactionSuccess) {
                            _dismissLoadingDialog(context);
                            routes.pushNamed(RouteNames.transactionSuccess);
                          } else if (state is TransactionLoading) {
                            _showLoadingDialog(context);
                          } else if (state is TransactionFailure) {
                            _dismissLoadingDialog(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        child: PrimaryFilledButton(
                          title: 'Save',
                          onPressed: () {
                            context.read<TransactionBloc>().add(
                                TransactionButtonPressed(
                                    description: "Outcome",
                                    name: ocrModel.data.store,
                                    type: 1,
                                    items: transactions));
                          },
                          backgroundColor: primaryColor,
                          textColor: textWhiteColor,
                          width: double.infinity,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        // backgroundColor: backgroundWhiteColor,
        contentPadding: const EdgeInsets.all(24).r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24).r,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: primaryColor,
              strokeWidth: 4,
            ),
            SizedBox(height: 16.h),
            Text(
              'Saving Transaction...',
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dismissLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
