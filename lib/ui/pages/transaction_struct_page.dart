import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/models/transaction_preview_model.dart'; // Impor model baru
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/alert_dialog_widget.dart'; // Gunakan dialog terpusat
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionStructPage extends StatelessWidget {
  const TransactionStructPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Menerima TransactionPreviewData, bukan OcrModel lagi
    final previewData =
        GoRouterState.of(context).extra as TransactionPreviewData;

    final bool isOutcome = previewData.transactionType == 1;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [primaryColor, backgroundWhiteColor],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
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
                    Text('Transaction Details',
                        style: whiteTextStyle.copyWith(
                            fontWeight: FontWeight.w600, fontSize: 16)),
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
                          spreadRadius: 2)
                    ],
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text('Transaction',
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600, fontSize: 16))),
                      Center(
                          child: Text(previewData.transactionName,
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 12))),
                      const SizedBox(height: 29),
                      Row(
                        children: [
                          Text(
                              DateFormat('dd/MM/yyyy')
                                  .format(previewData.transactionDate),
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 8)),
                          const SizedBox(width: 5),
                          Text('•',
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 8)),
                          const SizedBox(width: 5),
                          Text(
                              DateFormat('HH:mm')
                                  .format(previewData.transactionDate),
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w500, fontSize: 8)),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Divider(),
                      const SizedBox(height: 12),
                      // Tampilan dinamis untuk Income/Outcome
                      Row(
                        children: [
                          Container(
                            height: 14,
                            width: 14,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isOutcome
                                  ? backgroundWarningColor
                                  : textGreenColor,
                            ),
                            child: Icon(
                              isOutcome
                                  ? Icons.arrow_upward_rounded
                                  : Icons.arrow_downward_rounded,
                              color: textWhiteColor,
                              size: 8,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Text(
                            isOutcome ? 'Outcome' : 'Income',
                            style:
                                (isOutcome ? warningTextStyle : greenTextStyle)
                                    .copyWith(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10),
                          )
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        height: 32,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(isOutcome ? 'Total Outcome' : 'Total Income',
                                  style: whiteTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12)),
                              Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0)
                                    .format(previewData.totalAmount),
                                style: whiteTextStyle.copyWith(
                                    fontWeight: FontWeight.w500, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Divider(),
                      const SizedBox(height: 18),
                      Text('Detail Transactions',
                          style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 12)),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: previewData.items.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = previewData.items[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(item.name,
                                  style: blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10)),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text('Qty: ${item.quantity}',
                                      style:
                                          greyTextStyle.copyWith(fontSize: 10)),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0)
                                        .format(
                                            double.tryParse(item.price) ?? 0),
                                    style: blackTextStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10,
                                        color: buttonColor),
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
                          if (state is TransactionLoading) {
                            AlertDialogWidget.showLoading(context,
                                message: 'Saving Transaction...');
                          } else if (state is TransactionSuccess) {
                            AlertDialogWidget.dismiss(context);
                            routes.pushNamed(RouteNames.transactionSuccess);
                          } else if (state is TransactionFailure) {
                            AlertDialogWidget.dismiss(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(state.message),
                                backgroundColor: Colors.red));
                          }
                        },
                        child: PrimaryFilledButton(
                          title: 'Save',
                          onPressed: () {
                            context.read<TransactionBloc>().add(
                                  TransactionButtonPressed(
                                    description: previewData.transactionName,
                                    name: previewData.transactionName,
                                    type: previewData.transactionType,
                                    items: previewData.items,
                                  ),
                                );
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
}
