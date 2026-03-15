import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/blocs/homepage/homepage_bloc.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/chart_widget.dart';

class IncomeOutcomeSection extends StatelessWidget {
  const IncomeOutcomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Text(
            'Pemasukan vs Pengeluaran',
            style: blackTextStyle.copyWith(
              fontSize: 20.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 12.h,
        ),
        BlocBuilder<HomepageBloc, HomepageState>(
          builder: (context, homepageState) {
            double totalIncome = 0;
            double totalOutcome = 0;
            if (homepageState is HomePageSuccess) {
              final profile = homepageState.user.data.financeProfile;
              totalIncome = double.tryParse(profile?.totalIncome ?? '0') ?? 0.0;
              totalOutcome =
                  double.tryParse(profile?.totalOutcome ?? '0') ?? 0.0;
            }

            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: textWhiteColor,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(20.r),
                  child: AnalyticsBarChart(
                    currentIncome: totalIncome,
                    currentOutcome: totalOutcome,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
