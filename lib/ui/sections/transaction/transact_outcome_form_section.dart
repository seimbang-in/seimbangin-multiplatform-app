import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:seimbangin_app/models/item_model.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/sections/transactions_section.dart'; // Asumsi class Category ada di sini
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class TransactionOutcomeFormSection extends StatelessWidget {
  final TextEditingController transactionNameController;
  final List<Item> items;
  final List<Category> categories;
  final VoidCallback onAddItem;
  final VoidCallback onItemChanged;

  const TransactionOutcomeFormSection({
    super.key,
    required this.transactionNameController,
    required this.items,
    required this.categories,
    required this.onAddItem,
    required this.onItemChanged,
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
            hintText: 'Transaction Name (e.g., Monthly Groceries)',
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
                color: textBlueColor,
              ),
            ),
          ),
          style: blackTextStyle.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 20.r),

        // Daftar item yang bisa ditambah secara dinamis
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

  /// Helper method untuk membangun UI setiap item dalam daftar.
  /// Kode ini dipindahkan dari file page utama.
  Widget _buildItemContainer(BuildContext context, int itemIndex) {
    final item = items[itemIndex];

    // Setiap kali ada perubahan pada harga atau kuantitas,
    // panggil callback untuk menghitung ulang total di halaman utama.
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
            Text(
              "Item ${itemIndex + 1}",
              style: blackTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: 16.r),
            TextField(
              controller: item.nameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundWhiteColor,
                hintText: 'Item Name',
                hintStyle: greyTextStyle.copyWith(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24.r),
                  borderSide: BorderSide(color: textBlueColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
              ),
              keyboardType: TextInputType.name,
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 8.r),
            DropdownButtonFormField<String>(
              dropdownColor: backgroundWhiteColor,
              style: blackTextStyle.copyWith(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: backgroundWhiteColor,
                hintText: 'Category',
                hintStyle: greyTextStyle.copyWith(fontSize: 14.sp),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24).r,
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24).r,
                  borderSide: BorderSide(color: textBlueColor),
                ),
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.r, vertical: 12.r),
              ),
              items: categories.map((Category category) {
                return DropdownMenuItem<String>(
                  value: category.title, // Gunakan title sebagai value
                  child: Row(
                    children: [
                      Image.asset(category.icon, width: 24.w, height: 24.h),
                      SizedBox(width: 10.r),
                      Text(
                        category.title,
                        style: blackTextStyle.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (value) {
                // Simpan kategori yang dipilih ke dalam item
                if (value != null) {
                  items[itemIndex].category = value;
                }
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
                      hintText: 'Price',
                      hintStyle: greyTextStyle.copyWith(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: textBlueColor),
                      ),
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
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide(color: textBlueColor),
                      ),
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
