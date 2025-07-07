// lib/blocs/homepage/homepage_state.dart

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
  final Advice? advice;
  final bool isAdviceLoading;
  final String? adviceError;

  HomePageSuccess({
    required this.message,
    required this.user,
    this.advice,
    this.isAdviceLoading = false,
    this.adviceError,
  });

  // 4. Tambahkan method copyWith untuk mempermudah update state
  HomePageSuccess copyWith({
    String? message,
    User? user,
    Advice? advice,
    bool? isAdviceLoading,
    String? adviceError,
  }) {
    return HomePageSuccess(
      message: message ?? this.message,
      user: user ?? this.user,
      advice: advice ?? this.advice,
      isAdviceLoading: isAdviceLoading ?? this.isAdviceLoading,
      adviceError: adviceError ?? this.adviceError,
    );
  }
}

class HomePageFailure extends HomepageState {
  final String error;
  HomePageFailure(this.error);
}

class FinancialProfileLoading extends HomepageState {
  final String message;
  FinancialProfileLoading(this.message);
}

class FinancialProfileSuccess extends HomepageState {
  final String message;
  FinancialProfileSuccess({required this.message});
}

class FinancialProfileFailure extends HomepageState {
  final String error;
  FinancialProfileFailure(this.error);
}
