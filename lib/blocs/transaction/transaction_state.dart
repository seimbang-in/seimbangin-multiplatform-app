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

// --- PERUBAHAN UTAMA DI SINI ---
// State ini akan menjadi satu-satunya state sukses untuk memuat data.
class TransactionLoadSuccess extends TransactionState {
  // Data untuk homepage (limit 3)
  final List<Data> recentTransactions;

  // Data untuk halaman histori (semua data, bisa bertambah dengan lazy load)
  final List<Data> historicalTransactions;
  final bool hasReachedMax;

  TransactionLoadSuccess({
    this.recentTransactions = const [],
    this.historicalTransactions = const [],
    this.hasReachedMax = false,
  });

  TransactionLoadSuccess copyWith({
    List<Data>? recentTransactions,
    List<Data>? historicalTransactions,
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
