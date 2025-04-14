import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/models/login_model.dart';
import 'package:seimbangin_app/services/login_service.dart';
import 'package:seimbangin_app/utils/token.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthService authService;

  LoginBloc({required this.authService}) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    print('Event received: LoginButtonPressed');
    // emit(LoginLoading());
    try {
      final result = await authService.login(
        event.identifier,
        event.password,
      );
      print('Result dari AuthService.login(): $result');
      await Token.saveToken(result.data.token);
      emit(LoginSuccess(result));
    } catch (e, stackTrace) {
      print('Login failed: $e');
      print('StackTrace: $stackTrace'); // Dapatkan lebih detail errornya
      emit(LoginFailure(e.toString()));
    }
  }
}
