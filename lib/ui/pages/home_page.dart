import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/ai_advisor_section.dart';
import 'package:seimbangin_app/ui/sections/income_outcome_section.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';
import 'package:seimbangin_app/ui/sections/header_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (context.read<HomepageBloc>().state is! HomePageSuccess) {
      context.read<HomepageBloc>().add(HomepageStarted());
    }

    context.read<TransactionBloc>().add(GetRecentTransactionsEvent(limit: 3));
  }

  Color getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'food':
        return backgroundGreenColor;
      case 'transport':
        return backgroundGreenColor;
      case 'shopping':
        return backgroundGreenColor;
      case 'entertainment':
        return backgroundGreenColor;
      case 'salary':
        return backgroundGreenColor;
      case 'freelance':
        return backgroundGreenColor;
      default:
        return backgroundGreyColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<HomepageBloc, HomepageState>(
      builder: (context, state) {
        if (state is HomePageSuccess) {
          final user = state.user;
          // print(user.data.financeProfile?.totalIncome);
          return Scaffold(
            backgroundColor: backgroundWhiteColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 220.r,
                  pinned: false,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: HeaderSection(
                      name: user.data.username ?? "Guest",
                      money: user.data.balance?.toString() ?? '0',
                      imageUrl: "assets/img_mascot-login.png",
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate([
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ).r,
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundWhiteColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ).r,
                        ),
                        padding: const EdgeInsets.all(24).r,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IncomeOutcomeSection(
                              incomeAmount: user
                                      .data.financeProfile?.totalIncome
                                      .toString() ??
                                  '0',
                              outcomeAmount: user
                                      .data.financeProfile?.totalOutcome
                                      .toString() ??
                                  '0',
                            ),
                            SizedBox(
                              height: 20.r,
                            ),
                            Text(
                              "AI Advisor",
                              style: blackTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp,
                              ),
                            ),
                            SizedBox(height: 10.r),
                            AiAdvisorSection(
                              financialProfileButtonOntap: () =>
                                  routes.pushNamed(RouteNames.financialProfile),
                              advice: state.advice,
                              isAdviceExist:
                                  state.user.data.financeProfile != null,
                            ),
                            SizedBox(height: 20.r),
                            Text(
                              "Recent Transactions",
                              style: blackTextStyle.copyWith(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 4.r),
                            Text(
                              "Today",
                              style: blueTextStyle.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                              ),
                            ),
                            SizedBox(height: 10.r),
                            BlocBuilder<TransactionBloc, TransactionState>(
                              builder: (context, state) {
                                if (state is TransactionLoading) {
                                  return Center(
                                    child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 20.r),
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                } else if (state is TransactionGetSuccess &&
                                    state.transaction.data.isNotEmpty) {
                                  // Urutkan transaksi berdasarkan tanggal terbaru
                                  final transactions =
                                      List.from(state.transaction.data);
                                  transactions.sort((a, b) =>
                                      DateTime.parse(b.createdAt).compareTo(
                                          DateTime.parse(a.createdAt)));

                                  return Column(
                                    children:
                                        transactions.take(5).map((transaction) {
                                      // Format waktu
                                      final createdAt =
                                          DateTime.parse(transaction.createdAt);
                                      final timeString =
                                          DateFormat('HH:mm').format(createdAt);

                                      // Format jumlah - gunakan amount dari transaksi langsung
                                      final total =
                                          int.tryParse(transaction.amount) ?? 0;

                                      // Tentukan tanda + atau - berdasarkan tipe transaksi
                                      final prefix =
                                          transaction.type == 0 ? '+' : '-';

                                      // Tentukan kategori untuk warna ikon
                                      // Jika transaksi memiliki item, gunakan kategori item pertama
                                      // Jika tidak, gunakan kategori transaksi
                                      String categoryForIcon =
                                          transaction.category;
                                      if (transaction.items.isNotEmpty) {
                                        categoryForIcon =
                                            transaction.items.first.category;
                                      }

                                      return RecentTransactionCard(
                                        onTap: () {
                                          // Navigasi ke detail transaksi jika diperlukan
                                        },
                                        backgroundIcon:
                                            getCategoryColor(categoryForIcon),
                                        // Gunakan nama transaksi, bukan nama item
                                        title: transaction.name,
                                        subtitle: "$timeString WIB",
                                        amount: "$prefix${NumberFormat.currency(
                                          locale: 'id',
                                          symbol: 'Rp ',
                                          decimalDigits: 0,
                                        ).format(total)}",
                                      );
                                    }).toList(),
                                  );
                                } else if (state is TransactionFailure) {
                                  return Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 20.r),
                                    child: Center(
                                      child: Text(
                                        "Tidak dapat memuat transaksi terbaru.",
                                        style: greyTextStyle.copyWith(
                                            fontSize: 14.sp),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Column(
                                    children: [
                                      RecentTransactionCard(
                                        onTap: () {},
                                        backgroundIcon: backgroundGreenColor,
                                        title: "Belum ada transaksi",
                                        subtitle: "Hari ini",
                                        amount: "Rp 0",
                                      ),
                                    ],
                                  );
                                }
                              },
                            ),
                            Center(
                              child: TextButton(
                                  onPressed: () => routes
                                      .pushNamed(RouteNames.historyTransact),
                                  child: Text(
                                    "See More",
                                    style: TextStyle(
                                      color: textBlueColor,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                            SizedBox(height: 80.r),
                            // TODO ARTIKEL
                            // Text(
                            //   "Seimbangin Article",
                            //   style: blackTextStyle.copyWith(
                            //       fontWeight: FontWeight.bold, fontSize: 20),
                            // ),
                            // ArticleCard(
                            //   category: "Finance Management",
                            //   title: "Student Budgeting 101:",
                            //   subtitle:
                            //       "How to Manage Your Money on a Tight Budget",
                            //   date: "12 Jan 2025",
                            //   imageUrl: "assets/img_onboarding1.png",
                            // ),
                            // ArticleCard(
                            //   category: "College & Finance",
                            //   title: "College Without Financial Stress:",
                            //   subtitle:
                            //       "How to Manage Money and Avoid Going Broke",
                            //   date: "12 Jan 2025",
                            //   imageUrl: "assets/img_onboarding2.png",
                            // ),
                            // ArticleCard(
                            //   category: "Lifestyle & Finance",
                            //   title:
                            //       "Living the Student Life Without Going Broke:",
                            //   subtitle: "Smart Spending Tips",
                            //   date: "12 Jan 2025",
                            //   imageUrl: "assets/img_onboarding3.png",
                            // ),
                            // Center(
                            //   child: TextButton(
                            //     onPressed: () {},
                            //     child: const Text(
                            //       "Read More",
                            //       style: TextStyle(
                            //           color: Colors.blue, fontSize: 16),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    )
                  ]),
                ),
                if (state is HomePageLoading)
                  SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(
                        color: primaryColor,
                        strokeWidth: 4,
                      ),
                    ),
                  )
              ],
            ),
          );
        }
        return Scaffold(
          backgroundColor: backgroundWhiteColor,
          body: Center(
            child: CircularProgressIndicator(
              color: primaryColor,
              strokeWidth: 4,
            ),
          ),
        );
      },
    );
  }
}
