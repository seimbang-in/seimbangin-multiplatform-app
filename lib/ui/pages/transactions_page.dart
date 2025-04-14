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

class _TransactionsPageState extends State<TransactionsPage>
    with TickerProviderStateMixin {
  TextEditingController _transactNameController = TextEditingController();
  TextEditingController _transactPriceController = TextEditingController();
  TextEditingController _transactAmountController = TextEditingController();
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

  @override
  void initState() {
    _mainTabController =
        TabController(length: mainTabTitles.length, vsync: this);
    _mainTabController.addListener(() {
      if (!_mainTabController.indexIsChanging) {
        setState(() {
          selectedMainTab = _mainTabController.index;
        });
      }
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
}
