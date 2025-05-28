import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/advice_model.dart';
import 'package:seimbangin_app/models/user_model.dart';
import 'package:seimbangin_app/services/user_service.dart';

part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final UserService userService;

  HomepageBloc({required this.userService}) : super(HomepageInitial()) {
    on<HomepageStarted>(_handleHomepageStarted);
    on<UpdateFinancialProfile>(_updateFinancialProfile);
  }

  Future<void> _handleHomepageStarted(
    HomepageStarted event,
    Emitter<HomepageState> emit,
  ) async {
    try {
      // Selalu emit loading setiap kali event ini dipanggil
      emit(HomePageLoading('Memuat data...'));
      print('[HomepageBloc] Memulai pemanggilan service...');

      // --- LOGGING POINT 1 ---
      print('[HomepageBloc] Memanggil userService.getUserProfile()...');
      final userData = await userService.getUserProfile();
      print('[HomepageBloc] Selesai memanggil userService.getUserProfile().');
      // ------------------------

      // --- LOGGING POINT 2 ---
      print('[HomepageBloc] Memanggil userService.getUserAdvice()...');
      final adviceData = await userService.getUserAdvice();
      print('[HomepageBloc] Selesai memanggil userService.getUserAdvice().');
      // ------------------------

      emit(HomePageSuccess(
        message: 'Data berhasil dimuat',
        user: userData,
        advice: adviceData,
      ));
      print('[HomepageBloc] Berhasil emit HomePageSuccess.');
    } catch (e) {
      print('[HomepageBloc] Terjadi error saat memuat data: $e');
      emit(HomePageFailure('Gagal memuat data: ${e.toString()}'));
    }
  }

  Future<void> _updateFinancialProfile(
      UpdateFinancialProfile event, Emitter<HomepageState> emit) async {
    emit(financialProfileLoading("Memperbarui data..."));
    try {
      print(
          'payload : current savings: ${event.currentSavings}, debt: ${event.debt}, financialGoals: ${event.financialGoals}, riskManagement: ${event.riskManagement}');
      await userService.updateUserProfile(event.currentSavings, event.debt,
          event.financialGoals, event.riskManagement);
      emit(financialProfileSuccess(message: "Data berhasil diperbarui"));
      // Panggil event untuk refresh data setelah sukses update
      add(HomepageStarted());
    } catch (e) {
      print('[HomepageBloc] Terjadi error saat update profile: $e');
      emit(financialProfileFailure("Gagal memperbarui data: ${e.toString()}"));
    }
  }
}
