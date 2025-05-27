import 'package:seimbangin_app/models/item_model.dart';

class TransactionPreviewData {
  final String transactionName;
  final int transactionType; // 0 for Income, 1 for Outcome
  final double totalAmount;
  final DateTime transactionDate;
  final List<Item> items;

  TransactionPreviewData({
    required this.transactionName,
    required this.transactionType,
    required this.totalAmount,
    required this.transactionDate,
    required this.items,
  });
}
