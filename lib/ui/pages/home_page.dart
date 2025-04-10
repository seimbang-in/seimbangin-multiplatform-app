import 'package:flutter/material.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/ai_advisor_section.dart';
import 'package:seimbangin_app/ui/sections/income_outcome_section.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';
import 'package:seimbangin_app/ui/widgets/bottom_navigation.dart';
import 'package:seimbangin_app/ui/sections/header_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
                name: "Fawwaz Humam",
                money: "Rp 2.500.000",
                imageUrl: 'imageUrl',
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: backgroundWhiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      IncomeOutcomeSection(),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "AI Advisor",
                          style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      AiAdvisorSection(),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Recent Transaction",
                          style: blackTextStyle.copyWith(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        "Today",
                        style:
                            blueTextStyle.copyWith(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
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
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Seimbangin Article",
                          style: blackTextStyle.copyWith(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),
                      // List artikel
                      ArticleCard(
                        category: "Finance Management",
                        title: "Student Budgeting 101:",
                        subtitle: "How to Manage Your Money on a Tight Budget",
                        date: "12 Jan 2025",
                        imageUrl: "assets/img_onboarding1.png",
                      ),
                      ArticleCard(
                        category: "College & Finance",
                        title: "College Without Financial Stress:",
                        subtitle: "How to Manage Money and Avoid Going Broke",
                        date: "12 Jan 2025",
                        imageUrl: "assets/img_onboarding2.png",
                      ),
                      ArticleCard(
                        category: "Lifestyle & Finance",
                        title: "Living the Student Life Without Going Broke:",
                        subtitle: "Smart Spending Tips",
                        date: "12 Jan 2025",
                        imageUrl: "assets/img_onboarding3.png",
                      ),
                      Center(
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Read More",
                            style: TextStyle(color: Colors.blue, fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ]),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButton: Container(
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              color: buttonColor.withOpacity(0.5),
              blurRadius: 20,
              spreadRadius: 2,
              offset: Offset(0, 4)),
        ]),
        child: FloatingActionButton(
          onPressed: () {
            routes.pushNamed(RouteNames.ocr);
          },
          backgroundColor: Colors.white,
          elevation: 4,
          shape: CircleBorder(),
          child: Icon(Icons.qr_code_scanner, color: Colors.blue, size: 30),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
