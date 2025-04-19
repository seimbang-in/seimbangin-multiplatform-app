part of 'ocr_bloc.dart';

@immutable
sealed class OcrEvent {}

class OcrSendImage extends OcrEvent {
  final String imagePath;

  OcrSendImage(this.imagePath);
}