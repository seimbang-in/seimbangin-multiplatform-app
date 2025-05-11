part of 'statistics_bloc.dart';

@immutable
sealed class StatisticsState {}

final class StatisticsInitial extends StatisticsState {}

class StatisticsMonthlyLoading extends StatisticsState {
  final String message;
  StatisticsMonthlyLoading(this.message);
}

class StatisticsMonthlySuccess extends StatisticsState {
  final List<Datum> statistics;
  StatisticsMonthlySuccess(this.statistics);
}

class StatisticsMonthlyFailure extends StatisticsState {
  final String message;
  StatisticsMonthlyFailure(this.message);
}
