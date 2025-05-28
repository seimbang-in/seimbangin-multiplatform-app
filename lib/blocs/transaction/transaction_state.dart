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

class TransactionGetSuccess extends TransactionState {
  final Transaction transaction;

  TransactionGetSuccess(this.transaction);
}

// --- STATE BARU UNTUK LAZY LOAD ---
// State ini akan menyimpan daftar transaksi yang sudah terkumpul
// dan informasi apakah masih ada halaman berikutnya.
class HistoryLoadSuccess extends TransactionState {
  final List<Data> transactions;
  final bool hasReachedMax;

  HistoryLoadSuccess({
    required this.transactions,
    required this.hasReachedMax,
  });

  HistoryLoadSuccess copyWith({
    List<Data>? transactions,
    bool? hasReachedMax,
  }) {
    return HistoryLoadSuccess(
      transactions: transactions ?? this.transactions,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
