import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class TransactionTypeTabBarSection extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTabSelected;
  final List<String> tabs;

  const TransactionTypeTabBarSection({
    super.key,
    required this.selectedIndex,
    required this.onTabSelected,
    required this.tabs,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundGreyColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Container(
                margin: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: isSelected
                      ? (index == 0 ? buttonColor : backgroundWarningColor)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.r),
                child: Center(
                  child: Text(
                    tabs[index],
                    style: blackTextStyle.copyWith(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? textWhiteColor : textSecondaryColor,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
