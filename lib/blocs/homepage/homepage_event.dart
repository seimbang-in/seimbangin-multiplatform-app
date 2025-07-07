part of 'homepage_bloc.dart';

@immutable
sealed class HomepageEvent {}

class HomepageStarted extends HomepageEvent {}

class _FetchAiAdvice extends HomepageEvent {}

// Event baru untuk refresh
class HomepageRefresh extends HomepageEvent {}

// Event untuk refresh dengan loading indicator
class HomepageRefreshWithLoading extends HomepageEvent {}

class UpdateFinancialProfile extends HomepageEvent {
  final int currentSavings;
  final int debt;
  final String financialGoals;
  final String riskManagement;

  UpdateFinancialProfile({
    required this.currentSavings,
    required this.debt,
    required this.financialGoals,
    required this.riskManagement,
  });
}
