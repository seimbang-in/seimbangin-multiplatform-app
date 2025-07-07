import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class AddTransactionIncomeSection extends StatelessWidget {
  late TextEditingController transactNameController = TextEditingController();
  late TextEditingController transactPriceController = TextEditingController();

  final ValueChanged onChangePressed;
  AddTransactionIncomeSection(
      {super.key,
      required this.transactNameController,
      required this.transactPriceController,
      required this.onChangePressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: transactNameController,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundGreyColor,
            hintText: 'Name',
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14.sp,
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
          ),
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 16.r,
        ),
        TextField(
          controller: transactPriceController,
          onChanged: onChangePressed,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundGreyColor,
            hintText: 'Amount',
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14.sp,
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
          ),
          keyboardType: TextInputType.number,
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 16.r,
        ),
      ],
    );
  }
}

// Model untuk kategori
class Category {
  final String id;
  final String title;
  final String icon;

  Category({
    required this.id,
    required this.title,
    required this.icon,
  });
}

// Category Selector Widget
class CategorySelector extends StatefulWidget {
  final List<Category> categories;
  final Function(String)? onCategorySelected;

  const CategorySelector({
    super.key,
    required this.categories,
    this.onCategorySelected,
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String? _selectedCategoryTitle;

  void _handleCategoryTap(String categoryTitle) {
    setState(() {
      _selectedCategoryTitle = categoryTitle;
    });
    widget.onCategorySelected?.call(categoryTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Category',
          style: blackTextStyle.copyWith(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
          ),
        ),
        SizedBox(
          height: 16.r,
        ),
        Wrap(
          spacing: 12.r,
          runSpacing: 12.r,
          children: widget.categories.map((category) {
            final isSelected = _selectedCategoryTitle == category.title;

            return GestureDetector(
              onTap: () => _handleCategoryTap(category.title),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? buttonColor : backgroundGreyColor,
                      borderRadius: BorderRadius.circular(24).r,
                      border: Border.all(
                        color: isSelected ? buttonColor : Colors.transparent,
                        width: 1.5.r,
                      ),
                    ),
                    child: Image.asset(category.icon),
                  ),
                  SizedBox(
                    height: 8.r,
                  ),
                  Text(
                    category.title,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? buttonColor : textSecondaryColor,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
