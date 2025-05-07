import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class CategoryOutcome {
  final String id;
  final String name;
  final IconData icon;

  CategoryOutcome({
    required this.id,
    required this.name,
    required this.icon,
  });
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

class _TransactionsPageState extends State<TransactionsPage>
    with TickerProviderStateMixin {
  TextEditingController _transactNameController = TextEditingController();
  TextEditingController _transactPriceController = TextEditingController();
  TextEditingController _transactAmountController = TextEditingController();
  final List<Item> _items = [
    Item(name: '', category: '', price: '', quantity: '')
  ];
  final List<String> mainTabTitles = ["Income", "Outcome"];
  late TabController _mainTabController;
  int selectedMainTab = 0;
  String? selectedCategory;
  double totalPrice = 0.0;

  final List<Category> categories = [
    Category(
      id: '1',
      title: 'Salary',
      icon: 'assets/ic_salary.png',
    ),
    Category(
      id: '2',
      title: 'Bonus',
      icon: 'assets/ic_bonus.png',
    ),
    Category(
      id: '3',
      title: 'Freelance',
      icon: 'assets/ic_freelance.png',
    ),
    Category(
      id: '4',
      title: 'Parents',
      icon: 'assets/ic_parents.png',
    ),
    Category(
      id: '5',
      title: 'Gift',
      icon: 'assets/ic_gift.png',
    ),
  ];

  final List<Category> outcomeCategories = [
    Category(
      id: '1',
      title: 'Salary',
      icon: 'assets/ic_salary.png',
    ),
    Category(
      id: '2',
      title: 'Bonus',
      icon: 'assets/ic_bonus.png',
    ),
    Category(
      id: '3',
      title: 'Freelance',
      icon: 'assets/ic_freelance.png',
    ),
    Category(
      id: '4',
      title: 'Parents',
      icon: 'assets/ic_parents.png',
    ),
    Category(
      id: '5',
      title: 'Gift',
      icon: 'assets/ic_gift.png',
    ),
  ];

  void _addItem() {
    setState(() {
      _items.add(Item(name: '', category: '', price: '', quantity: ''));
    });
  }

  void _calculateTotalPrice() {
    double total = 0.0;

    if (selectedMainTab == 0) {
      // For Income tab
      final price = double.tryParse(_transactPriceController.text) ?? 0.0;
      final amount = double.tryParse(_transactAmountController.text) ?? 0.0;
      total = price * amount;
    } else {
      // For Outcome tab - sum all items
      for (var item in _items) {
        final price = double.tryParse(item.price) ?? 0.0;
        final quantity = double.tryParse(item.quantity) ?? 0.0;
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
    _mainTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: BlocConsumer<TransactionBloc, TransactionState>(
        listener: (context, state) {
          if (state is TransactionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.green,
            ));
            // Reset semua field
            _transactNameController.clear();
            _transactPriceController.clear();
            _transactAmountController.clear();
            setState(() {
              selectedCategory = null;
              _items.clear();
              _items.add(Item(
                  name: '',
                  category: '',
                  price: '',
                  quantity: '')); // Tambahkan item kosong
            });
          } else if (state is TransactionFailure) {
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
                            onPressed: () {
                              routes.pop();
                            },
                            widget: Icon(
                              Icons.chevron_left,
                              size: 32,
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
                      AnalyticsTabBar(
                        tabController: _mainTabController,
                        tabTitles: mainTabTitles,
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      if (selectedMainTab == 1)
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _items.length + 1,
                          itemBuilder: (context, index) {
                            if (index < _items.length) {
                              return _buildItemContainer(index);
                            }
                            // return _buildAddButton();
                            return AddItemTransactButton(
                              title: 'Add Another Item',
                              onPressed: _addItem,
                            );
                          },
                        ),
                      if (selectedMainTab == 0) ...[
                        AddTransactionIncomeSection(
                          transactNameController: _transactNameController,
                          transactPriceController: _transactPriceController,
                          transactAmountController: _transactAmountController,
                          onChangePressed: (total) {
                            _calculateTotalPrice();
                          },
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        CategorySelector(
                          categories: categories,
                          onCategorySelected: (selectedId) {
                            print('Selected category ID: $selectedId');
                            setState(() {
                              selectedCategory = categories
                                  .firstWhere((cat) => cat.id == selectedId)
                                  .title;
                            });
                            print('Selected category: $selectedCategory');
                          },
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                      ]
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
                        if (state is TransactionLoading) ...[
                          const SizedBox(
                            height: 8,
                          ),
                          LinearProgressIndicator(
                            color: textWhiteColor,
                            backgroundColor: backgroundWhiteColor,
                          ),
                        ],
                        const SizedBox(
                          height: 36,
                        ),
                        PrimaryFilledButton(
                          title: 'Add Transaction',
                          onPressed: () {
                            if (selectedMainTab == 0) {
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
                            } else if (selectedMainTab == 1) {
                              bool isValid = true;
                              for (int i = 0; i < _items.length; i++) {
                                if (_items[i].name.isEmpty ||
                                    _items[i].category.isEmpty ||
                                    _items[i].price.isEmpty ||
                                    _items[i].quantity.isEmpty) {
                                  isValid = false;
                                  break;
                                }
                              }

                              if (!isValid || _items.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Please complete all item fields'),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }

                              context.read<TransactionBloc>().add(
                                    TransactionButtonPressed(
                                      description: 'Outcome',
                                      name: 'outcome',
                                      type: 1,
                                      items: _items,
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

  Widget _buildItemContainer(int itemIndex) {
    final TextEditingController nameController =
        TextEditingController(text: _items[itemIndex].name);
    final TextEditingController priceController =
        TextEditingController(text: _items[itemIndex].price);
    final TextEditingController quantityController =
        TextEditingController(text: _items[itemIndex].quantity);

    // Use the controllers with proper listeners
    nameController.addListener(() {
      _items[itemIndex].name = nameController.text;
    });

    priceController.addListener(() {
      _items[itemIndex].price = priceController.text;
      _calculateTotalPrice(); // Recalculate total when price changes
    });

    quantityController.addListener(() {
      _items[itemIndex].quantity = quantityController.text;
      _calculateTotalPrice(); // Recalculate total when quantity changes
    });
    return Card(
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
              controller: nameController,
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
              onChanged: (value) => _items[itemIndex].category = value ?? '',
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: priceController,
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
                      prefixText: 'Rp ',
                    ),
                    keyboardType: TextInputType.number,
                    onChanged: (value) => _items[itemIndex].price = value,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: quantityController,
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
                    onChanged: (value) => _items[itemIndex].quantity = value,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
