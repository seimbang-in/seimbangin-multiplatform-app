import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class AddTransactionIncomeSection extends StatelessWidget {
  final TextEditingController transactNameController;
  final TextEditingController transactPriceController;
  final ValueChanged onChangePressed;

  final String amountTitle;

  const AddTransactionIncomeSection({
    super.key,
    required this.transactNameController,
    required this.transactPriceController,
    required this.onChangePressed,
    this.amountTitle = "Jumlah Transaksi",
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.r),
        Text(
          amountTitle,
          style: greyTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8.r),
        TextField(
          controller: transactPriceController,
          onChanged: onChangePressed,
          textAlign: TextAlign.center,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: '0',
            hintStyle: greyTextStyle.copyWith(
              fontSize: 48.sp,
              fontWeight: FontWeight.bold,
            ),
            prefixText: 'Rp ',
            prefixStyle: blackTextStyle.copyWith(
              fontSize: 24.sp, 
              fontWeight: FontWeight.bold,
              color: primaryColor,
            ),
          ),
          keyboardType: TextInputType.number,
          style: blackTextStyle.copyWith(
            fontSize: 48.sp,
            fontWeight: FontWeight.bold,
            color: primaryColor,
          ),
        ),
        SizedBox(height: 24.r),
        TextField(
          controller: transactNameController,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundGreyColor,
            hintText: 'Nama Transaksi / Catatan',
            hintStyle: greyTextStyle.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24).r,
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24).r,
              borderSide: BorderSide(
                color: primaryColor,
              ),
            ),
            prefixIcon: Icon(Icons.edit_note_rounded, color: textSecondaryColor),
          ),
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 16.r),
      ],
    );
  }
}

// Model untuk kategori
class Category {
  final String id;
  final String title;
  final String icon;

  Category({
    required this.id,
    required this.title,
    required this.icon,
  });
}

class CategorySelector extends StatefulWidget {
  final List<Category> categories;
  final Function(String)? onCategorySelected;
  final Color activeColor;

  const CategorySelector({
    super.key,
    required this.categories,
    this.onCategorySelected,
    this.activeColor = const Color(0xffE91E63),
  });

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  String? _selectedCategoryTitle;

  void _handleCategoryTap(String categoryTitle) {
    setState(() {
      _selectedCategoryTitle = categoryTitle;
    });
    widget.onCategorySelected?.call(categoryTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Item Category',
          style: blackTextStyle.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
        ),
        SizedBox(height: 16.r),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: widget.categories.map((category) {
              final isSelected = _selectedCategoryTitle == category.title;
              return GestureDetector(
                onTap: () => _handleCategoryTap(category.title),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(right: 12.r),
                  width: 155.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    color: isSelected ? widget.activeColor : backgroundWhiteColor,
                    borderRadius: BorderRadius.circular(16).r,
                    border: Border.all(
                      color: isSelected ? Colors.transparent : backgroundGreyColor,
                      width: 1.5.r,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: widget.activeColor.withOpacity(0.35),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            )
                          ]
                        : [],
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.r),
                        child: Row(
                          children: [
                            // Icon container mapping specifically looking like the design
                            Container(
                              width: 44.w,
                              height: 44.h,
                              padding: EdgeInsets.all(10.r),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.black.withOpacity(0.15)
                                    : backgroundGreyColor,
                                borderRadius: BorderRadius.circular(12).r,
                              ),
                              child: Image.asset(
                                category.icon,
                                color: isSelected ? Colors.white : textSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 10.w),
                            // Title Text layout matching
                            Expanded(
                              child: Text(
                                category.title.replaceAll(' ', '\n').replaceFirst(
                                    RegExp(r'^[a-z]'),
                                    category.title[0].toUpperCase()),
                                style: TextStyle(
                                  fontSize: 13.sp,
                                  height: 1.2,
                                  fontWeight: FontWeight.w600,
                                  color: isSelected ? Colors.white : textSecondaryColor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Top Right Dashed-Like Circle for active state
                      if (isSelected)
                        Positioned(
                          top: 10.r,
                          right: 10.r,
                          child: Container(
                            width: 16.w,
                            height: 16.h,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 1.2,
                                style: BorderStyle.none,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.center,
                               child: CustomPaint(
                                 painter: DashedCirclePainter(color: Colors.white),
                                 child: const SizedBox.expand(),
                               )
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class DashedCirclePainter extends CustomPainter {
  final Color color;

  DashedCirclePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final double radius = size.width / 2;
    const double dashLength = 3;
    const double gapLength = 3;
    final double perimeter = 2 * 3.141592653589793 * radius;
    
    double startAngle = 0;
    while (startAngle < 2 * 3.141592653589793) {
      final double sweepAngle = (dashLength / perimeter) * 2 * 3.141592653589793;
      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
      startAngle += sweepAngle + ((gapLength / perimeter) * 2 * 3.141592653589793);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
