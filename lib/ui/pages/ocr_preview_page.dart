import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            const SizedBox(height: 21),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRoundedButton(
                  onPressed: () => routes.pop(),
                  widget: const Icon(Icons.chevron_left, size: 32),
                  backgroundColor: backgroundWhiteColor,
                ),
                Image.asset('assets/ic_seimbangin-logo-logreg.png'),
              ],
            ),
            const SizedBox(height: 68),
            Center(
              child: Text(
                'Image Uploaded',
                style: blackTextStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ),
            const SizedBox(height: 40),
            Container(
              width: MediaQuery.of(context).size.width - 48,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(24),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
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
            const SizedBox(height: 62),
            BlocListener<OcrBloc, OcrState>(
              listener: (context, state) {
                if (state is OcrLoading) {
                  // Gunakan AlertDialogWidget yang sudah ada
                  AlertDialogWidget.showLoading(context,
                      message: 'Processing Image...');
                } else if (state is OcrSuccess) {
                  AlertDialogWidget.dismiss(context);

                  // --- LANGKAH 4: KONVERSI MODEL DITERAPKAN DI SINI ---
                  final ocrResult = state.ocrModel;

                  // 1. Konversi List<OcrItem> menjadi List<Item>
                  final List<Item> itemsFromOcr = ocrResult.data.items.map((i) {
                    return Item(
                      name: i.itemName,
                      quantity: i.quantity.toString(),
                      price: i.price.toString(),
                      category: i.category,
                    );
                  }).toList();

                  // 2. Buat objek TransactionPreviewData
                  final previewData = TransactionPreviewData(
                    transactionName: ocrResult.data.store,
                    transactionType: 1, // OCR selalu dianggap Outcome (tipe 1)
                    totalAmount: ocrResult.data.total.toDouble(),
                    transactionDate: ocrResult.data.date,
                    items: itemsFromOcr,
                  );

                  // 3. Kirim objek baru ini ke TransactionStructPage
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
                  // Tombol tidak perlu tahu tentang state, hanya mengirim event
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
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {
                // Navigasi ke halaman input manual jika diperlukan
                routes.pushNamed(RouteNames.transaction);
              },
              child: Text(
                'Add Manual',
                style: blackTextStyle.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
