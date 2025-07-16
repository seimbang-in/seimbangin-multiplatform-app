import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionStructPage extends StatefulWidget {
  const TransactionStructPage({super.key});

  @override
  State<TransactionStructPage> createState() => _TransactionStructPageState();
}

class _TransactionStructPageState extends State<TransactionStructPage> {
  bool _isProcessing = false;
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeLoadingOverlay();
    super.dispose();
  }

  void _showLoadingOverlay() {
    if (!mounted || _overlayEntry != null) return;
    _overlayEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black54,
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(24).r,
            decoration: BoxDecoration(
              color: backgroundWhiteColor,
              borderRadius: BorderRadius.circular(24).r,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(
                  color: primaryColor,
                  strokeWidth: 4,
                ),
                SizedBox(height: 16.r),
                Text(
                  'Saving Transaction...',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeLoadingOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  Widget build(BuildContext context) {
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
                padding: const EdgeInsets.symmetric(horizontal: 24).r,
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
                        fontSize: 16.sp,
                      ),
                    ),
                    Image.asset('assets/ic_seimbangin-logo-logreg.png'),
                  ],
                ),
              ),
              SizedBox(height: 40.r),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 32)
                          .r,
                  decoration: BoxDecoration(
                    color: backgroundWhiteColor,
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black12,
                          blurRadius: 16,
                          spreadRadius: 2)
                    ],
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(32)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                          child: Text(
                        'Transaction',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 16.sp,
                        ),
                      )),
                      Center(
                        child: Text(
                          previewData.transactionName,
                          style: blackTextStyle.copyWith(
                            fontWeight: FontWeight.w500,
                            fontSize: 12.sp,
                          ),
                        ),
                      ),
                      SizedBox(height: 28.r),
                      Row(
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(previewData.transactionDate),
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 5.r),
                          Text(
                            '•',
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                          SizedBox(width: 5.r),
                          Text(
                            DateFormat('HH:mm')
                                .format(previewData.transactionDate),
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8.r),
                      const Divider(),
                      SizedBox(height: 12.r),
                      Row(
                        children: [
                          Container(
                            height: 14.r,
                            width: 14.r,
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
                              size: 8.sp,
                            ),
                          ),
                          SizedBox(width: 4.r),
                          Text(
                            isOutcome ? 'Outcome' : 'Income',
                            style:
                                (isOutcome ? warningTextStyle : greenTextStyle)
                                    .copyWith(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 12.r,
                      ),
                      Container(
                        height: 32.r,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(12).r,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10).r,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isOutcome ? 'Total Outcome' : 'Total Income',
                                style: whiteTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                              Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        symbol: 'Rp ',
                                        decimalDigits: 0)
                                    .format(previewData.totalAmount),
                                style: whiteTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Divider(),
                      const SizedBox(height: 18),
                      Text(
                        'Detail Transactions',
                        style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                          shrinkWrap: true,
                          itemCount: previewData.items.length,
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = previewData.items[index];
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item.itemName,
                                style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12.sp,
                                ),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    'Qty: ${item.quantity}',
                                    style: greyTextStyle.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0)
                                        .format(
                                            double.tryParse(item.price) ?? 0),
                                    style: blackTextStyle.copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12.sp,
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
                            if (!_isProcessing) {
                              _isProcessing = true;
                              _showLoadingOverlay();
                            }
                          } else if (state is TransactionSuccess) {
                            _handleTransactionSuccess();
                          } else if (state is TransactionFailure) {
                            _handleTransactionFailure(
                                state.message); // Perbaikan: state.error
                          }
                        },
                        child: PrimaryFilledButton(
                          title: 'Save',
                          onPressed: _isProcessing
                              ? null
                              : () {
                                  context.read<TransactionBloc>().add(
                                        TransactionButtonPressed(
                                          description:
                                              previewData.transactionName,
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

  void _handleTransactionSuccess() async {
    if (!mounted) return;

    print(
        '[TransactionStructPage] TransactionSuccess received by UI. Removing overlay and navigating.');

    _removeLoadingOverlay();
    setState(() {
      _isProcessing = false;
    });

    await Future.delayed(const Duration(milliseconds: 100));

    if (mounted) {
      routes.pushReplacementNamed(RouteNames.main);
    }
  }

  void _handleTransactionFailure(String message) {
    if (!mounted) return;

    _removeLoadingOverlay();
    setState(() {
      _isProcessing = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: backgroundWarningColor,
      ),
    );
  }
}
