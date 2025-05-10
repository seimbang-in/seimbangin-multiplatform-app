part of 'homepage_bloc.dart';

@immutable
sealed class HomepageEvent {}

class HomepageStarted extends HomepageEvent {}

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
