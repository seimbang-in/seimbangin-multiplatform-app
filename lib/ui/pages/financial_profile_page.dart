import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/models/user/user_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';
import 'package:seimbangin_app/ui/widgets/alert_dialog_widget.dart';

class FinancialProfilePage extends StatefulWidget {
  const FinancialProfilePage({super.key});

  @override
  State<FinancialProfilePage> createState() => _FinancialProfilePageState();
}

class _FinancialProfilePageState extends State<FinancialProfilePage> {
  // INTERVAL LISTS
  String? _selectedInterval = 'low';
  final List<String> _intervals = ['low', 'high'];

  // CONTROLLER LIST
  final TextEditingController _financialGoalsController =
      TextEditingController();
  final TextEditingController _currentSavingController =
      TextEditingController();
  final TextEditingController _totalDebtController = TextEditingController();

  // CURRENCY FORMATTER
  final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  bool _formInitialized = false;

  @override
  void initState() {
    super.initState();

    final initialHomepageState = context.read<HomepageBloc>().state;
    if (initialHomepageState is HomePageSuccess && !_formInitialized) {
      _initializeFormFields(initialHomepageState.user.data.financeProfile);
    }
  }

  @override
  void dispose() {
    _financialGoalsController.dispose();
    _currentSavingController.dispose();
    _totalDebtController.dispose();
    super.dispose();
  }

  // LOADING DATA FROM BE
  void _initializeFormFields(FinanceProfile? financeProfileData) {
    if (!mounted || _formInitialized) return;

    if (financeProfileData != null) {
      _financialGoalsController.text = financeProfileData.financialGoals ?? '';

      // CHECKING CURRENTSAVING DATA AND FORMATTING INTO REGULAR NUMBER
      final double? parsedValueSavings =
          double.tryParse(financeProfileData.currentSavings);
      if (parsedValueSavings != null) {
        _currentSavingController.text =
            _currencyFormatter.format(parsedValueSavings);
      }

      // CHECKING DEBT DATA AND FORMATTING INTO REGULAR NUMBER
      final double? parsedValueDebt = double.tryParse(financeProfileData.debt);
      if (parsedValueDebt != null) {
        _totalDebtController.text = _currencyFormatter.format(parsedValueDebt);
      }

      String newSelectedInterval = 'low';
      if (financeProfileData.riskManagement != null &&
          _intervals
              .contains(financeProfileData.riskManagement!.toLowerCase())) {
        newSelectedInterval = financeProfileData.riskManagement!.toLowerCase();
      }

      setState(() {
        _selectedInterval = newSelectedInterval;
        _formInitialized = true;
      });
    } else {
      setState(() {
        _formInitialized = true;
      });
    }
  }

  void _formatCurrencyInput(String value, TextEditingController controller) {
    String cleanValue = value.replaceAll(RegExp(r'[^\d]'), '');
    double? parsedValue = double.tryParse(cleanValue);

    if (parsedValue != null) {
      String formattedValue = _currencyFormatter.format(parsedValue);
      controller.value = TextEditingValue(
        text: formattedValue,
        selection: TextSelection.collapsed(offset: formattedValue.length),
      );
    } else if (cleanValue.isEmpty) {
      controller.clear();
    }
  }

