class StatisticsModel {
  String status;
  int code;
  String message;
  List<Datum> data;

  StatisticsModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    var dataFromJson = json['data'] as List;
    List<Datum> dataList = dataFromJson.map((i) => Datum.fromJson(i)).toList();

    return StatisticsModel(
      status: json['status'],
      code: json['code'],
      message: json['message'],
      data: dataList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'code': code,
      'message': message,
      'data': data.map((datum) => datum.toJson()).toList(),
    };
  }
}

class Datum {
  String month;
  int income;
  int outcome;

  Datum({
    required this.month,
    required this.income,
    required this.outcome,
  });

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      month: json['month'],
      income: json['income'],
      outcome: json['outcome'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'month': month,
      'income': income,
      'outcome': outcome,
    };
  }
}
