import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/ocr/ocr_bloc.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/alert_dialog_widget.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class OcrPreviewPage extends StatelessWidget {
  final String path;
  const OcrPreviewPage({
    super.key,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: context.color.statusBarPrimaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: context.color.backgroundWhiteColor,
        appBar: AppBar(
          backgroundColor: context.color.backgroundWhiteColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              size: 32.r,
              color: context.color.textPrimaryColor,
            ),
            onPressed: () => routes.pushReplacementNamed(RouteNames.ocr),
          ),
          centerTitle: true,
          title: Text(
            'Pratinjau Struk',
            style: context.text.blackTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  decoration: BoxDecoration(
                    color: context.color.backgroundGreySecondaryColor,
                    borderRadius: BorderRadius.circular(28.r),
                    border: Border.all(
                      color: context.color.backgroundGreyColor,
                      width: 1.5,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28.r),
                    child: path.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 48.r,
                                  color: context.color.textSecondaryColor,
                                ),
                                SizedBox(height: 12.h),
                                Text(
                                  'Gambar tidak ditemukan',
                                  style: context.text.greyTextStyle.copyWith(
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : InteractiveViewer(
                            panEnabled: true,
                            boundaryMargin: const EdgeInsets.all(20),
                            minScale: 0.5,
                            maxScale: 4.0,
                            child: Image.file(
                              File(path),
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                  ),
                ),
              ),
              BlocListener<OcrBloc, OcrState>(
                listener: (context, state) {
                  if (state is OcrLoading) {
                    AlertDialogWidget.showLoading(context,
                        message: 'Memproses Struk...');
                  } else if (state is OcrSuccess) {
                    AlertDialogWidget.dismiss(context);

                    final ocrResult = state.ocrModel;

                    final List<TransactionItem> itemsFromOcr =
                        ocrResult.data.items.map((i) {
                      return TransactionItem(
                        itemName: i.itemName,
                        quantity: i.quantity,
                        price: i.price.toString(),
                        category: i.category,
                      );
                    }).toList();

                    final previewData = TransactionPreviewData(
                      transactionName: ocrResult.data.store,
                      transactionType: 1, // OUTCOME
                      totalAmount: ocrResult.data.total.toDouble(),
                      transactionDate: ocrResult.data.date,
                      items: itemsFromOcr,
                    );

                    routes.pushNamed(RouteNames.transactionStruct,
                        extra: previewData);
                  } else if (state is OcrFailure) {
                    AlertDialogWidget.dismiss(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        backgroundColor: context.color.backgroundWarningColor,
                      ),
                    );
                  }
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(24.w, 8.h, 24.w, 24.h),
                  decoration: BoxDecoration(
                    color: context.color.backgroundWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.02),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocBuilder<OcrBloc, OcrState>(
                        builder: (context, state) {
                          return PrimaryFilledButton(
                            title: 'Proses Struk',
                            onPressed: () {
                              context.read<OcrBloc>().add(
                                    OcrButtonPressed(imagePath: path),
                                  );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 12.h),
                      TextButton(
                        onPressed: () {
                          routes.pushReplacementNamed(RouteNames.transaction);
                        },
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 48.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          'Isi Manual',
                          style: context.text.greyTextStyle.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
