part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButtonPressed extends LoginEvent {
  final String identifier;
  final String password;

  LoginButtonPressed({required this.identifier, required this.password});
}
