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

class FetchHistoryTransactions extends TransactionEvent {
  // Tambahkan properti ini untuk menangani pull-to-refresh
  final bool isRefresh;
  FetchHistoryTransactions({this.isRefresh = false});
}
