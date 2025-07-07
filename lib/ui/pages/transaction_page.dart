import 'package:flutter/material.dart';
// flutter_bloc dan AlertDialogWidget tidak lagi diperlukan di sini jika semua handling di halaman lain
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:seimbangin_app/ui/widgets/alert_dialog_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/models/transaction_preview_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_footer_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_header_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_income_form_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_outcome_form_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_type_bar_section.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart'; // Dibutuhkan untuk class Category

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
  final TextEditingController _transactAmountController =
      TextEditingController();

  final List<Item> _outcomeItems = [];
  String? selectedCategory;
  double totalPrice = 0.0;

  // --- DATA STATIS KATEGORI ---

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
  ];

  // --- LIFECYCLE METHODS ---
  @override
  void initState() {
    super.initState();
    _addItem(); // Tambahkan satu item kosong awal untuk form Outcome
  }

  @override
  void dispose() {
    _transactNameController.dispose();
    _transactPriceController.dispose();
    _transactAmountController.dispose();
    for (var item in _outcomeItems) {
      item.dispose(); // Pastikan controller di dalam Item juga di-dispose
    }
    super.dispose();
  }

  // --- LOGIC METHODS LOKAL ---
  void _calculateTotalPrice() {
    double total = 0.0;
    if (_selectedIndexTab == 0) {
      final price = double.tryParse(_transactPriceController.text) ?? 0.0;
      final amount = double.tryParse(_transactAmountController.text) ?? 1.0;
      total = price * amount;
    } else {
      for (var item in _outcomeItems) {
        item.updateFromControllers(); // Pastikan nilai item terbaru sebelum kalkulasi
        final price = double.tryParse(item.priceController.text) ?? 0.0;
        final qty = double.tryParse(item.quantityController.text) ?? 1.0;
        total += price * qty;
      }
    }
    if (mounted) {
      setState(() {
        totalPrice = total;
      });
    }
  }

  void _addItem() {
    if (mounted) {
      setState(() {
        _outcomeItems.add(
          Item(name: '', category: '', price: '', quantity: ''),
        );
      });
      _calculateTotalPrice();
    }
  }

  void _resetForm() {
    if (mounted) {
      setState(() {
        _transactNameController.clear();
        _transactPriceController.clear();
        _transactAmountController.clear();
        selectedCategory = null;
        totalPrice = 0.0;

        for (var item in _outcomeItems) {
          item.dispose();
        }
        _outcomeItems.clear();
        _addItem();
        _selectedIndexTab = 0;
      });
    }
  }

  void _prepareAndNavigateToReview() {
    // Validasi data sebelum mengirim
    if (_selectedIndexTab == 0) {
      // Validasi Income
      final name = _transactNameController.text.trim();
      final price = _transactPriceController.text.trim();
      final amount = _transactAmountController.text.trim();

      if (name.isEmpty ||
          price.isEmpty ||
          amount.isEmpty ||
          selectedCategory == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Please complete all income fields!'),
          backgroundColor: backgroundWarningColor,
        ));
        return;
      }

      final singleItem = Item(
        name: name,
        price: price,
        quantity: amount,
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
        // Optional: Reset form jika navigasi berhasil dan pengguna kembali (jika diperlukan)
        // Atau jika TransactionStructPage mengembalikan sinyal sukses
        if (value == true) {
          // Asumsi 'true' dikembalikan jika sukses dari struct page
          _resetForm();
        }
      });
    } else {
      // Validasi Outcome
      bool isValid = true;
      if (_transactNameController.text.trim().isEmpty) {
        isValid = false;
      }
      for (final item in _outcomeItems) {
        item.updateFromControllers();
        if (item.name.isEmpty ||
            item.category.isEmpty ||
            item.price.isEmpty ||
            item.quantity.isEmpty) {
          isValid = false;
          break;
        }
      }

      if (!isValid) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text(
              'Please complete all outcome fields, including transaction name and all item details!'),
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
        if (value == true) {
          _resetForm();
        }
      });
    }
  }

  // --- BUILD METHOD ---
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
                  const TransactionHeaderSection(), // Section untuk header
                  SizedBox(height: 40.r),
                  TransactionTypeTabBarSection(
                    // Section untuk tab bar
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
                      // Section untuk form income
                      nameController: _transactNameController,
                      priceController: _transactPriceController,
                      amountController: _transactAmountController,
                      categories: incomeCategories,
                      onCategorySelected: (category) {
                        if (mounted) {
                          setState(() => selectedCategory = category);
                        }
                      },
                      onFormChanged: _calculateTotalPrice,
                    )
                  else
                    TransactionOutcomeFormSection(
                      // Section untuk form outcome
                      transactionNameController: _transactNameController,
                      items: _outcomeItems,
                      categories: outcomeCategories,
                      onAddItem: _addItem,
                      onItemChanged: _calculateTotalPrice,
                    ),
                  SizedBox(height: 40.r),
                ],
              ),
            ),
            // Footer tetap di bawah dan tidak terpengaruh keyboard
            if (MediaQuery.of(context).viewInsets.bottom == 0)
              TransactionFooterSection(
                // Section untuk footer
                totalPrice: totalPrice,
                onAddTransaction:
                    _prepareAndNavigateToReview, // Panggil method baru
              )
          ],
        ),
      ),
    );
  }
}
