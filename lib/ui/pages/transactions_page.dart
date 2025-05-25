import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class Item {
  String name;
  String category;
  String price;
  String quantity;

  // Controllers untuk kebutuhan UI
  TextEditingController nameController;
  TextEditingController priceController;
  TextEditingController quantityController;

  Item({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
    TextEditingController? nameController,
    TextEditingController? priceController,
    TextEditingController? quantityController,
  })  : nameController =
            nameController ?? TextEditingController(text: name),
        priceController =
            priceController ?? TextEditingController(text: price),
        quantityController =
            quantityController ?? TextEditingController(text: quantity);

  // Perbarui data dari controllers
  void updateFromControllers() {
    name = nameController.text;
    price = priceController.text;
    quantity = quantityController.text;
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['item_name'],
      category: json['category'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    // Perbarui nilai dari controllers terlebih dahulu
    updateFromControllers();

    return {
      'item_name': name,
      'category': category,
      'price': price,
      'quantity': quantity,
    };
  }

  // Fungsi untuk dispose controllers
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
  }
}

class _TransactionsPageState extends State<TransactionsPage>
    with TickerProviderStateMixin {
  int _selectedIndexTab = 0;
  final List<String> _tabs = ['Income', 'Outcome'];
  final TextEditingController _transactNameController = TextEditingController();
  final TextEditingController _transactPriceController = TextEditingController();
  final TextEditingController _transactAmountController = TextEditingController();

  final List<Item> _outcomeItems = [];

  final List<String> mainTabTitles = ["Income", "Outcome"];
  late TabController _mainTabController;
  int selectedMainTab = 0;
  String? selectedCategory;
  double totalPrice = 0.0;

  // INCOME CATEGORY LIST
  final List<Category> incomeCategories = [
    Category(
      id: '1',
      title: 'salary',
      icon: 'assets/ic_salary.png',
    ),
    Category(
      id: '2',
      title: 'bonus',
      icon: 'assets/ic_bonus.png',
    ),
    Category(
      id: '3',
      title: 'freelance',
      icon: 'assets/ic_freelance.png',
    ),
    Category(
      id: '4',
      title: 'parent',
      icon: 'assets/ic_parents.png',
    ),
    Category(
      id: '5',
      title: 'gift',
      icon: 'assets/ic_gift.png',
    ),
  ];

  final List<Category> outcomeCategories = [
    Category(
      id: '1',
      title: 'health',
      icon: 'assets/ic_health.png',
    ),
    Category(
      id: '2',
      title: 'housing',
      icon: 'assets/ic_housing.png',
    ),
    Category(
      id: '3',
      title: 'internet',
      icon: 'assets/ic_internet.png',
    ),
    Category(
      id: '4',
      title: 'education',
      icon: 'assets/ic_education.png',
    ),
    Category(
      id: '5',
      title: 'shopping',
      icon: 'assets/ic_shopping.png',
    ),
    Category(
      id: '6',
      title: 'transportation',
      icon: 'assets/ic_transportation.png',
    ),
    Category(
      id: '7',
      title: 'food',
      icon: 'assets/ic_food.png',
    ),
  ];

  void _calculateTotalPrice() {
    double total = 0.0;

    if (_selectedIndexTab == 0) {
      // For Income tab
      final price = double.tryParse(_transactPriceController.text) ?? 0.0;
      final amount = double.tryParse(_transactAmountController.text) ?? 0.0;
      total = price * amount;
    } else {
      // For Outcome tab - calculate total from all items
      for (var item in _outcomeItems) {
        final price = double.tryParse(item.priceController.text) ?? 0.0;
        final qty = double.tryParse(item.quantityController.text) ?? 0.0;
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
          nameController: TextEditingController(),
          priceController: TextEditingController(),
          quantityController: TextEditingController(),
        ),
      );
    });
  }

  @override
  void initState() {
    _mainTabController =
        TabController(length: mainTabTitles.length, vsync: this);
    _mainTabController.addListener(() {
      setState(() {
        selectedMainTab = _mainTabController.index;
      });
    });

    // Tambahkan item outcome pertama
    _outcomeItems.add(
      Item(
        name: '',
        category: '',
        price: '',
        quantity: '',
        nameController: TextEditingController(),
        priceController: TextEditingController(),
        quantityController: TextEditingController(),
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    for (var item in _outcomeItems) {
      item.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionSuccess) {
            _dismissLoadingDialog(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ));
            // Reset semua field
            _transactNameController.clear();
            _transactPriceController.clear();
            _transactAmountController.clear();
            totalPrice = 0;
            setState(() {
              selectedCategory = null;
              _outcomeItems.clear();
              totalPrice = 0;
              _outcomeItems.add(
                Item(
                  nameController: TextEditingController(),
                  priceController: TextEditingController(),
                  quantityController: TextEditingController(),
                  name: '',
                  category: '',
                  price: '',
                  quantity: '',
                ),
              ); // Tambahkan item kosong
            });
          } else if (state is TransactionLoading) {
            _showLoadingDialog(context);
          } else if (state is TransactionFailure) {
            _dismissLoadingDialog(context);
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
                      const SizedBox(
                        height: 21,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomRoundedButton(
                            onPressed: () =>
                                routes.pushReplacementNamed(RouteNames.ocr),
                            widget: Icon(
                              Icons.chevron_left,
                              size: 32.r,
                              color: textSecondaryColor,
                            ),
                            backgroundColor: backgroundWhiteColor,
                          ),
                          Text(
                            'Add Transaction',
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                            ),
                          ),
                          Image.asset(
                            'assets/ic_seimbangin-logo-logreg.png',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40.r,
                      ),
                      _buildCustomTabBar(),
                      SizedBox(
                        height: 32.r,
                      ),
                      _buildContent(),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32),
                      topRight: Radius.circular(32),
                    ).r,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 36.r,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price:',
                              style: whiteTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(
                                double.parse(
                                  totalPrice.toString(),
                                ),
                              ),
                              style: whiteTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 36,
                        ),
                        PrimaryFilledButton(
                          title: 'Add Transaction',
                          onPressed: () {
                            if (_selectedIndexTab == 0) {
                              final name = _transactNameController.text.trim();
                              final price =
                                  _transactPriceController.text.trim();
                              final amount =
                                  _transactAmountController.text.trim();
                              final category = selectedCategory;
                              print(_selectedIndexTab);

                              if (name.isEmpty ||
                                  price.isEmpty ||
                                  amount.isEmpty ||
                                  category == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please complete all income fields!'),
                                    backgroundColor: backgroundWarningColor,
                                  ),
                                );
                                return;
                              }

                              final singleItem = Item(
                                name: name,
                                price: price,
                                quantity: amount,
                                category: category,
                              );

                              print('payload : description: $name name: $name '
                                  ' type: 0 items: ${singleItem.toJson()}');

                              context.read<TransactionBloc>().add(
                                    TransactionButtonPressed(
                                      description: singleItem.name,
                                      name: singleItem.name,
                                      type: _selectedIndexTab,
                                      items: [
                                        singleItem
                                      ], // 👈 hanya 1 item income
                                    ),
                                  );
                            } else if (_selectedIndexTab == 1) {
                              bool isValid = true;
                              for (int i = 0; i < _outcomeItems.length; i++) {
                                if (_outcomeItems[i]
                                        .nameController
                                        .text
                                        .isEmpty ||
                                    _outcomeItems[i].category.isEmpty ||
                                    _outcomeItems[i]
                                        .priceController
                                        .text
                                        .isEmpty ||
                                    _outcomeItems[i]
                                        .quantityController
                                        .text
                                        .isEmpty) {
                                  isValid = false;
                                  break;
                                }
                              }

                              if (!isValid || _outcomeItems.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        'Please complete all outcome fields!'),
                                    backgroundColor: backgroundWarningColor,
                                  ),
                                );
                                return;
                              }

                              print(
                                  "description: ${_transactNameController.text}");
                              print(_selectedIndexTab);
                              context.read<TransactionBloc>().add(
                                    TransactionButtonPressed(
                                      description: _transactNameController.text,
                                      name: _transactNameController.text,
                                      type: _selectedIndexTab,
                                      items: _outcomeItems,
                                    ),
                                  );
                            }
                          },
                          backgroundColor: textWhiteColor,
                          textColor: primaryColor,
                        ),
                        SizedBox(
                          height: 34.r,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // SECTION CONTENT TRANSACTIONS
  Widget _buildContent() {
    // TAB INCOME
    if (_selectedIndexTab == 0) {
      return Column(
        children: [
          Column(
            children: [
              AddTransactionIncomeSection(
                transactNameController: _transactNameController,
                transactPriceController: _transactPriceController,
                transactAmountController: _transactAmountController,
                onChangePressed: (total) {
                  _calculateTotalPrice();
                },
              ),
            ],
          ),
          SizedBox(
            height: 25.r,
          ),
          CategorySelector(
            categories: incomeCategories,
            onCategorySelected: (selectedId) {
              print('Selected category ID: $selectedId');
              setState(() {
                selectedCategory = incomeCategories
                    .firstWhere((cat) => cat.id == selectedId)
                    .title;
              });
              print('Selected category: $selectedCategory');
            },
          ),
          SizedBox(
            height: 120.r,
          ),
        ],
      );
    } else if (_selectedIndexTab == 1) {
      // TAB OUTCOME
      return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            TextField(
              controller: _transactNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundGreyColor,
                hintText: 'Transaction Name',
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
              height: 20.r,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _outcomeItems.length + 1,
              itemBuilder: (context, index) {
                if (index < _outcomeItems.length) {
                  return _buildItemContainer(index);
                }
                return AddItemTransactButton(
                  title: 'Add Another Item',
                  onPressed: _addItem,
                );
              },
            ),
          ],
        ),
      );
    }
    return Center(
      child: Text('invalid tab'),
    );
  }

  Widget _buildCustomTabBar() {
    return Container(
      decoration: BoxDecoration(
        color: backgroundGreyColor,
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(_tabs.length, (index) {
          final isSelected = _selectedIndexTab == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndexTab = index),
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
                    _tabs[index],
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

  Widget _buildItemContainer(int itemIndex) {
    final item = _outcomeItems[itemIndex];

    // Setup listeners
    item.priceController.addListener(_calculateTotalPrice);
    item.quantityController.addListener(_calculateTotalPrice);
    return Card(
      color: backgroundGreyColor,
      margin: const EdgeInsets.only(bottom: 18).r,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 19).r,
        child: Column(
          children: [
            Text(
              "Item ${itemIndex + 1}",
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(
              height: 20.r,
            ),
            TextField(
              controller: item.nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundWhiteColor,
                hintText: 'Item Name',
                hintStyle: greyTextStyle.copyWith(
                  fontSize: 14.sp,
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
              keyboardType: TextInputType.name,
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.r),
            DropdownButtonFormField<String>(
              dropdownColor: backgroundWhiteColor,
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundWhiteColor,
                hintText: 'Category',
                hintStyle: greyTextStyle.copyWith(
                  fontSize: 14.sp,
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
              items: outcomeCategories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.id,
                  child: Row(
                    children: [
                      Image.asset(category.icon),
                      SizedBox(width: 10.r),
                      Text(
                        category.title,
                        style: blackTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) =>
                  _outcomeItems[itemIndex].category = value ?? '',
            ),
            SizedBox(height: 8.r),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: item.priceController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundWhiteColor,
                      hintText: 'Price',
                      hintStyle: greyTextStyle.copyWith(
                        fontSize: 14.sp,
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
                  ),
                ),
                SizedBox(width: 8.r),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: item.quantityController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundWhiteColor,
                      hintText: 'Qty',
                      hintStyle: greyTextStyle.copyWith(
                        fontSize: 14.sp,
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // DIALOG LOADING
  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        // backgroundColor: backgroundWhiteColor,
        contentPadding: const EdgeInsets.all(24).r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24).r,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: primaryColor,
              strokeWidth: 4,
            ),
            SizedBox(height: 16.h),
            Text(
              'Saving Transaction...',
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _dismissLoadingDialog(BuildContext context) {
    if (Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }
}
