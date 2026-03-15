import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:seimbangin_app/models/donut_chart_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/card_widget.dart';
import 'package:seimbangin_app/ui/widgets/chart_widget.dart';

class TransactionCategorySection extends StatelessWidget {
  final TabController tabController;
  final List<String> tabTitles;
  final List<ChartSection> categoryData;
  final NumberFormat currencyFormatter;

  const TransactionCategorySection({
    super.key,
    required this.tabController,
    required this.tabTitles,
    required this.categoryData,
    required this.currencyFormatter,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Kategori Transaksi',
            style: blackTextStyle.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Jumlah transaksi berdasarkan kategori',
            style: greyTextStyle.copyWith(
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            height: 40.h,
            decoration: BoxDecoration(
              color: textWhiteColor,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: TabBar(
              controller: tabController,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: primaryColor,
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.all(4.r),
              labelColor: textWhiteColor,
              unselectedLabelColor: textPrimaryColor,
              labelStyle: whiteTextStyle.copyWith(
                  fontSize: 12.sp, fontWeight: FontWeight.bold),
              unselectedLabelStyle: blackTextStyle.copyWith(
                  fontSize: 12.sp, fontWeight: FontWeight.bold),
              tabs: tabTitles.map((title) => Tab(text: title)).toList(),
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: categoryData.isEmpty
              ? StaticNoTransaction(
                  onTap: () => print(
                    'You clicked add transaction on static no transact card!',
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: textWhiteColor,
                    borderRadius: BorderRadius.circular(24.r),
                  ),
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 16.h),
                      AnalyticsDonutChart(sections: categoryData),
                      SizedBox(height: 24.h),
                      ..._buildLegend(categoryData)
                    ],
                  ),
                ),
        ),
      ],
    );
  }

  List<Widget> _buildLegend(List<ChartSection> data) {
    return data.map((section) {
      return Padding(
        padding: EdgeInsets.only(bottom: 8.h),
        child: Row(
          children: [
            Container(
              width: 12.w,
              height: 12.h,
              color: section.color,
            ),
            SizedBox(width: 8.w),
            Text(
              section.title.substring(0, 1).toUpperCase() +
                  section.title.substring(1),
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              currencyFormatter.format(section.value),
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
