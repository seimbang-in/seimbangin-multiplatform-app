import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/models/user_model.dart'; // Pastikan UserData dan FinanceProfile ada di sini
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class FinancialProfilePage extends StatefulWidget {
  const FinancialProfilePage({super.key});

  @override
  State<FinancialProfilePage> createState() => _FinancialProfilePageState();
}

class _FinancialProfilePageState extends State<FinancialProfilePage> {
  String? _selectedInterval = 'low';
  final List<String> _intervals = ['low', 'normal', 'high'];

  final TextEditingController _financialGoalsController =
      TextEditingController();
  final TextEditingController _currentSavingController =
      TextEditingController();
  final TextEditingController _totalDebtController = TextEditingController();

  bool _formInitialized = false;

  @override
  void initState() {
    super.initState();
    // Coba inisialisasi dari state BLoC saat ini jika sudah tersedia
    // Ini berguna jika data sudah ada sebelum listener pertama kali terpanggil
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

  void _initializeFormFields(FinanceProfile? financeProfileData) {
    // Hanya jalankan jika belum diinisialisasi dan widget masih mounted
    if (!mounted || _formInitialized) return;

    if (financeProfileData != null) {
      _financialGoalsController.text = financeProfileData.financialGoals ?? '';
      _currentSavingController.text =
          financeProfileData.currentSavings?.toString() ?? '';
      _totalDebtController.text = financeProfileData.debt?.toString() ?? '';

      String newSelectedInterval = 'low'; // Default
      if (financeProfileData.riskManagement != null &&
          _intervals
              .contains(financeProfileData.riskManagement!.toLowerCase())) {
        newSelectedInterval = financeProfileData.riskManagement!.toLowerCase();
      }

      // setState dipanggil di sini, yang aman karena akan dipanggil dari listener atau initState
      setState(() {
        _selectedInterval = newSelectedInterval;
        _formInitialized = true;
      });
    } else {
      // Jika tidak ada data profil finansial, kita tetap tandai sebagai "sudah diinisialisasi"
      // agar tidak mencoba mengisi form berulang kali jika state HomePageSuccess datang
      // tanpa data financeProfile.
      setState(() {
        _formInitialized = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomepageBloc, HomepageState>(
      listener: (context, state) {
        // --- Logika inisialisasi form dipindahkan ke listener ---
        if (state is HomePageSuccess && !_formInitialized) {
          _initializeFormFields(state.user.data.financeProfile);
        }
        // --- Akhir logika inisialisasi form ---

        if (state is FinancialProfileLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is FinancialProfileSuccess) {
          if (Navigator.of(context, rootNavigator: true).canPop()) {
            Navigator.of(context, rootNavigator: true).pop();
          }
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
        // Bagian builder sekarang tidak lagi memanggil _initializeFormFields secara langsung.
        // Ia hanya fokus membangun UI berdasarkan state controller dan _selectedInterval saat ini.
        return Scaffold(
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
                  value: _selectedInterval,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.r, vertical: 14.r),
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
                Text("Current Saving (Rp)",
                    style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w600, fontSize: 14.sp)),
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
                  keyboardType: TextInputType.number,
                  style: blackTextStyle.copyWith(
                      fontSize: 14.sp, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 42.h),
                PrimaryFilledButton(
                  title: 'Save Profile',
                  onPressed: () {
                    if (_financialGoalsController.text.isEmpty ||
                        _currentSavingController.text.isEmpty ||
                        _totalDebtController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please fill all fields'),
                        backgroundColor: Colors.orange,
                      ));
                      return;
                    }

                    final currentSavings =
                        int.tryParse(_currentSavingController.text);
                    final debt = int.tryParse(_totalDebtController.text);

                    if (currentSavings == null || debt == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
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
        );
      },
    );
  }
}
