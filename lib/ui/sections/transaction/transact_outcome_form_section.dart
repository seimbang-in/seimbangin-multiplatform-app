import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/transaction/transaction_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart';

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Input untuk nama transaksi secara keseluruhan
        TextField(
          controller: transactionNameController,
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
                color: const Color(0xffE91E63),
              ),
            ),
            prefixIcon: Icon(Icons.edit_note_rounded, color: textSecondaryColor),
          ),
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 24.r),

        // Daftar item yang dinamis
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (context, index) {
            return _buildItemContainer(context, index);
          },
        ),
        SizedBox(height: 8.r),

        // Tombol untuk menambah item baru
        SizedBox(
          width: double.infinity,
          height: 50.h,
          child: TextButton.icon(
            onPressed: onAddItem,
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xffE91E63).withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
            icon: Icon(Icons.add_circle_outline, color: const Color(0xffE91E63), size: 20.r),
            label: Text(
              'Tambah Barang Lagi',
              style: TextStyle(
                color: const Color(0xffE91E63),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Membangun UI untuk setiap kartu item.
  Widget _buildItemContainer(BuildContext context, int itemIndex) {
    final item = items[itemIndex];

    return Container(
      margin: EdgeInsets.only(bottom: 16.r),
      decoration: BoxDecoration(
        color: backgroundWhiteColor,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: backgroundGreyColor, width: 2.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.r, vertical: 6.r),
                  decoration: BoxDecoration(
                    color: backgroundGreyColor,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    "Barang ${itemIndex + 1}",
                    style: blackTextStyle.copyWith(
                        fontWeight: FontWeight.bold, fontSize: 12.sp),
                  ),
                ),
                if (itemIndex > 0)
                  InkWell(
                    onTap: () => onRemoveItem(itemIndex),
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      padding: EdgeInsets.all(6.r),
                      decoration: BoxDecoration(
                        color: const Color(0xffE91E63).withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.delete_outline,
                          color: const Color(0xffE91E63), size: 20.r),
                    ),
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
              decoration: _inputDecoration(hintText: 'Nama Barang', icon: Icons.shopping_bag_outlined),
              style: blackTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
            ),
            SizedBox(height: 12.r),

            // Kategori Item
            DropdownButtonFormField<String>(
              initialValue: item.category.isEmpty ? null : item.category,
              decoration: _inputDecoration(hintText: 'Pilih Kategori', icon: Icons.category_outlined),
              style: blackTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.w500),
              dropdownColor: backgroundWhiteColor,
              icon: Icon(Icons.keyboard_arrow_down_rounded, color: textSecondaryColor),
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.title,
                  child: Row(
                    children: [
                      Image.asset(category.icon, width: 20.w, height: 20.h),
                      SizedBox(width: 10.r),
                      Text(category.title.replaceFirst(
                          RegExp(r'^[a-z]'), category.title[0].toUpperCase())),
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
            SizedBox(height: 12.r),

            // Harga dan Kuantitas
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    initialValue: item.price == '0' ? '' : item.price,
                    onChanged: (value) {
                      onItemUpdated(itemIndex, item.copyWith(price: value));
                    },
                    decoration: _inputDecoration(hintText: 'Harga', prefix: 'Rp '),
                    keyboardType: TextInputType.number,
                    style: blackTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold, color: const Color(0xffE91E63)),
                  ),
                ),
                SizedBox(width: 12.r),
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    initialValue:
                        item.quantity == 0 ? '1' : item.quantity.toString(),
                    onChanged: (value) {
                      onItemUpdated(itemIndex,
                          item.copyWith(quantity: int.tryParse(value) ?? 1));
                    },
                    decoration: _inputDecoration(hintText: 'Qty', prefix: 'x'),
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: blackTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold),
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
  InputDecoration _inputDecoration({required String hintText, IconData? icon, String? prefix}) {
    return InputDecoration(
      filled: true,
      fillColor: backgroundGreyColor.withOpacity(0.5),
      hintText: hintText,
      hintStyle: greyTextStyle.copyWith(fontSize: 14.sp),
      prefixText: prefix,
      prefixStyle: blackTextStyle.copyWith(fontSize: 14.sp, fontWeight: FontWeight.bold),
      prefixIcon: icon != null ? Icon(icon, color: textSecondaryColor, size: 20.r) : null,
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16).r,
          borderSide: BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16).r,
          borderSide: BorderSide(color: const Color(0xffE91E63))),
      contentPadding: EdgeInsets.symmetric(horizontal: 16.r, vertical: 14.r),
    );
  }
}
