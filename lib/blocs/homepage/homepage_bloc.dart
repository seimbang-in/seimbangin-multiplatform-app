// lib/blocs/homepage/homepage_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/advice_model.dart';
import 'package:seimbangin_app/models/user/user_model.dart';
import 'package:seimbangin_app/services/user_service.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final UserService userService;

  HomepageBloc({required this.userService}) : super(HomepageInitial()) {
    on<HomepageStarted>(_handleHomepageStarted);
    on<_FetchAiAdvice>(_handleFetchAiAdvice);
    on<UpdateFinancialProfile>(_updateFinancialProfile);
  }

  Future<void> _handleHomepageStarted(
    HomepageStarted event,
    Emitter<HomepageState> emit,
  ) async {
    try {
      emit(HomePageLoading('Memuat data profil...'));

      final userData = await userService.getUserProfile();

      emit(HomePageSuccess(
        message: 'Profil berhasil dimuat',
        user: userData,
        isAdviceLoading: true,
      ));

      add(_FetchAiAdvice());
    } catch (e) {
      emit(HomePageFailure('Gagal memuat data utama: ${e.toString()}'));
    }
  }

  Future<void> _handleFetchAiAdvice(
    _FetchAiAdvice event,
    Emitter<HomepageState> emit,
  ) async {
    final currentState = state;
    if (currentState is! HomePageSuccess) return;

    try {
      final adviceData = await userService.getUserAdvice();

      emit(currentState.copyWith(
        advice: adviceData,
        isAdviceLoading: false, // Advice loading is complete.
      ));
    } catch (e) {
      emit(currentState.copyWith(
        isAdviceLoading: false, // Advice loading is complete (but failed).
        adviceError: 'Gagal memuat saran AI',
      ));
    }
  }

  Future<void> _updateFinancialProfile(
      UpdateFinancialProfile event, Emitter<HomepageState> emit) async {
    emit(FinancialProfileLoading("Memperbarui data..."));
    try {
      await userService.updateUserProfile(event.currentSavings, event.debt,
          event.financialGoals, event.riskManagement);

      emit(FinancialProfileSuccess(message: "Data berhasil diperbarui"));

      add(HomepageStarted());
    } catch (e) {
      emit(FinancialProfileFailure("Gagal memperbarui data: ${e.toString()}"));
    }
  }
}
