part of 'ocr_bloc.dart';

@immutable
sealed class OcrEvent {}

class OcrButtonPressed extends OcrEvent {
  final String imagePath;
  OcrButtonPressed({required this.imagePath});
}
