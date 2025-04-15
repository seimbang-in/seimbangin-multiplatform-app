part of 'homepage_bloc.dart';

@immutable
sealed class HomepageState {}

final class HomepageInitial extends HomepageState {}

class HomePageLoading extends HomepageState {
  final String message;
  HomePageLoading(this.message);
}

class HomePageSuccess extends HomepageState {
  final String message;
  final User user;
  final Advice advice;
  HomePageSuccess(
      {required this.message, required this.user, required this.advice});
}

class HomePageFailure extends HomepageState {
  final String error;
  HomePageFailure(this.error);
}
