import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class FinancialProfilePage extends StatefulWidget {
  const FinancialProfilePage({super.key});

  @override
  State<FinancialProfilePage> createState() => _FinancialProfilePageState();
}

class _FinancialProfilePageState extends State<FinancialProfilePage> {
  String? _selectedInterval = 'low'; // Nilai default
  final List<String> _intervals = ['low', 'normal', 'high'];
  final TextEditingController financialGoalsController =
      TextEditingController();
  final TextEditingController currentSavingController = TextEditingController();
  final TextEditingController totalDebtController = TextEditingController();
  final TextEditingController totalBillController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomepageBloc, HomepageState>(
      listener: (context, state) {
        if (state is financialProfileLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is financialProfileSuccess) {
          // Tutup dialog jika ada
          Navigator.of(context).pop();
          // Tampilkan snackbar sukses
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Financial profile updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
          // Navigasi ke halaman utama
          routes.replaceNamed(RouteNames.main);
        } else if (state is financialProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.error),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: backgroundWhiteColor,
          body: SafeArea(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24).r,
              children: [
                SizedBox(
                  height: 21.r,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomRoundedButton(
                      onPressed: () {
                        routes.replaceNamed(RouteNames.main);
                      },
                      widget: Icon(
                        Icons.chevron_left,
                        size: 32.r,
                        color: textSecondaryColor,
                      ),
                      backgroundColor: backgroundWhiteColor,
                    ),
                    Image.asset(
                      'assets/ic_seimbangin-logo-logreg.png',
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/img_mascot-login.png'),
                    Text(
                      'Financial Profile',
                      style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 4.r,
                    ),
                    Text(
                      'Complete your financial Profile for AI Advise',
                      style: greyTextStyle.copyWith(
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 45.h,
                ),
                DropdownButtonFormField<String>(
                  value: _selectedInterval,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.r,
                      vertical: 14.r,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide(
                        color: textBlueColor,
                        width: 1.r,
                      ),
                    ),
                  ),
                  items: _intervals.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value.toUpperCase(),
                        style: blackTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedInterval = newValue;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: textPrimaryColor,
                    size: 24.r,
                  ),
                  dropdownColor: backgroundGreyColor,
                  borderRadius: BorderRadius.circular(16).r,
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextField(
                  controller: financialGoalsController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'Financial Goals',
                    // errorText: _isFormSubmitted && !_isPhoneValid
                    //     ? '*Phone number cannot be empty'
                    //     : null,
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    errorStyle: warningTextStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide(
                        color: textBlueColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextField(
                  controller: currentSavingController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'Current Saving',
                    // errorText: _isFormSubmitted && !_isPhoneValid
                    //     ? '*Phone number cannot be empty'
                    //     : null,
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    errorStyle: warningTextStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide(
                        color: textBlueColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                TextField(
                  controller: totalDebtController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: backgroundGreyColor,
                    hintText: 'Total Debt',
                    // errorText: _isFormSubmitted && !_isPhoneValid
                    //     ? '*Phone number cannot be empty'
                    //     : null,
                    hintStyle: greyTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    errorStyle: warningTextStyle.copyWith(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide(
                        color: textBlueColor,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24).r,
                      borderSide: BorderSide.none,
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  style: blackTextStyle.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                //
                SizedBox(
                  height: 42.h,
                ),
                PrimaryFilledButton(
                  title: 'Save',
                  onPressed: () {
                    if (financialGoalsController.text.isEmpty ||
                        currentSavingController.text.isEmpty ||
                        totalDebtController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('Please fill all fields'),
                        backgroundColor: backgroundWarningColor,
                      ));
                      return;
                    }

                    context.read<HomepageBloc>().add(UpdateFinancialProfile(
                        currentSavings: int.parse(currentSavingController.text),
                        debt: int.parse(totalDebtController.text),
                        financialGoals: financialGoalsController.text,
                        riskManagement: _selectedInterval ?? 'low'));
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildIntervalDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.r, bottom: 8.r),
          child: Text(
            'Income Interval',
            style: blackTextStyle.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 12.sp,
            ),
          ),
        ),
        DropdownButtonFormField<String>(
          value: _selectedInterval,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundGreyColor,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.r,
              vertical: 14.r,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24).r,
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24).r,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24).r,
              borderSide: BorderSide(
                color: textBlueColor,
                width: 1.r,
              ),
            ),
          ),
          items: _intervals.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value.toUpperCase(),
                style: blackTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              _selectedInterval = newValue;
            });
          },
          icon: Icon(
            Icons.arrow_drop_down,
            color: textPrimaryColor,
            size: 24.r,
          ),
          dropdownColor: backgroundGreyColor,
          borderRadius: BorderRadius.circular(16).r,
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
