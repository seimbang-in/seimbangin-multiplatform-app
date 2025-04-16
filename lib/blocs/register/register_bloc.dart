import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:seimbangin_app/services/login_service.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService authService;
  RegisterBloc({required this.authService}) : super(RegisterInitial()) {
    on<RegisterEvent>((event, emit) {
    });
    on<RegisterButtonPressed>(onRegisterButtonPressed);
  }

  Future<void> onRegisterButtonPressed(
    RegisterButtonPressed event,
    Emitter<RegisterState> emit,
  ) async {
    emit(RegisterLoading());
    try {
      final result = await authService.register(
        event.fullname,
        event.username,
        event.email,
        event.password,
        event.phone,
      );
      emit(RegisterSuccess(result.message));
    } catch (e) {
      emit(RegisterFailure(e.toString()));
    }
  }
}
