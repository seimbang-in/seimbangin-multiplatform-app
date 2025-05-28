part of 'transaction_bloc.dart';

@immutable
sealed class TransactionEvent {}

class TransactionButtonPressed extends TransactionEvent {
  final String name;
  final String description;
  final int type;
  final List<Item> items;

  TransactionButtonPressed({
    required this.description,
    required this.type,
    required this.items,
    required this.name,
  });
}

// Event lama untuk homepage tetap ada
class GetRecentTransactionsEvent extends TransactionEvent {
  final int limit;
  GetRecentTransactionsEvent({required this.limit});
}

// --- EVENT BARU UNTUK LAZY LOAD ---
class FetchHistoryTransactions extends TransactionEvent {}
