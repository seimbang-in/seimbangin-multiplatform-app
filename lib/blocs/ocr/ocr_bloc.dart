import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/ocr_model.dart';
import 'package:seimbangin_app/services/ocr_service.dart';

part 'ocr_event.dart';
part 'ocr_state.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  final OcrService ocrService;
  OcrBloc({required this.ocrService}) : super(OcrInitial()) {
    on<OcrButtonPressed>(_onOcrButtonPressed);
  }

  Future<void> _onOcrButtonPressed(
    OcrButtonPressed event,
    Emitter<OcrState> emit,
  ) async {
    emit(OcrLoading("Loading..."));
    try {
      final result = await ocrService.extractOcrData(event.imagePath);
      print("Image path: ${event.imagePath}"); // Dari OcrButtonPressed
      print("File exists: ${File(event.imagePath).existsSync()}");
      print("Sending image to API...");
      emit(OcrSuccess("Success", result));
    } catch (e) {
      emit(OcrFailure(e.toString()));
    }
  }
}
