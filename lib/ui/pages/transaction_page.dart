import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_footer_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_header_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_income_form_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_outcome_form_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_type_bar_section.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  int _selectedIndexTab = 0;
  final List<String> _tabs = ['Income', 'Outcome'];

  final TextEditingController _transactNameController = TextEditingController();
  final TextEditingController _transactPriceController =
      TextEditingController();

  List<TransactionItem> _outcomeItems = [];
  String? selectedCategory;
  double totalPrice = 0.0;

  final List<Category> incomeCategories = [
    Category(id: 'inc1', title: 'salary', icon: 'assets/ic_salary.png'),
    Category(id: 'inc2', title: 'freelance', icon: 'assets/ic_freelance.png'),
    Category(id: 'inc3', title: 'bonus', icon: 'assets/ic_bonus.png'),
    Category(id: 'inc4', title: 'gift', icon: 'assets/ic_gift.png'),
    Category(id: 'inc5', title: 'parent', icon: 'assets/ic_parents.png'),
  ];

  final List<Category> outcomeCategories = [
    Category(id: 'out1', title: 'food', icon: 'assets/ic_food.png'),
    Category(id: 'out2', title: 'shopping', icon: 'assets/ic_shopping.png'),
    Category(
        id: 'out3',
        title: 'transportation',
        icon: 'assets/ic_transportation.png'),
    Category(id: 'out4', title: 'internet', icon: 'assets/ic_internet.png'),
    Category(id: 'out5', title: 'housing', icon: 'assets/ic_housing.png'),
    Category(id: 'out6', title: 'health', icon: 'assets/ic_health.png'),
    Category(id: 'out7', title: 'education', icon: 'assets/ic_education.png'),
    Category(id: 'out8', title: 'others', icon: 'assets/ic_bonus.png'),
  ];

  @override
  void initState() {
    super.initState();
    _addItem();
  }

  @override
  void dispose() {
    _transactNameController.dispose();
    _transactPriceController.dispose();
    super.dispose();
  }

  void _calculateTotalPrice() {
    double total = 0.0;
    if (_selectedIndexTab == 0) {
      total = double.tryParse(_transactPriceController.text) ?? 0.0;
    } else {
      for (var item in _outcomeItems) {
        final price = double.tryParse(item.price) ?? 0.0;
        final qty = item.quantity == 0 ? 1 : item.quantity;
        total += price * qty;
      }
    }
    if (mounted) setState(() => totalPrice = total);
  }

  void _addItem() {
    setState(() {
      _outcomeItems.add(TransactionItem(quantity: 1));
    });
    _calculateTotalPrice();
  }

  void _removeItem(int index) {
    if (mounted && _outcomeItems.length > 1) {
      setState(() => _outcomeItems.removeAt(index));
      _calculateTotalPrice();
    }
  }

  void _updateItem(int index, TransactionItem updatedItem) {
    if (mounted) {
      final newItems = List<TransactionItem>.from(_outcomeItems);
      newItems[index] = updatedItem;
      setState(() => _outcomeItems = newItems);
      _calculateTotalPrice();
    }
  }

  void _resetForm() {
    if (mounted) {
      setState(() {
        _transactNameController.clear();
        _transactPriceController.clear();
        selectedCategory = null;
        totalPrice = 0.0;
        _outcomeItems.clear();
        _addItem();
        _selectedIndexTab = 0;
      });
    }
  }

  void _prepareAndNavigateToReview() {
    if (_selectedIndexTab == 0) {
      final name = _transactNameController.text.trim();
      final price = _transactPriceController.text.trim();
      if (name.isEmpty || price.isEmpty || selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Harap lengkapi semua field pemasukan!'),
          backgroundColor: backgroundWarningColor,
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
        transactionType: 0,
        totalAmount: totalPrice,
        transactionDate: DateTime.now(),
        items: [singleItem],
      );
      routes
          .pushNamed(RouteNames.transactionStruct, extra: previewData)
          .then((value) {
        if (value == true) _resetForm();
      });
    } else {
      bool isValid = true;
      if (_transactNameController.text.trim().isEmpty) isValid = false;
      for (final item in _outcomeItems) {
        if (item.itemName.isEmpty ||
            item.category.isEmpty ||
            item.price.isEmpty ||
            item.quantity == 0) {
          isValid = false;
          break;
        }
      }
      if (!isValid) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Harap lengkapi semua field pengeluaran!'),
          backgroundColor: backgroundWarningColor,
        ));
        return;
      }
      final previewData = TransactionPreviewData(
        transactionName: _transactNameController.text.trim(),
        transactionType: 1,
        totalAmount: totalPrice,
        transactionDate: DateTime.now(),
        items: _outcomeItems,
      );
      routes
          .pushNamed(RouteNames.transactionStruct, extra: previewData)
          .then((value) {
        if (value == true) _resetForm();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
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
                  if (_selectedIndexTab == 0)
                    TransactionIncomeFormSection(
                      nameController: _transactNameController,
                      priceController: _transactPriceController,
                      categories: incomeCategories,
                      onCategorySelected: (categoryTitle) {
                        if (mounted) {
                          setState(() => selectedCategory = categoryTitle);
                        }
                      },
                      onFormChanged: _calculateTotalPrice,
                    )
                  else
                    TransactionOutcomeFormSection(
                      transactionNameController: _transactNameController,
                      items: _outcomeItems,
                      categories: outcomeCategories,
                      onAddItem: _addItem,
                      onRemoveItem: _removeItem,
                      onItemUpdated: _updateItem,
                    ),
                  SizedBox(height: 40.r),
                ],
              ),
            ),
            if (MediaQuery.of(context).viewInsets.bottom == 0)
              TransactionFooterSection(
                totalPrice: totalPrice,
                onAddTransaction: _prepareAndNavigateToReview,
              )
          ],
        ),
      ),
    );
  }
}
