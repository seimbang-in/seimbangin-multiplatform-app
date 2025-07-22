import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

class StringOrIntConverter implements JsonConverter<String, Object?> {
  const StringOrIntConverter();

  @override
  String fromJson(Object? json) {
    if (json is String) {
      return json;
    }
    if (json is int || json is double) {
      return json.toString();
    }
    return '0';
  }

  @override
  Object toJson(String object) => object;
}

FinanceProfile? _financeProfileFromJson(Map<String, dynamic>? json) {
  if (json == null || json['finance_profile'] == null) {
    return null;
  }
  return FinanceProfile.fromJson(
      json['finance_profile'] as Map<String, dynamic>);
}

@freezed
abstract class UserResponse with _$UserResponse {
  factory UserResponse({
    @Default('') String status,
    required UserData data,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}

/// Model untuk objek 'data'
@freezed
abstract class UserData with _$UserData {
  factory UserData({
    @Default(0) int id,
    @JsonKey(name: 'full_name') @Default('') String fullName,
    int? age,
    @Default('0') String balance,
    @Default('') String username,
    @Default('') String email,
    String? profilePicture,
    String? university,
    String? gender,
    @JsonKey(name: 'birth_date') String? birthDate,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(
      name: 'finance_profile',
      fromJson: _financeProfileFromJson,
    )
    FinanceProfile? financeProfile,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

@freezed
abstract class FinanceProfile with _$FinanceProfile {
  factory FinanceProfile({
    @JsonKey(name: 'monthly_income') double? monthlyIncome,
    @JsonKey(name: 'current_savings')
    @StringOrIntConverter()
    @Default('0')
    String currentSavings,
    @StringOrIntConverter() @Default('0') String debt,
    @JsonKey(name: 'financial_goals') String? financialGoals,
    @JsonKey(name: 'total_income')
    @StringOrIntConverter()
    @Default('0')
    String totalIncome,
    @JsonKey(name: 'total_outcome')
    @StringOrIntConverter()
    @Default('0')
    String totalOutcome,
    @JsonKey(name: 'risk_management') String? riskManagement,
    @JsonKey(name: 'this_month_income')
    @StringOrIntConverter()
    @Default('0')
    String thisMonthIncome,
    @JsonKey(name: 'this_month_outcome')
    @StringOrIntConverter()
    @Default('0')
    String thisMonthOutcome,
  }) = _FinanceProfile;

  factory FinanceProfile.fromJson(Map<String, dynamic> json) =>
      _$FinanceProfileFromJson(json);
}
