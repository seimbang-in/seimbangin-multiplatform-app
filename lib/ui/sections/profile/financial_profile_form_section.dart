import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class FinancialProfileFormSection extends StatelessWidget {
  final TextEditingController financialGoalsController;
  final TextEditingController currentSavingController;
  final TextEditingController totalDebtController;
  final String? selectedInterval;
  final List<String> intervals;
  final ValueChanged<String?> onIntervalChanged;
  final void Function(String, TextEditingController) onCurrencyChanged;

  const FinancialProfileFormSection({
    super.key,
    required this.financialGoalsController,
    required this.currentSavingController,
    required this.totalDebtController,
    required this.selectedInterval,
    required this.intervals,
    required this.onIntervalChanged,
    required this.onCurrencyChanged,
  });

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Text(
        text,
        style: blackTextStyle.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hintText) {
    return InputDecoration(
      filled: true,
      fillColor: backgroundGreySecondaryColor,
      hintText: hintText,
      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      hintStyle: greyTextStyle.copyWith(
        fontSize: 14.sp,
        fontWeight: FontWeight.normal,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: Colors.grey.withOpacity(0.2), width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16.r),
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel("Profil Risiko (Risk Management)"),
        DropdownButtonFormField<String>(
          initialValue: selectedInterval,
          decoration: _buildInputDecoration('Pilih profil risiko...'),
          items: intervals.map((String value) {
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
          onChanged: onIntervalChanged,
          icon: Icon(Icons.keyboard_arrow_down_rounded,
              color: textPrimaryColor, size: 28.r),
          dropdownColor: backgroundWhiteColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        SizedBox(height: 20.h),
        _buildLabel("Tujuan Keuangan (Financial Goals)"),
        TextField(
          controller: financialGoalsController,
          decoration: _buildInputDecoration('Contoh: Beli rumah, Liburan'),
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 20.h),
        _buildLabel("Tabungan Saat Ini (Current Saving)"),
        TextField(
          controller: currentSavingController,
          decoration: _buildInputDecoration('Contoh: Rp 5.000.000'),
          onChanged: (value) => onCurrencyChanged(value, currentSavingController),
          keyboardType: TextInputType.number,
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          textInputAction: TextInputAction.next,
        ),
        SizedBox(height: 20.h),
        _buildLabel("Total Hutang (Total Debt)"),
        TextField(
          controller: totalDebtController,
          decoration: _buildInputDecoration('Contoh: Rp 1.000.000'),
          onChanged: (value) => onCurrencyChanged(value, totalDebtController),
          keyboardType: TextInputType.number,
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
          textInputAction: TextInputAction.done,
        ),
      ],
    );
  }
}
