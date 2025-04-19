import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seimbangin_app/blocs/ocr/ocr_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/services/ocr_service.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
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
        body: BlocConsumer(
          listener: (context, state) {
            if (state is OcrSuccess) {
              // Navigasi ke hasil OCR atau tampilkan SnackBar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('OCR berhasil!')),
              );
              routes.pushNamed(RouteNames.transactionStruct,
                  extra: state.ocrItem);
            } else if (state is OcrError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return SafeArea(
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
                    width: MediaQuery.of(context).size.width -
                        48, // Sesuaikan dengan padding horizontal
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
                  PrimaryFilledButton(title: 'Upload Image'),
                  const SizedBox(height: 12),
                  TextButton(
                    onPressed: () {
                      context.read<OcrBloc>().add(OcrSendImage(path));
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
            );
          },
        ));
  }
}
