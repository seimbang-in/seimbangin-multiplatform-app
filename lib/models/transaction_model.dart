class Transaction {
  String status;
  int code;
  String message;
  List<Data> data;
  Meta meta;

  Transaction({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
    required this.meta,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    var dataFromJson = json['data'] as List;
    List<Data> dataList = dataFromJson.map((i) => Data.fromJson(i)).toList();

    return Transaction(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: dataList,
      meta: Meta.fromJson(json['meta']),
    );
  }
}

class Data {
  int id;
  int userId;
  String name;
  int type;
  String amount;
  String category;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  List<Item> items;

  Data({
    required this.id,
    required this.userId,
    required this.name,
    required this.type,
    required this.amount,
    required this.category,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] as List;
    List<Item> itemsList = itemsFromJson.map((i) => Item.fromJson(i)).toList();

    return Data(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      type: json['type'],
      amount: json['amount'],
      category: json['category'],
      description: json['description'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: itemsList,
    );
  }
}

class Item {
  int id;
  int transactionId;
  String itemName;
  String category;
  String price;
  int quantity;
  String subtotal;
  dynamic createdAt;
  dynamic updatedAt;

  Item({
    required this.id,
    required this.transactionId,
    required this.itemName,
    required this.category,
    required this.price,
    required this.quantity,
    required this.subtotal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      id: json['id'],
      transactionId: json['transaction_id'],
      itemName: json['item_name'],
      category: json['category'],
      price: json['price'],
      quantity: json['quantity'],
      subtotal: json['subtotal'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}

class Meta {
  int currentPage;
  int limit;
  int totalItems;
  int totalPages;
  bool hasNextPage;
  bool hasPreviousPage;

  Meta({
    required this.currentPage,
    required this.limit,
    required this.totalItems,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) {
    return Meta(
      currentPage: json['currentPage'],
      limit: json['limit'],
      totalItems: json['totalItems'],
      totalPages: json['totalPages'],
      hasNextPage: json['hasNextPage'],
      hasPreviousPage: json['hasPreviousPage'],
    );
  }
}
