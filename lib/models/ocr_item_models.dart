class OcrItem {
    String status;
    int code;
    String message;
    Data data;

    OcrItem({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    factory OcrItem.fromJson(Map<String, dynamic> json) {
        return OcrItem(
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
    List<Item> items;
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
        List<Item> itemsList = itemsFromJson.map((i) => Item.fromJson(i)).toList();

        return Data(
            store: json['store'],
            date: DateTime.parse(json['date']),
            items: itemsList,
            discount: json['discount'],
            tax: json['tax'],
            total: json['total'],
        );
    }

}

class Item {
    String itemName;
    String category;
    int quantity;
    int price;

    Item({
        required this.itemName,
        required this.category,
        required this.quantity,
        required this.price,
    });

    factory Item.fromJson(Map<String, dynamic> json) {
        return Item(
            itemName: json['item_name'],
            category: json['category'],
            quantity: json['quantity'],
            price: json['price'],
        );
    }

}
