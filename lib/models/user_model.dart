class User {
  String status;
  Data data;

  User({
    required this.status,
    required this.data,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      status: json['status'],
      data: Data.fromJson(json['data']),
    );
  }
}

class Data {
  int? id;
  String? fullName;
  dynamic age;
  String? balance;
  String? username;
  String? email;
  dynamic profilePicture;
  dynamic university;
  String? gender;
  dynamic birthDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? phoneNumber;
  FinanceProfile? financeProfile;

  Data({
    required this.id,
    required this.fullName,
    required this.age,
    required this.balance,
    required this.username,
    required this.email,
    required this.profilePicture,
    required this.university,
    required this.gender,
    required this.birthDate,
    required this.createdAt,
    required this.updatedAt,
    required this.phoneNumber,
    required this.financeProfile,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
      id: json['id'],
      fullName: json['full_name'],
      age: json['age'],
      balance: json['balance'],
      username: json['username'],
      email: json['email'],
      profilePicture: json['profilePicture'],
      university: json['university'],
      gender: json['gender'],
      birthDate: json['birth_date'],
      phoneNumber: json['phone_number'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      financeProfile: FinanceProfile.fromJson(json['finance_profile']),
    );
  }
}

class FinanceProfile {
  dynamic monthlyIncome;
  dynamic currentSavings;
  dynamic debt;
  dynamic financialGoals;
  dynamic totalIncome;
  dynamic totalOutcome;
  dynamic riskManagement;
  dynamic thisMonthIncome;

  FinanceProfile({
    required this.monthlyIncome,
    required this.currentSavings,
    required this.debt,
    required this.financialGoals,
    required this.totalIncome,
    required this.totalOutcome,
    required this.riskManagement,
    required this.thisMonthIncome,
  });

  factory FinanceProfile.fromJson(Map<String, dynamic> json) {
    return FinanceProfile(
        monthlyIncome: json['monthly_income'],
        currentSavings: json['current_savings'],
        debt: json['debt'],
        financialGoals: json['financial_goals'],
        totalIncome: json['total_income'],
        totalOutcome: json['total_outcome'],
        riskManagement: json['risk_management'],
        thisMonthIncome: json['this_month_income']);
  }
}