  int? _parseCurrency(String formattedValue) {
    if (formattedValue.isEmpty) {
      return 0;
    }
    final cleanValue = formattedValue.replaceAll(RegExp(r'[^\d]'), '');
    if (cleanValue.isEmpty) {
      return 0;
    }
    return int.tryParse(cleanValue);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomepageBloc, HomepageState>(
      listener: (context, state) {
        if (state is HomePageSuccess && !_formInitialized) {
          _initializeFormFields(state.user.data.financeProfile);
        }
        if (state is FinancialProfileLoading) {
          AlertDialogWidget.showLoading(context, message: 'Saving data...');
        } else if (state is FinancialProfileSuccess) {
          AlertDialogWidget.dismiss(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Financial profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          context.read<HomepageBloc>().add(HomepageStarted());
          routes.replaceNamed(RouteNames.main);
        } else if (state is FinancialProfileFailure) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: statusBarPrimaryColor,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: backgroundWhiteColor,
            body: SafeArea(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24).r,
                children: [
                  SizedBox(height: 21.r),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomRoundedButton(
                        onPressed: () => routes.pop(),
                        widget: Icon(Icons.chevron_left,
                            size: 32.r, color: textSecondaryColor),
                        backgroundColor: backgroundWhiteColor,
                      ),
                      Image.asset('assets/ic_seimbangin-logo-logreg.png'),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset('assets/img_mascot-login.png', height: 150.h),
                      SizedBox(height: 20.r),
                      Text('Financial Profile',
                          style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w600, fontSize: 18.sp)),
                      SizedBox(height: 4.r),
                      Text(
                        'Complete or update your financial profile for AI Advise.',
                        style: greyTextStyle.copyWith(
                            fontWeight: FontWeight.w500, fontSize: 14.sp),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                  SizedBox(height: 30.h),
                  Text("Risk Management Profile",
                      style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 14.sp)),
                  SizedBox(height: 8.h),
                  DropdownButtonFormField<String>(
                    initialValue: _selectedInterval,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.r, vertical: 14.r),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide:
                              BorderSide(color: textBlueColor, width: 1.r)),
                    ),
                    items: _intervals.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value.toUpperCase(),
                            style: blackTextStyle.copyWith(
                                fontSize: 14.sp, fontWeight: FontWeight.w500)),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      if (mounted) setState(() => _selectedInterval = newValue);
                    },
                    icon: Icon(Icons.arrow_drop_down,
                        color: textPrimaryColor, size: 24.r),
                    dropdownColor: backgroundWhiteColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  SizedBox(height: 16.h),
                  Text("Financial Goals",
                      style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 14.sp)),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _financialGoalsController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      hintText: 'e.g., Buy a house, Travel',
                      hintStyle: greyTextStyle.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: textBlueColor)),
                    ),
                    style: blackTextStyle.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "Current Saving (Rp)",
                    style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 14.sp),
                  ),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _currentSavingController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      hintText: 'e.g., 5000000',
                      hintStyle: greyTextStyle.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: textBlueColor)),
                    ),
                    onChanged: (value) {
                      _formatCurrencyInput(value, _currentSavingController);
                    },
                    keyboardType: TextInputType.number,
                    style: blackTextStyle.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 16.h),
                  Text("Total Debt (Rp)",
                      style: blackTextStyle.copyWith(
                          fontWeight: FontWeight.w600, fontSize: 14.sp)),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: _totalDebtController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundGreyColor,
                      hintText: 'e.g., 1000000',
                      hintStyle: greyTextStyle.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: textBlueColor)),
                    ),
                    onChanged: (value) {
                      _formatCurrencyInput(value, _totalDebtController);
                    },
                    keyboardType: TextInputType.number,
                    style: blackTextStyle.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 42.h),
                  PrimaryFilledButton(
                    title: 'Save Profile',
                    onPressed: () {
                      if (_financialGoalsController.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Please fill all fields'),
                          backgroundColor: Colors.orange,
                        ));
                        return;
                      }
                      final currentSavings =
                          _parseCurrency(_currentSavingController.text);
                      final debt = _parseCurrency(_totalDebtController.text);
                      if (currentSavings == null || debt == null) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text(
                              'Please enter valid numbers for savings and debt.'),
                          backgroundColor: Colors.orange,
                        ));
                        return;
                      }

                      context.read<HomepageBloc>().add(UpdateFinancialProfile(
                          currentSavings: currentSavings,
                          debt: debt,
                          financialGoals: _financialGoalsController.text,
                          riskManagement: _selectedInterval ?? 'low'));
                    },
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
