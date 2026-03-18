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
import 'package:seimbangin_app/ui/sections/profile/financial_profile_header_section.dart';
import 'package:seimbangin_app/ui/sections/profile/financial_profile_form_section.dart';

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
            statusBarColor: context.color.statusBarPrimaryColor,
            statusBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            backgroundColor: context.color.backgroundWhiteColor,
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
                            size: 32.r, color: context.color.textSecondaryColor),
                        backgroundColor: context.color.backgroundWhiteColor,
                      ),
                      Image.asset('assets/ic_seimbangin-logo-logreg.png'),
                    ],
                  ),
                  const FinancialProfileHeaderSection(),
                  SizedBox(height: 32.h),
                  FinancialProfileFormSection(
                    financialGoalsController: _financialGoalsController,
                    currentSavingController: _currentSavingController,
                    totalDebtController: _totalDebtController,
                    selectedInterval: _selectedInterval,
                    intervals: _intervals,
                    onIntervalChanged: (String? newValue) {
                      if (mounted) {
                        setState(() => _selectedInterval = newValue);
                      }
                    },
                    onCurrencyChanged: _formatCurrencyInput,
                  ),
                  SizedBox(height: 48.h),
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
