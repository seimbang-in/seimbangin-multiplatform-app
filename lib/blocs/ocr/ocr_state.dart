part of 'ocr_bloc.dart';

@immutable
sealed class OcrState {}

final class OcrInitial extends OcrState {}

class OcrLoading extends OcrState {
  final String message;
  OcrLoading(this.message);
}

class OcrSuccess extends OcrState {
  final String message;
  final OcrModel ocrModel;
  OcrSuccess(this.message, this.ocrModel);
}

class OcrFailure extends OcrState {
  final String error;
  OcrFailure(this.error);
}
