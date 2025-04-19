import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/ocr_item_models.dart';
import 'package:seimbangin_app/services/ocr_service.dart';

part 'ocr_event.dart';
part 'ocr_state.dart';

class OcrBloc extends Bloc<OcrEvent, OcrState> {
  final OcrService ocrService = OcrService();
  OcrBloc() : super(OcrInitial()) {
    on<OcrEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<OcrSendImage>(_sendImage);
  }

  Future<void> _sendImage(OcrSendImage event, Emitter<OcrState> emit) async {
    emit(OcrLoading("Mengirim gambar ke OCR..."));
    try {
      final file = File(event.imagePath);
      final result = await ocrService.getOcrItem(file);
      emit(OcrSuccess(result));
    } catch (e) {
      emit(OcrError("Terjadi kesalahan: $e"));
    }
  }
}
