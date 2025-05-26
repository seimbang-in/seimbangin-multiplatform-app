import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_footer_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_header_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_income_form_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_outcome_form_section.dart';
import 'package:seimbangin_app/ui/sections/transaction/transact_type_bar_section.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart'; // Dibutuhkan untuk class Category
import 'package:seimbangin_app/ui/widgets/alert_dialog_widget.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  // --- STATE MANAGEMENT ---
  // Semua state dan controller tetap berada di halaman utama ini.
  int _selectedIndexTab = 0;
  final List<String> _tabs = ['Income', 'Outcome'];

  // Controllers untuk tab Income & nama transaksi Outcome
  final TextEditingController _transactNameController = TextEditingController();
  final TextEditingController _transactPriceController =
      TextEditingController();
  final TextEditingController _transactAmountController =
      TextEditingController();

  // List dinamis untuk item-item di tab Outcome
  final List<Item> _outcomeItems = [];

  // State untuk kategori dan total harga
  String? selectedCategory;
  double totalPrice = 0.0;

  // --- DATA STATIS ---
  // (Anda bisa memindahkan ini ke file constants jika diinginkan)
  final List<Category> incomeCategories = [
    Category(id: '1', title: 'salary', icon: 'assets/ic_salary.png'),
    Category(id: '2', title: 'bonus', icon: 'assets/ic_bonus.png'),
    Category(id: '3', title: 'freelance', icon: 'assets/ic_freelance.png'),
    Category(id: '4', title: 'parent', icon: 'assets/ic_parents.png'),
    Category(id: '5', title: 'gift', icon: 'assets/ic_gift.png'),
  ];

  final List<Category> outcomeCategories = [
    Category(id: '1', title: 'health', icon: 'assets/ic_health.png'),
    Category(id: '2', title: 'housing', icon: 'assets/ic_housing.png'),
    Category(id: '3', title: 'internet', icon: 'assets/ic_internet.png'),
    Category(id: '4', title: 'education', icon: 'assets/ic_education.png'),
    Category(id: '5', title: 'shopping', icon: 'assets/ic_shopping.png'),
    Category(
        id: '6', title: 'transportation', icon: 'assets/ic_transportation.png'),
    Category(id: '7', title: 'food', icon: 'assets/ic_food.png'),
  ];

  // --- LIFECYCLE & LOGIC METHODS ---
  @override
  void initState() {
    super.initState();
    // Tambahkan satu item kosong pertama kali untuk form Outcome
    _addItem();
  }

  @override
  void dispose() {
    _transactNameController.dispose();
    _transactPriceController.dispose();
    _transactAmountController.dispose();
    for (var item in _outcomeItems) {
      item.dispose();
    }
    super.dispose();
  }

  void _calculateTotalPrice() {
    double total = 0.0;
    if (_selectedIndexTab == 0) {
      // Kalkulasi untuk tab Income
      final price = double.tryParse(_transactPriceController.text) ?? 0.0;
      final amount = double.tryParse(_transactAmountController.text) ??
          1.0; // Anggap 1 jika kosong
      total = price * amount;
    } else {
      // Kalkulasi untuk tab Outcome
      for (var item in _outcomeItems) {
        final price = double.tryParse(item.priceController.text) ?? 0.0;
        final qty = double.tryParse(item.quantityController.text) ??
            1.0; // Anggap 1 jika kosong
        total += price * qty;
      }
    }
    setState(() {
      totalPrice = total;
    });
  }

  void _addItem() {
    setState(() {
      _outcomeItems.add(
        Item(
          name: '',
          category: '',
          price: '',
          quantity: '',
        ),
      );
    });
  }

  void _handleSuccessState() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Transaction added successfully!"),
      backgroundColor: Colors.green,
    ));

    // Reset semua field ke kondisi awal
    setState(() {
      _transactNameController.clear();
      _transactPriceController.clear();
      _transactAmountController.clear();
      selectedCategory = null;
      totalPrice = 0;
      for (var item in _outcomeItems) {
        item.dispose();
      }
      _outcomeItems.clear();
      _addItem(); // Tambahkan lagi satu item kosong untuk form outcome
    });
  }

  void _submitTransaction() {
    if (_selectedIndexTab == 0) {
      // Logic untuk submit Income
      final name = _transactNameController.text.trim();
      final price = _transactPriceController.text.trim();
      final amount = _transactAmountController.text.trim();
      final category = selectedCategory;

      if (name.isEmpty || price.isEmpty || amount.isEmpty || category == null) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Please complete all income fields!'),
          backgroundColor: backgroundWarningColor,
        ));
        return;
      }

      final singleItem =
          Item(name: name, price: price, quantity: amount, category: category);
      context.read<TransactionBloc>().add(TransactionButtonPressed(
            description: singleItem.name,
            name: singleItem.name,
            type: 0,
            items: [singleItem],
          ));
    } else {
      // Logic untuk submit Outcome
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

      context.read<TransactionBloc>().add(TransactionButtonPressed(
            description: _transactNameController.text.trim(),
            name: _transactNameController.text.trim(),
            type: 1,
            items: _outcomeItems,
          ));
    }
  }

  // --- BUILD METHOD ---
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionLoading) {
            AlertDialogWidget.showLoading(context,
                message: 'Saving Transaction...');
          } else if (state is TransactionSuccess) {
            AlertDialogWidget.dismiss(context);
            _handleSuccessState();
          } else if (state is TransactionFailure) {
            AlertDialogWidget.dismiss(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ));
          }
        },
        builder: (context, state) {
          return SafeArea(
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
                          setState(() {
                            _selectedIndexTab = index;
                            _calculateTotalPrice(); // Hitung ulang total saat tab berganti
                          });
                        },
                      ),
                      SizedBox(height: 32.r),
                      // KONTEN DINAMIS BERDASARKAN TAB
                      if (_selectedIndexTab == 0)
                        TransactionIncomeFormSection(
                          nameController: _transactNameController,
                          priceController: _transactPriceController,
                          amountController: _transactAmountController,
                          categories: incomeCategories,
                          onCategorySelected: (category) {
                            setState(() => selectedCategory = category);
                          },
                          onFormChanged: _calculateTotalPrice,
                        )
                      else
                        TransactionOutcomeFormSection(
                          transactionNameController: _transactNameController,
                          items: _outcomeItems,
                          categories: outcomeCategories,
                          onAddItem: _addItem,
                          onItemChanged: _calculateTotalPrice,
                        ),
                      SizedBox(height: 40.r), // Spasi agar tidak mentok footer
                    ],
                  ),
                ),
                // FOOTER TETAP DI BAWAH
                if (MediaQuery.of(context).viewInsets.bottom ==
                    0) // Sembunyikan footer saat keyboard muncul
                  TransactionFooterSection(
                    totalPrice: totalPrice,
                    onAddTransaction: _submitTransaction,
                  )
              ],
            ),
          );
        },
      ),
    );
  }
}
