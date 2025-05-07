import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
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
                  flexibleSpace: FlexibleSpaceBar(
                    background: HeaderSection(
                      name: user.data.fullName ?? "Guest",
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
                              isAdviceExist: state.user.data.financeProfile
                                      ?.financialGoals !=
                                  null,
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
                            RecentTransactionCard(
                                onTap: () {},
                                backgroundIcon: backgroundGreenColor,
                                title: "Food",
                                subtitle: "12:00 WIB",
                                amount: "-Rp 12.000"),
                            RecentTransactionCard(
                                onTap: () {},
                                backgroundIcon: backgroundGreenColor,
                                title: "Food",
                                subtitle: "18:00 WIB",
                                amount: "-Rp 18.000"),
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
