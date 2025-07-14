import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/ocr/ocr_bloc.dart';
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/models/transaction_preview_model.dart';
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
        statusBarColor: statusBarPrimaryColor,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: backgroundWhiteColor,
        body: SafeArea(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              SizedBox(height: 21.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomRoundedButton(
                    onPressed: () =>
                        routes.pushReplacementNamed(RouteNames.ocr),
                    widget: Icon(
                      Icons.chevron_left,
                      size: 32.r,
                      color: textSecondaryColor,
                    ),
                    backgroundColor: backgroundWhiteColor,
                  ),
                  Image.asset(
                    'assets/ic_seimbangin-logo-logreg.png',
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Center(
                child: Text(
                  'Image Captured',
                  style: blackTextStyle.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20.sp,
                  ),
                ),
              ),
              SizedBox(
                height: 32.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width.w - 48.r,
                height: 400.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(28.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(28.r),
                  child: path.isEmpty
                      ? Center(
                          child: Text(
                            'Image not found',
                            style: blackTextStyle,
                          ),
                        )
                      : Image.file(
                          File(path),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                ),
              ),
              SizedBox(height: 48.h),
              BlocListener<OcrBloc, OcrState>(
                listener: (context, state) {
                  if (state is OcrLoading) {
                    AlertDialogWidget.showLoading(context,
                        message: 'Processing Image...');
                  } else if (state is OcrSuccess) {
                    AlertDialogWidget.dismiss(context);

                    final ocrResult = state.ocrModel;

                    final List<Item> itemsFromOcr =
                        ocrResult.data.items.map((i) {
                      return Item(
                        name: i.itemName,
                        quantity: i.quantity.toString(),
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
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: BlocBuilder<OcrBloc, OcrState>(
                  builder: (context, state) {
                    return PrimaryFilledButton(
                      title: 'Upload Image',
                      onPressed: () {
                        context.read<OcrBloc>().add(
                              OcrButtonPressed(imagePath: path),
                            );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 12.h),
              TextButton(
                onPressed: () {
                  routes.pushReplacementNamed(RouteNames.transaction);
                },
                child: Text(
                  'Add Manual',
                  style: blackTextStyle.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
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
