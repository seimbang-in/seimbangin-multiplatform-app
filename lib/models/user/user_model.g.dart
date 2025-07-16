// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserResponse _$UserResponseFromJson(Map<String, dynamic> json) =>
    _UserResponse(
      status: json['status'] as String? ?? '',
      data: UserData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserResponseToJson(_UserResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
    };

_UserData _$UserDataFromJson(Map<String, dynamic> json) => _UserData(
      id: (json['id'] as num?)?.toInt() ?? 0,
      fullName: json['full_name'] as String? ?? '',
      age: (json['age'] as num?)?.toInt(),
      balance: json['balance'] as String? ?? '0',
      username: json['username'] as String? ?? '',
      email: json['email'] as String? ?? '',
      profilePicture: json['profilePicture'] as String?,
      university: json['university'] as String?,
      gender: json['gender'] as String?,
      birthDate: json['birth_date'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      phoneNumber: json['phone_number'] as String?,
      financeProfile: _financeProfileFromJson(
          json['finance_profile'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$UserDataToJson(_UserData instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'age': instance.age,
      'balance': instance.balance,
      'username': instance.username,
      'email': instance.email,
      'profilePicture': instance.profilePicture,
      'university': instance.university,
      'gender': instance.gender,
      'birth_date': instance.birthDate,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'phone_number': instance.phoneNumber,
      'finance_profile': instance.financeProfile,
    };

_FinanceProfile _$FinanceProfileFromJson(Map<String, dynamic> json) =>
    _FinanceProfile(
      monthlyIncome: (json['monthly_income'] as num?)?.toDouble(),
      currentSavings: json['current_savings'] as String? ?? '0.00',
      debt: json['debt'] as String? ?? '0.00',
      financialGoals: json['financial_goals'] as String? ?? '',
      totalIncome: json['total_income'] as String? ?? '0',
      totalOutcome: json['total_outcome'] as String? ?? '0',
      riskManagement: json['risk_management'] as String? ?? '',
      thisMonthIncome: json['this_month_income'] as String? ?? '0',
      thisMonthOutcome: json['this_month_outcome'] as String? ?? '0',
    );

Map<String, dynamic> _$FinanceProfileToJson(_FinanceProfile instance) =>
    <String, dynamic>{
      'monthly_income': instance.monthlyIncome,
      'current_savings': instance.currentSavings,
      'debt': instance.debt,
      'financial_goals': instance.financialGoals,
      'total_income': instance.totalIncome,
      'total_outcome': instance.totalOutcome,
      'risk_management': instance.riskManagement,
      'this_month_income': instance.thisMonthIncome,
      'this_month_outcome': instance.thisMonthOutcome,
    };
