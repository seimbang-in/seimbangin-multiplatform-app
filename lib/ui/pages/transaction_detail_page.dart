import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/models/transaction_model.dart'
    as model; // Menggunakan alias
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionDetailPage extends StatelessWidget {
  final model.Data transactionData; // Menerima model.Data

  const TransactionDetailPage({super.key, required this.transactionData});

  @override
  Widget build(BuildContext context) {
    // Tentukan apakah ini outcome berdasarkan transactionData.type
    final bool isOutcome = transactionData.type == 1;
    // Konversi amount dari String ke double
    final double totalAmount = double.tryParse(transactionData.amount) ?? 0.0;
    // Parse tanggal transaksi
    final DateTime transactionDate = DateTime.parse(
        transactionData.createdAt ?? DateTime.now().toIso8601String());

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
                      'Transaction Detail', // Judul diubah
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
                          transactionData.name, // Dari transactionData
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
                            DateFormat('dd/MM/yyyy').format(
                                transactionDate), // Dari transactionData
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
                            DateFormat('HH:mm').format(
                                transactionDate), // Dari transactionData
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
                      SizedBox(height: 12.r),
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
                                    .format(
                                        totalAmount), // Dari transactionData
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
                          itemCount: transactionData
                              .items.length, // Dari transactionData
                          separatorBuilder: (context, index) => const Divider(),
                          itemBuilder: (context, index) {
                            final item = transactionData
                                .items[index]; // Dari transactionData
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                item.itemName, // Field dari model.Items
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
                                    'Qty: ${item.quantity}', // Field dari model.Items
                                    style: greyTextStyle.copyWith(
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: 'Rp ',
                                            decimalDigits: 0)
                                        .format(double.tryParse(item.price) ??
                                            0), // Field dari model.Items
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
                      // Tombol Save dan BlocListener DIHILANGKAN
                      // const SizedBox(height: 24),
                      // ... (BlocListener dan PrimaryFilledButton 'Save' dihapus)
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
