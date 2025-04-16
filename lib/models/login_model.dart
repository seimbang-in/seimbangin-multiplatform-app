class LoginModel {
  String status;
  int code;
  String message;
  Data data;

  LoginModel({
    required this.status,
    required this.code,
    required this.message,
    required this.data,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        status: json["status"],
        code: json["code"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );
}

class Data {
  String token;
  int expiresIn;

  Data({
    required this.token,
    required this.expiresIn,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        token: json["token"],
        expiresIn: json["expiresIn"],
      );
}

class Register {
    String status;
    int code;
    String message;

    Register({
        required this.status,
        required this.code,
        required this.message,
    });

    factory Register.fromJson(Map<String, dynamic> json) => Register(
        status: json["status"],
        code: json["code"],
        message: json["message"],
    );

}
