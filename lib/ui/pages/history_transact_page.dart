import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';

class HistoryTransactPage extends StatefulWidget {
  const HistoryTransactPage({super.key});

  @override
  State<HistoryTransactPage> createState() => _HistoryTransactPageState();
}

class _HistoryTransactPageState extends State<HistoryTransactPage> {
  int _selectedIndex = 0;
  final List<String> _tabs = ['All', 'Week', '1 Month', '6 Month'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundWhiteColor,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          children: [
            SizedBox(
              height: 21.r,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomRoundedButton(
                  onPressed: () {
                    routes.replaceNamed(RouteNames.main);
                  },
                  widget: Icon(
                    Icons.chevron_left,
                    size: 32.r,
                  ),
                  backgroundColor: backgroundWhiteColor,
                ),
                Text(
                  'History Transaction',
                  style: blackTextStyle.copyWith(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/ic_seimbangin-logo-logreg.png',
                ),
              ],
            ),
            SizedBox(height: 32.r),
            _buildCustomTabBar(),
            SizedBox(
              height: 20.r,
            ),
            // RecentTransactionCard(
            //   backgroundColor: backgroundGreenColor,
            //   title: "Food",
            //   subtitle: "12:00 WIB",
            //   amount: "-Rp 12.000",
            // ),
            // RecentTransactionCard(
            //   backgroundIcon: backgroundGreenColor,
            //   title: "Food",
            //   subtitle: "18:00 WIB",
            //   amount: "-Rp 18.000",
            // ),
          ],
        ),
      ),
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
          final isSelected = _selectedIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedIndex = index),
              child: Container(
                margin: EdgeInsets.all(4.r),
                decoration: BoxDecoration(
                  color: isSelected ? buttonColor : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                padding: EdgeInsets.symmetric(vertical: 14.r),
                child: Center(
                  child: Text(
                    _tabs[index],
                    style: blackTextStyle.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
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
}
