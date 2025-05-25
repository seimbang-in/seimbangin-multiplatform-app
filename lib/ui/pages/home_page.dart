import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/blocs/transaction/transaction_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/ai_advisor_section.dart';
import 'package:seimbangin_app/ui/sections/homepage/home_recent_transact_section.dart';
import 'package:seimbangin_app/ui/sections/income_outcome_section.dart';
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
          return Scaffold(
            backgroundColor: backgroundWhiteColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 220.r,
                  pinned: false,
                  floating: false,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background: HeaderSection(
                      name: user.data.username ?? "Guest",
                      money: user.data.balance?.toString() ?? '0',
                      imageUrl: "assets/img_mascot-login.png",
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    decoration: BoxDecoration(
                      color: backgroundWhiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.r),
                        topRight: Radius.circular(30.r),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24).r,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.r),
                          // SECTION 1: INCOME & OUTCOME
                          IncomeOutcomeSection(
                            incomeAmount: user.data.financeProfile?.totalIncome
                                    .toString() ??
                                '0',
                            outcomeAmount: user
                                    .data.financeProfile?.totalOutcome
                                    .toString() ??
                                '0',
                          ),
                          SizedBox(height: 20.r),
                          // SECTION 2: AI ADVISOR
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
                          // SECTION 3: RECENT TRANSACTIONS
                          HomeRecentTransactionsSection(
                            getCategoryColorCallback: getCategoryColor,
                          ),
                          SizedBox(height: 100.r),
                          // Bagian Artikel (bisa jadi section selanjutnya)
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
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
