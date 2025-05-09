import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart';
import 'package:seimbangin_app/ui/widgets/bar_widget.dart';
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

  Item({
    required this.name,
    required this.category,
    required this.price,
    required this.quantity,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      name: json['item_name'],
      category: json['category'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_name': name,
      'category': category,
      'price': price,
      'quantity': quantity,
    };
  }
}

class ItemOutcome {
  TextEditingController nameController;
  TextEditingController priceController;
  TextEditingController qtyController;
  String category;

  ItemOutcome({
    required this.nameController,
    required this.priceController,
    required this.qtyController,
    this.category = '',
  });
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    qtyController.dispose();
  }

  factory ItemOutcome.fromJson(Map<String, dynamic> json) {
    return ItemOutcome(
      nameController: json['item_name'],
      category: json['category'],
      priceController: json['price'],
      qtyController: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'item_name': nameController,
      'category': category,
      'price': priceController,
      'quantity': qtyController,
    };
  }
}

class _TransactionsPageState extends State<TransactionsPage>
    with TickerProviderStateMixin {
  int _selectedIndexTab = 0;
  final List<String> _tabs = ['Income', 'Outcome'];
  TextEditingController _transactNameController = TextEditingController();
  TextEditingController _transactPriceController = TextEditingController();
  TextEditingController _transactAmountController = TextEditingController();

  final List<Item> _items = [
    Item(name: '', category: '', price: '', quantity: '')
  ];

  final List<ItemOutcome> _itemsOutcome = [
    ItemOutcome(
      nameController: TextEditingController(),
      priceController: TextEditingController(),
      qtyController: TextEditingController(),
    )
  ];

  final List<String> mainTabTitles = ["Income", "Outcome"];
  late TabController _mainTabController;
  int selectedMainTab = 0;
  String? selectedCategory;
  double totalPrice = 0.0;

  final List<Category> categories = [
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
      title: 'Freelance',
      icon: 'assets/ic_freelance.png',
    ),
    Category(
      id: '4',
      title: 'Parent',
      icon: 'assets/ic_parents.png',
    ),
    Category(
      id: '5',
      title: 'gift',
      icon: 'assets/ic_gift.png',
    ),
  ];

  void _addItem() {
    setState(() {
      _itemsOutcome.add(ItemOutcome(
        nameController: TextEditingController(),
        priceController: TextEditingController(),
        qtyController: TextEditingController(),
      ));

      _items.add(Item(
        name: '',
        category: '',
        price: '',
        quantity: '',
      ));
    });
  }

  void _calculateTotalPrice() {
    double total = 0.0;

    if (_selectedIndexTab == 0) {
      // For Income tab
      final price = double.tryParse(_transactPriceController.text) ?? 0.0;
      final amount = double.tryParse(_transactAmountController.text) ?? 0.0;
      total = price * amount;
    } else {
      // For Outcome tab - sum all items
      for (var item in _itemsOutcome) {
        final price = double.tryParse(item.priceController.text) ?? 0.0;
        final quantity = double.tryParse(item.qtyController.text) ?? 0.0;
        total += price * quantity;
      }
    }

    setState(() {
      totalPrice = total;
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
    super.initState();
  }

  @override
  void dispose() {
    for (var item in _itemsOutcome) {
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
              _itemsOutcome.clear();
              totalPrice = 0;
              _itemsOutcome.add(
                ItemOutcome(
                  nameController: TextEditingController(),
                  priceController: TextEditingController(),
                  qtyController: TextEditingController(),
                  category: '',
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
                              size: 32,
                              color: textSecondaryColor,
                            ),
                            backgroundColor: backgroundWhiteColor,
                          ),
                          Text(
                            'Add Transaction',
                            style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.w600,
                              fontSize: 16,
                            ),
                          ),
                          Image.asset(
                            'assets/ic_seimbangin-logo-logreg.png',
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 40,
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
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 36,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Total Price:',
                              style: whiteTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              NumberFormat.currency(
                                      locale: 'id',
                                      symbol: 'Rp ',
                                      decimalDigits: 0)
                                  .format(double.parse(totalPrice.toString())),
                              style: whiteTextStyle.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
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

                              if (name.isEmpty ||
                                  price.isEmpty ||
                                  amount.isEmpty ||
                                  category == null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please complete all income fields'),
                                    backgroundColor: Colors.red,
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

                              context.read<TransactionBloc>().add(
                                    TransactionButtonPressed(
                                      description: 'Income',
                                      name: singleItem.name,
                                      type: 0,
                                      items: [
                                        singleItem
                                      ], // 👈 hanya 1 item income
                                    ),
                                  );
                            } else if (_selectedIndexTab == 1) {
                              bool isValid = true;
                              for (int i = 0; i < _itemsOutcome.length; i++) {
                                if (_itemsOutcome[i]
                                        .nameController
                                        .text
                                        .isEmpty ||
                                    _itemsOutcome[i].category.isEmpty ||
                                    _itemsOutcome[i]
                                        .priceController
                                        .text
                                        .isEmpty ||
                                    _itemsOutcome[i]
                                        .qtyController
                                        .text
                                        .isEmpty) {
                                  isValid = false;
                                  break;
                                }
                              }

                              if (!isValid || _itemsOutcome.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'Please complete all Outcome item fields'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              context.read<TransactionBloc>().add(
                                    TransactionOutcomeButtonPressed(
                                      description: 'Outcome',
                                      name: 'outcome',
                                      type: 1,
                                      items: _itemsOutcome,
                                    ),
                                  );
                            }
                          },
                          backgroundColor: textWhiteColor,
                          textColor: primaryColor,
                        ),
                        const SizedBox(
                          height: 34,
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
          const SizedBox(
            height: 25,
          ),
          CategorySelector(
            categories: categories,
            onCategorySelected: (selectedId) {
              print('Selected category ID: $selectedId');
              setState(() {
                selectedCategory =
                    categories.firstWhere((cat) => cat.id == selectedId).title;
              });
              print('Selected category: $selectedCategory');
            },
          ),
          const SizedBox(
            height: 120,
          ),
        ],
      );
    } else if (_selectedIndexTab == 1) {
      // TAB OUTCOME
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _itemsOutcome.length + 1,
        itemBuilder: (context, index) {
          if (index < _itemsOutcome.length) {
            return _buildItemContainer(index);
          }
          return AddItemTransactButton(
            title: 'Add Another Item',
            onPressed: _addItem,
          );
        },
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
    final item = _itemsOutcome[itemIndex];

    // Setup listeners
    item.priceController.addListener(_calculateTotalPrice);
    item.qtyController.addListener(_calculateTotalPrice);
    return Card(
      color: backgroundGreyColor,
      margin: const EdgeInsets.only(bottom: 18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 19),
        child: Column(
          children: [
            Text(
              "Item ${itemIndex + 1}",
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              controller: item.nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundWhiteColor,
                hintText: 'Item Name',
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
              keyboardType: TextInputType.name,
              style: blackTextStyle.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundWhiteColor,
                hintText: 'Category',
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
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.id,
                  child: Row(
                    children: [
                      Image.asset(category.icon),
                      const SizedBox(width: 10),
                      Text(category.title),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) =>
                  _itemsOutcome[itemIndex].category = value ?? '',
            ),
            const SizedBox(height: 8),
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
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: item.qtyController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundWhiteColor,
                      hintText: 'Qty',
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
