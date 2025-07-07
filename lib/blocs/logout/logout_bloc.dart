import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/services/logout_service.dart'; // Import service
import 'package:seimbangin_app/utils/token.dart'; // Import token util

part 'logout_event.dart';
part 'logout_state.dart';

class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final LogoutService logoutService;

  LogoutBloc({required this.logoutService}) : super(LogoutInitial()) {
    on<LogoutButtonPressed>(_onLogoutButtonPressed);
  }

  Future<void> _onLogoutButtonPressed(
    LogoutButtonPressed event,
    Emitter<LogoutState> emit,
  ) async {
    emit(LogoutLoading());
    try {
      await logoutService.logout();

      await Token.clearToken();

      emit(LogoutSuccess());
    } catch (e) {
      await Token.clearToken();
      emit(LogoutFailure(e.toString()));
    }
  }
}
