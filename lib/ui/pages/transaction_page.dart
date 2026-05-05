import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/services/local_database_service.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_footer_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_header_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_income_form_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_type_bar_section.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  int _selectedIndexTab = 0;
  final List<String> _tabs = ['Pemasukan', 'Pengeluaran'];

  final TextEditingController _transactNameController = TextEditingController();
  final TextEditingController _transactPriceController =
      TextEditingController();

  final LocalDatabaseService _dbService = LocalDatabaseService();

  List<Map<String, dynamic>> incomeCategories = [];
  List<Map<String, dynamic>> outcomeCategories = [];
  bool isLoading = true;

  String? selectedCategory;
  double totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final categories = await _dbService.getAllCategories();
    if (mounted) {
      setState(() {
        incomeCategories = categories.where((c) => c['type'] == 'income').toList();
        outcomeCategories = categories.where((c) => c['type'] == 'outcome').toList();
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _transactNameController.dispose();
    _transactPriceController.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    double total = double.tryParse(_transactPriceController.text) ?? 0.0;
    if (mounted) setState(() => totalPrice = total);
  }

  void _resetForm() {
    if (mounted) {
      setState(() {
        _transactNameController.clear();
        _transactPriceController.clear();
        selectedCategory = null;
        totalPrice = 0.0;
        _selectedIndexTab = 0;
      });
    }
  }

  void _prepareAndNavigateToReview() {
    final name = _transactNameController.text.trim();
    final price = _transactPriceController.text.trim();
    if (name.isEmpty || price.isEmpty || selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: const Text('Harap lengkapi semua field!'),
        backgroundColor: context.color.backgroundWarningColor,
      ));
      return;
    }
    final singleItem = TransactionItem(
      itemName: name,
      price: price,
      quantity: 1,
      category: selectedCategory!,
    );
    final previewData = TransactionPreviewData(
      transactionName: name,
      transactionType: _selectedIndexTab, // 0 For Pemasukan, 1 for Pengeluaran
      totalAmount: totalPrice,
      transactionDate: DateTime.now(),
      items: [singleItem],
    );
    routes
        .pushNamed(RouteNames.transactionStruct, extra: previewData)
        .then((value) {
      if (value == true) _resetForm();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.color.backgroundWhiteColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  SizedBox(height: 21.h),
                  const TransactionHeaderSection(),
                  SizedBox(height: 40.r),
                  TransactionTypeTabBarSection(
                    selectedIndex: _selectedIndexTab,
                    tabs: _tabs,
                    onTabSelected: (index) {
                      if (mounted) {
                        setState(() {
                          _selectedIndexTab = index;
                          _transactNameController.clear();
                          _calculateTotalPrice();
                        });
                      }
                    },
                  ),
                  SizedBox(height: 32.r),
                  if (isLoading)
                    const Center(child: CircularProgressIndicator())
                  else
                    TransactionIncomeFormSection(
                      nameController: _transactNameController,
                      priceController: _transactPriceController,
                      amountTitle: _selectedIndexTab == 0 ? 'Jumlah Pemasukan' : 'Jumlah Pengeluaran',
                      categories: _selectedIndexTab == 0 ? incomeCategories : outcomeCategories,
                      onCategorySelected: (categoryTitle) {
                        if (mounted) {
                          setState(() => selectedCategory = categoryTitle);
                        }
                      },
                      onFormChanged: _calculateTotalPrice,
                    ),
                  SizedBox(height: 40.r),
                ],
              ),
            ),
            if (MediaQuery.of(context).viewInsets.bottom == 0)
              TransactionFooterSection(
                totalPrice: totalPrice,
                isIncome: _selectedIndexTab == 0,
                onAddTransaction: _prepareAndNavigateToReview,
              )
          ],
        ),
      ),
    );
  }
}
