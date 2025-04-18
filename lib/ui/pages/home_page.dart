import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/ai_advisor_section.dart';
import 'package:seimbangin_app/ui/sections/income_outcome_section.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';
import 'package:seimbangin_app/ui/widgets/bottom_navigation.dart';
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
                  expandedHeight: 250,
                  pinned: false,
                  floating: false,
                  flexibleSpace: FlexibleSpaceBar(
                    background: HeaderSection(
                      name: user.data.fullName,
                      money: user.data.balance,
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
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: backgroundWhiteColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            IncomeOutcomeSection(
                              amount: user.data.balance,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "AI Advisor",
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(height: 10),
                            AiAdvisorSection(
                              advice: state.advice,
                              isAdviceExist: true,
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Recent Transaction",
                              style: blackTextStyle.copyWith(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Today",
                              style: blueTextStyle.copyWith(
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            RecentTransactionCard(
                                backgroundIcon: backgroundGreenColor,
                                title: "food",
                                subtitle: "12:00 WIB",
                                amount: "-Rp 12.000"),
                            RecentTransactionCard(
                                backgroundIcon: backgroundGreenColor,
                                title: "food",
                                subtitle: "18:00 WIB",
                                amount: "-Rp 18.000"),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "See More",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              "Seimbangin Article",
                              style: blackTextStyle.copyWith(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            ArticleCard(
                              category: "Finance Management",
                              title: "Student Budgeting 101:",
                              subtitle:
                                  "How to Manage Your Money on a Tight Budget",
                              date: "12 Jan 2025",
                              imageUrl: "assets/img_onboarding1.png",
                            ),
                            ArticleCard(
                              category: "College & Finance",
                              title: "College Without Financial Stress:",
                              subtitle:
                                  "How to Manage Money and Avoid Going Broke",
                              date: "12 Jan 2025",
                              imageUrl: "assets/img_onboarding2.png",
                            ),
                            ArticleCard(
                              category: "Lifestyle & Finance",
                              title:
                                  "Living the Student Life Without Going Broke:",
                              subtitle: "Smart Spending Tips",
                              date: "12 Jan 2025",
                              imageUrl: "assets/img_onboarding3.png",
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {},
                                child: const Text(
                                  "Read More",
                                  style: TextStyle(
                                      color: Colors.blue, fontSize: 16),
                                ),
                              ),
                            ),
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
            bottomNavigationBar: const CustomBottomNavigationBar(),
            floatingActionButton: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    color: buttonColor.withOpacity(0.5),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, 4)),
              ]),
              child: FloatingActionButton(
                  onPressed: () {
                    routes.pushNamed(RouteNames.ocr);
                  },
                  backgroundColor: Colors.white,
                  elevation: 4,
                  shape: const CircleBorder(),
                  child: Image.asset(
                    'assets/icon-scan.png',
                    width: 24,
                    height: 24,
                  )),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
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
