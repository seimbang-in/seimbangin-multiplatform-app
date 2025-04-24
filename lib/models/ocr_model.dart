class OcrModel {
  String status;
  int code;
  String message;
  Data data;

  OcrModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory OcrModel.fromJson(Map<String, dynamic> json) {
    return OcrModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  String store;
  DateTime date;
  List<OcrItem> items;
  int discount;
  int tax;
  int total;

  Data({
    required this.store,
    required this.date,
    required this.items,
    required this.discount,
    required this.tax,
    required this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    var itemsFromJson = json['items'] as List;
    List<OcrItem> itemsList = itemsFromJson.map((i) => OcrItem.fromJson(i)).toList();

    return Data(
      store: json['store'],
      date: DateTime.parse(json['date']),
      items: itemsList,
      discount: json['Discount'],
      tax: json['tax'],
      total: json['total'],
    );
  }
}

class OcrItem {
  String itemName;
  String category;
  int quantity;
  int price;

  OcrItem({
    required this.itemName,
    required this.category,
    required this.quantity,
    required this.price,
  });

  factory OcrItem.fromJson(Map<String, dynamic> json) {
    return OcrItem(
      itemName: json['item_name'],
      category: json['category'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}
