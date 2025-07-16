import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_model.freezed.dart';
part 'register_model.g.dart';

// Model utama yang membungkus seluruh respons
@freezed
abstract class RegisterResponse with _$RegisterResponse {
  factory RegisterResponse({
    @Default('') String message,
    // Objek data bisa saja tidak ada pada respons error, jadi kita buat opsional
    UserData? data,
  }) = _RegisterResponse;

  factory RegisterResponse.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseFromJson(json);
}

// Model untuk objek 'data' yang berisi detail user
@freezed
abstract class UserData with _$UserData {
  factory UserData({
    @Default(0) int id,
    @Default('') String email,
    @Default('') String username,
    // Map 'full_name' dari JSON ke 'fullName' di Dart
    @JsonKey(name: 'full_name') @Default('') String fullName,
    @Default('') String phone,
    @Default('0.00') String balance,
    @Default(false) bool isEmailVerified,
    String? createdAt,
    String? updatedAt,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}
