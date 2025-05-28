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

class GetRecentTransactionsEvent extends TransactionEvent {
  final int limit;

  GetRecentTransactionsEvent({this.limit = 3}); // Default 2 transaksi terbaru
}
