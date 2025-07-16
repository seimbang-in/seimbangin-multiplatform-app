import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionOutcomeFormSection extends StatelessWidget {
  final TextEditingController transactionNameController;
  final List<TransactionItem> items;
  final List<Category> categories;
  final VoidCallback onAddItem;
  final Function(int) onRemoveItem;
  final Function(int, TransactionItem) onItemUpdated;

  const TransactionOutcomeFormSection({
    super.key,
    required this.transactionNameController,
    required this.items,
    required this.categories,
    required this.onAddItem,
    required this.onRemoveItem,
    required this.onItemUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Input untuk nama transaksi secara keseluruhan
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

        // Daftar item yang dinamis
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildItemContainer(context, index);
          },
        ),
        SizedBox(height: 16.r),

        // Tombol untuk menambah item baru
        AddItemTransactButton(
          title: 'Add Another Item',
          onPressed: onAddItem,
        ),
      ],
    );
  }

  /// Membangun UI untuk setiap kartu item.
  Widget _buildItemContainer(BuildContext context, int itemIndex) {
    final item = items[itemIndex];

    return Card(
      color: backgroundGreyColor,
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 18).r,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16).r,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            // Nama Item
            TextFormField(
              initialValue: item.itemName,
              onChanged: (value) {
                onItemUpdated(itemIndex, item.copyWith(itemName: value));
              },
              decoration: _inputDecoration(hintText: 'Item Name'),
              style: blackTextStyle.copyWith(fontSize: 14.sp),
            ),
            SizedBox(height: 8.r),

            // Kategori Item
            DropdownButtonFormField<String>(
              value: item.category.isEmpty ? null : item.category,
              decoration: _inputDecoration(hintText: 'Category'),
              style: blackTextStyle.copyWith(fontSize: 14.sp),
              dropdownColor: backgroundWhiteColor,
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.title,
                  child: Row(
                    children: [
                      Image.asset(category.icon, width: 24.w, height: 24.h),
                      SizedBox(width: 10.r),
                      Text(category.title),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  onItemUpdated(itemIndex, item.copyWith(category: value));
                }
              },
              isExpanded: true,
            ),
            SizedBox(height: 8.r),

            // Harga dan Kuantitas
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    initialValue: item.price == '0' ? '' : item.price,
                    onChanged: (value) {
                      onItemUpdated(itemIndex, item.copyWith(price: value));
                    },
                    decoration: _inputDecoration(hintText: 'Price'),
                    keyboardType: TextInputType.number,
                    style: blackTextStyle.copyWith(fontSize: 14.sp),
                  ),
                ),
                SizedBox(width: 8.r),
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    initialValue:
                        item.quantity == 0 ? '1' : item.quantity.toString(),
                    onChanged: (value) {
                      onItemUpdated(itemIndex,
                          item.copyWith(quantity: int.tryParse(value) ?? 1));
                    },
                    decoration: _inputDecoration(hintText: 'Qty'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper untuk styling input field agar konsisten.
  InputDecoration _inputDecoration({required String hintText}) {
    return InputDecoration(
      filled: true,
      fillColor: backgroundWhiteColor,
      hintText: hintText,
      hintStyle: greyTextStyle.copyWith(fontSize: 14.sp),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24).r,
          borderSide: BorderSide.none),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(24).r,
          borderSide: BorderSide(color: textBlueColor)),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
    );
  }
}
