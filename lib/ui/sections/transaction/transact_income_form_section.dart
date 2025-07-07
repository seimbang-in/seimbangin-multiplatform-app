import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart'; // Asumsi CategorySelector ada di sini

class TransactionIncomeFormSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;
  final TextEditingController amountController;
  final List<Category> categories;
  final Function(String) onCategorySelected;
  final VoidCallback onFormChanged;

  const TransactionIncomeFormSection({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.amountController,
    required this.categories,
    required this.onCategorySelected,
    required this.onFormChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddTransactionIncomeSection(
          transactNameController: nameController,
          transactPriceController: priceController,
          onChangePressed: (total) {
            onFormChanged();
          },
        ),
        SizedBox(height: 25.r),
        CategorySelector(
          categories: categories,
          onCategorySelected: onCategorySelected,
        ),
      ],
    );
  }
}
