part of 'ocr_bloc.dart';

@immutable
sealed class OcrState {}

final class OcrInitial extends OcrState {}

class OcrSuccess extends OcrState {
  final OcrItem ocrItem;

  OcrSuccess(this.ocrItem);
}

class OcrLoading extends OcrState {
  final String message;
  OcrLoading(this.message);
}

class OcrError extends OcrState {
  final String message;

  OcrError(this.message);
}
