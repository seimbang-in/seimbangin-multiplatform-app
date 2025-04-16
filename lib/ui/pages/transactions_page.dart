import 'package:flutter/material.dart';
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
      body: SafeArea(
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
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CategorySelector(
                      categories: categories,
                      onCategorySelected: (selectedId) {
                        print('Selected category ID: $selectedId');
                        // Handle selected category
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
                          'Rp 0',
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
                      onPressed: () {},
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
      ),
    );
  }

  Widget _buildItemContainer(int itemIndex) {
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
              // controller: transactPriceController,
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
