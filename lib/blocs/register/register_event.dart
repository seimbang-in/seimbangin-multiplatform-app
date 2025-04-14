part of 'register_bloc.dart';

@immutable
sealed class RegisterEvent {}

class RegisterButtonPressed extends RegisterEvent {
  final String fullname;
  final String username;
  final String email;
  final String password;
  final String phone;

  RegisterButtonPressed({
    required this.fullname,
    required this.phone,
    required this.username,
    required this.email,
    required this.password,
  });
}
