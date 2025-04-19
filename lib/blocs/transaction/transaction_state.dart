part of 'transaction_bloc.dart';

@immutable
sealed class TransactionState {}

final class TransactionInitial extends TransactionState {}

class TransactionLoading extends TransactionState {
  final String message;
  TransactionLoading(this.message);
}

class TransactionSuccess extends TransactionState {
  final String message;
  TransactionSuccess(this.message);
}

class TransactionFailure extends TransactionState {
  final String message;
  TransactionFailure(this.message);
}
