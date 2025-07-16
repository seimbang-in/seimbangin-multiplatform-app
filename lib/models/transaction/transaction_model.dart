import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction_model.freezed.dart';
part 'transaction_model.g.dart';

@freezed
abstract class TransactionResponse with _$TransactionResponse {
  factory TransactionResponse({
    @Default(false) bool success,
    @Default('') String message,
    @Default([]) List<TransactionData> data,
    Meta? meta,
  }) = _TransactionResponse;

  factory TransactionResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionResponseFromJson(json);
}

@freezed
abstract class TransactionData with _$TransactionData {
  factory TransactionData({
    @Default(0) int id,
    @JsonKey(name: 'user_id') @Default(0) int userId,
    @Default('') String name,
    @Default(0) int type,
    @Default('0') String amount,
    @Default('others') String category,
    @Default('') String description,
    String? createdAt,
    String? updatedAt,
    @Default([]) List<TransactionItem> items,
  }) = _TransactionData;

  factory TransactionData.fromJson(Map<String, dynamic> json) =>
      _$TransactionDataFromJson(json);
}

@freezed
abstract class TransactionPreviewData with _$TransactionPreviewData {
  factory TransactionPreviewData({
    required String transactionName,
    required int transactionType, // 0 for Income, 1 for Outcome
    required double totalAmount,
    required DateTime transactionDate,
    @Default([]) List<TransactionItem> items,
  }) = _TransactionPreviewData;
}

@freezed
abstract class TransactionItem with _$TransactionItem {
  factory TransactionItem({
    @Default(0) int id,
    @JsonKey(name: 'transaction_id') @Default(0) int transactionId,
    @JsonKey(name: 'item_name') @Default('') String itemName,
    @Default('others') String category,
    @Default('0') String price,
    @Default(0) int quantity,
    @Default('0') String subtotal,
    String? createdAt,
    String? updatedAt,
  }) = _TransactionItem;

  factory TransactionItem.fromJson(Map<String, dynamic> json) =>
      _$TransactionItemFromJson(json);
}

@freezed
abstract class Meta with _$Meta {
  factory Meta({
    @JsonKey(name: 'currentPage') @Default(0) int currentPage,
    @Default(0) int limit,
    @JsonKey(name: 'totalPages') @Default(0) int totalPages,
    @JsonKey(name: 'totalItems') @Default(0) int totalItems,
    @JsonKey(name: 'hasNextPage') @Default(false) bool hasNextPage,
    @JsonKey(name: 'hasPreviousPage') @Default(false) bool hasPreviousPage,
  }) = _Meta;

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);
}
