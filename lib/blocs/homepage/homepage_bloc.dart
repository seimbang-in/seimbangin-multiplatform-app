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
    on<HomepageEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<HomepageStarted>(getUserData);
  }

  Future<void> getUserData(
      HomepageStarted event, Emitter<HomepageState> emit) async {
    emit(HomePageLoading('Sedang memuat data user...'));
    try {
      final userData = await userService.getUserProfile();
      final adviceData = await userService.getUserAdvice();
      emit(HomePageSuccess(
          message: 'Berhasil mendapatkan data user',
          user: userData,
          advice: adviceData));
    } catch (e) {
      emit(HomePageFailure('Gagal mendapatkan data user'));
    }
  }
}
