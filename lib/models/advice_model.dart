class Advice {
    String status;
    int code;
    String message;
    String data;

    Advice({
        required this.status,
        required this.code,
        required this.message,
        required this.data,
    });

    factory Advice.fromJson(Map<String, dynamic> json) => Advice(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: json["data"],
    );

}
