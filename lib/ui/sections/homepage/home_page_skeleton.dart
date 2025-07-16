import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:shimmer/shimmer.dart';

class HomePageSkeleton extends StatelessWidget {
  const HomePageSkeleton({super.key});

  Widget _buildPlaceholder(
      {double? width, required double height, double radius = 8}) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.r),
        color: Colors.grey[300],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Scaffold(
        backgroundColor: secondaryColor,
        body: CustomScrollView(
          physics: const NeverScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 220.r,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [primaryColor, secondaryColor],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 44).r,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            _buildPlaceholder(
                                height: 60.r,
                                width: 60.r,
                                radius: 25), // Avatar
                            SizedBox(width: 12.r),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildPlaceholder(width: 80.w, height: 12.h),
                                SizedBox(height: 8.h),
                                _buildPlaceholder(width: 120.w, height: 16.h),
                              ],
                            ),
                            const Spacer(),
                            _buildPlaceholder(
                                height: 30.r, width: 30.r, radius: 15),
                          ],
                        ),
                        const Spacer(),
                        _buildPlaceholder(width: 150.w, height: 14.h),
                        SizedBox(height: 12.h),
                        _buildPlaceholder(width: 200.w, height: 20.h),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  color: backgroundWhiteColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.r),
                    topRight: Radius.circular(32.r),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24).r,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.r),
                      _buildPlaceholder(
                          width: double.infinity, height: 150.h, radius: 30),
                      SizedBox(height: 20.r),
                      _buildPlaceholder(width: 120.w, height: 20.h),
                      SizedBox(height: 10.r),
                      _buildPlaceholder(
                          width: double.infinity, height: 100.h, radius: 24),
                      SizedBox(height: 20.r),
                      _buildPlaceholder(width: 200.w, height: 20.h),
                      SizedBox(height: 14.r),
                      for (int i = 0; i < 3; i++)
                        Padding(
                          padding: EdgeInsets.only(bottom: 12.h),
                          child: Row(
                            children: [
                              _buildPlaceholder(
                                  width: 60.w, height: 60.h, radius: 20),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _buildPlaceholder(
                                        width: double.infinity, height: 14.h),
                                    SizedBox(height: 8.h),
                                    _buildPlaceholder(
                                        width: 80.w, height: 12.h),
                                  ],
                                ),
                              ),
                              SizedBox(width: 12.w),
                              _buildPlaceholder(width: 100.w, height: 16.h),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
