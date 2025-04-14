import 'package:flutter/material.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class AddTransactionIncomeSection extends StatelessWidget {
  late TextEditingController transactNameController = TextEditingController();
  late TextEditingController transactPriceController = TextEditingController();
  late TextEditingController transactAmountController = TextEditingController();
  AddTransactionIncomeSection({
    super.key,
    required this.transactNameController,
    required this.transactPriceController,
    required this.transactAmountController,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: transactNameController,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundGreyColor,
            hintText: 'Transaction Name',
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: textBlueColor,
              ),
            ),
          ),
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: transactPriceController,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundGreyColor,
            hintText: 'Enter The Price',
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: textBlueColor,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        TextField(
          controller: transactAmountController,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundGreyColor,
            hintText: 'Amount',
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(
                color: textBlueColor,
              ),
            ),
          ),
          keyboardType: TextInputType.number,
          style: blackTextStyle.copyWith(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
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
  String? _selectedCategoryId;

  void _handleCategoryTap(String categoryId) {
    setState(() {
      _selectedCategoryId = categoryId;
    });
    widget.onCategorySelected?.call(categoryId);
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
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: widget.categories.map((category) {
            final isSelected = _selectedCategoryId == category.id;

            return GestureDetector(
              onTap: () => _handleCategoryTap(category.id),
              child: Column(
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.blue[50] : Colors.grey[100],
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected ? buttonColor : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                    child: Image.asset(category.icon),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    category.title,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.blue : Colors.grey[600],
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
