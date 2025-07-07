import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionOutcomeFormSection extends StatelessWidget {
  final TextEditingController transactionNameController;
  final List<Item> items;
  final List<Category> categories;
  final VoidCallback onAddItem;
  final VoidCallback onItemChanged;

  final Function(int) onRemoveItem;

  const TransactionOutcomeFormSection({
    super.key,
    required this.transactionNameController,
    required this.items,
    required this.categories,
    required this.onAddItem,
    required this.onItemChanged,
    required this.onRemoveItem,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: transactionNameController,
          decoration: InputDecoration(
            filled: true,
            fillColor: backgroundGreyColor,
            hintText: 'Name',
            hintStyle: greyTextStyle.copyWith(
                fontSize: 14.sp, fontWeight: FontWeight.w500),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24).r,
                borderSide: BorderSide(color: textBlueColor)),
          ),
          style: blackTextStyle.copyWith(
              fontSize: 14.sp, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 20.r),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildItemContainer(context, index);
          },
        ),
        SizedBox(height: 16.r),
        AddItemTransactButton(
          title: 'Add Another Item',
          onPressed: onAddItem,
        ),
      ],
    );
  }

  Widget _buildItemContainer(BuildContext context, int itemIndex) {
    final item = items[itemIndex];

    item.priceController.addListener(onItemChanged);
    item.quantityController.addListener(onItemChanged);

    return Card(
      color: backgroundGreyColor,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 18).r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- PERUBAHAN: HEADER ITEM DENGAN TOMBOL HAPUS ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Item ${itemIndex + 1}",
                  style: blackTextStyle.copyWith(
                      fontWeight: FontWeight.bold, fontSize: 14.sp),
                ),
                if (itemIndex > 0)
                  InkWell(
                    onTap: () => onRemoveItem(itemIndex),
                    borderRadius: BorderRadius.circular(24),
                    child: Icon(Icons.delete_outline,
                        color: textWarningColor, size: 24.r),
                  )
              ],
            ),

            SizedBox(height: 16.r),
            TextField(
              controller: item.nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundWhiteColor,
                hintText: 'Item Name',
                hintStyle: greyTextStyle.copyWith(
                    fontSize: 14.sp, fontWeight: FontWeight.w500),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24).r,
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24).r,
                    borderSide: BorderSide(color: textBlueColor)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
              ),
              keyboardType: TextInputType.name,
              style: blackTextStyle.copyWith(
                  fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 8.r),
            DropdownButtonFormField<String>(
              dropdownColor: backgroundWhiteColor,
              style: blackTextStyle.copyWith(
                  fontSize: 14.sp, fontWeight: FontWeight.w500),
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundWhiteColor,
                hintText: 'Category',
                hintStyle: greyTextStyle.copyWith(fontSize: 14.sp),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24).r,
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24).r,
                    borderSide: BorderSide(color: textBlueColor)),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
              ),
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.title,
                  child: Row(
                    children: [
                      Image.asset(category.icon, width: 24.w, height: 24.h),
                      SizedBox(width: 10.r),
                      Text(category.title,
                          style: blackTextStyle.copyWith(
                              fontSize: 14.sp, fontWeight: FontWeight.w500)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) items[itemIndex].category = value;
              },
              isExpanded: true,
            ),
            SizedBox(height: 8.r),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: item.priceController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundWhiteColor,
                      hintText: 'Amount',
                      hintStyle: greyTextStyle.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24).r,
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24).r,
                          borderSide: BorderSide(color: textBlueColor)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.r, vertical: 12.r),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 8.r),
                Expanded(
                  flex: 1,
                  child: TextField(
                    controller: item.quantityController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: backgroundWhiteColor,
                      hintText: 'Qty',
                      hintStyle: greyTextStyle.copyWith(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24).r,
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24).r,
                          borderSide: BorderSide(color: textBlueColor)),
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 16.r, vertical: 12.r),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
