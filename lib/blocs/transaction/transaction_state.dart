// lib/blocs/transaction/transaction_state.dart

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

class TransactionLoadSuccess extends TransactionState {
  final List<TransactionData> recentTransactions;

  final List<TransactionData> historicalTransactions;
  final bool hasReachedMax;

  TransactionLoadSuccess({
    this.recentTransactions = const [],
    this.historicalTransactions = const [],
    this.hasReachedMax = false,
  });

  TransactionLoadSuccess copyWith({
    List<TransactionData>? recentTransactions,
    List<TransactionData>? historicalTransactions,
    bool? hasReachedMax,
  }) {
    return TransactionLoadSuccess(
      recentTransactions: recentTransactions ?? this.recentTransactions,
      historicalTransactions:
          historicalTransactions ?? this.historicalTransactions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
