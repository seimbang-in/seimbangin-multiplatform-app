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
  int id;
  String fullName;
  int age;
  String balance;
  String username;
  String email;
  dynamic profilePicture;
  dynamic university;
  String gender;
  dynamic birthDate;
  DateTime createdAt;
  DateTime updatedAt;
  FinanceProfile financeProfile;
  List<ThisMonthIncome> thisMonthIncome;

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
    required this.financeProfile,
    required this.thisMonthIncome,
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
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      financeProfile: FinanceProfile.fromJson(json['finance_profile']),
      thisMonthIncome: (json['thisMonthIncome'] as List)
          .map((e) => ThisMonthIncome.fromJson(e))
          .toList(),
    );
  }
}

class FinanceProfile {
  String monthlyIncome;
  String currentSavings;
  String debt;
  String financialGoals;
  String riskManagement;

  FinanceProfile({
    required this.monthlyIncome,
    required this.currentSavings,
    required this.debt,
    required this.financialGoals,
    required this.riskManagement,
  });

  factory FinanceProfile.fromJson(Map<String, dynamic> json) {
    return FinanceProfile(
      monthlyIncome: json['monthly_income'],
      currentSavings: json['current_savings'],
      debt: json['debt'],
      financialGoals: json['financial_goals'],
      riskManagement: json['risk_management'],
    );
  }
}

class ThisMonthIncome {
  dynamic averageIncome;

  ThisMonthIncome({
    required this.averageIncome,
  });

  factory ThisMonthIncome.fromJson(Map<String, dynamic> json) {
    return ThisMonthIncome(
      averageIncome: json['average_income'],
    );
  }
}
