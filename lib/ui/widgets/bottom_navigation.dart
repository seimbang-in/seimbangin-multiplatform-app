import 'package:flutter/material.dart';
import 'package:seimbangin_app/shared/theme/theme.dart%20%20';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});
  
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 0.0,
        color: buttonColor, // Warna navbar
        child: SizedBox(
          height: 40, // Tambah tinggi agar muat teks
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(Icons.home, "Home", 0),
              _buildNavItem(Icons.analytics, "Analytic", 1),
              SizedBox(width: 40), // Ruang untuk FAB
              _buildNavItem(Icons.chat_bubble, "Advisor", 2),
              _buildNavItem(Icons.dashboard, "More", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(
            height: 4,
          ),
          Text(
            label,
            style: whiteTextStyle.copyWith(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
