import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/ocr/ocr_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
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
            // PrimaryFilledButton(title: 'Upload Image'),
            BlocListener<OcrBloc, OcrState>(
              listener: (context, state) {
                if (state is OcrSuccess) {
                  _dismissLoadingDialog(context);
                  routes.pushNamed(RouteNames.transactionStruct,
                      extra: state.ocrModel);
                } else if (state is OcrLoading) {
                  _showLoadingDialog(context);
                } else if (state is OcrFailure) {
                  _dismissLoadingDialog(context);
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
            const SizedBox(height: 12),
            TextButton(
              onPressed: () {},
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
              'Processing Image...',
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
