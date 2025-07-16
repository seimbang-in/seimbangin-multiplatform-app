import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

FinanceProfile? _financeProfileFromJson(Map<String, dynamic>? json) {
  if (json == null || json['finance_profile'] == null) {
    return null;
  }
  return FinanceProfile.fromJson(
      json['finance_profile'] as Map<String, dynamic>);
}

// Wrapper utama untuk respons API
@freezed
abstract class UserResponse with _$UserResponse {
  factory UserResponse({
    @Default('') String status,
    required UserData data,
  }) = _UserResponse;

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
}

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

    // --- LANGKAH 2: GUNAKAN FUNGSI HELPER PADA ANOTASI @JsonKey ---
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
    @JsonKey(name: 'current_savings') @Default('0.00') String currentSavings,
    @Default('0.00') String debt,
    @JsonKey(name: 'financial_goals') @Default('') String financialGoals,
    @JsonKey(name: 'total_income') @Default('0') String totalIncome,
    @JsonKey(name: 'total_outcome') @Default('0') String totalOutcome,
    @JsonKey(name: 'risk_management') @Default('') String riskManagement,
    @JsonKey(name: 'this_month_income') @Default('0') String thisMonthIncome,
    // Tambahkan field yang mungkin terlewat dari respons
    @JsonKey(name: 'this_month_outcome') @Default('0') String thisMonthOutcome,
  }) = _FinanceProfile;

  factory FinanceProfile.fromJson(Map<String, dynamic> json) =>
      _$FinanceProfileFromJson(json);
}
