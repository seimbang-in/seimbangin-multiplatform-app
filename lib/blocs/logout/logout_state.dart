part of 'logout_bloc.dart';

@immutable
sealed class LogoutState {}

final class LogoutInitial extends LogoutState {}

final class LogoutLoading extends LogoutState {}

final class LogoutSuccess extends LogoutState {}

final class LogoutFailure extends LogoutState {
  final String error;
  LogoutFailure(this.error);
}
