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
  }

  Future<void> _handleHomepageStarted(
    HomepageStarted event,
    Emitter<HomepageState> emit,
  ) async {
    try {
      // Cek jika data sudah ada
      if (state is! HomePageSuccess) {
        emit(HomePageLoading('Memuat data...'));
        final userData = await userService.getUserProfile();
        final adviceData = await userService.getUserAdvice();
        emit(HomePageSuccess(
          message: 'Data berhasil dimuat',
          user: userData,
          advice: adviceData,
        ));
      }
    } catch (e) {
      emit(HomePageFailure('Gagal memuat data: ${e.toString()}'));
    }
  }
}
