import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart'; // Asumsi CategorySelector ada di sini

class TransactionIncomeFormSection extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController priceController;

  final List<Map<String, dynamic>> categories;
  final Function(String) onCategorySelected;
  final VoidCallback onFormChanged;
  final String amountTitle;

  const TransactionIncomeFormSection({
    super.key,
    required this.nameController,
    required this.priceController,
    required this.categories,
    required this.onCategorySelected,
    required this.onFormChanged,
    this.amountTitle = 'Jumlah Transaksi',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AddTransactionIncomeSection(
          transactNameController: nameController,
          transactPriceController: priceController,
          amountTitle: amountTitle,
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
