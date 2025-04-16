import 'package:flutter/material.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/routes/routes.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});
  final String advisorLogoPath = 'assets/logo-advisor-btn.png';
  final String analyticLogoPath = 'assets/logo-analytic-btn.png';
  final String homeLogoPath = 'assets/logo-home-btn.png';
  final String profileLogoPath = 'assets/logo-profile-btn.png';

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
              _buildNavItem(homeLogoPath, "Home", 0, () {
                routes.pushNamed(RouteNames.home);
              }),
              _buildNavItem(analyticLogoPath, "Analytic", 1, () {
                routes.pushNamed(RouteNames.analytics);
              }),
              SizedBox(width: 40), // Ruang untuk FAB
              _buildNavItem(advisorLogoPath, "Advisor", 2, () {}),
              _buildNavItem(
                profileLogoPath,
                "Profile",
                3,
                () => routes.pushNamed(RouteNames.profile),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(
      String iconPath, String label, int index, GestureTapCallback? onTap) {
    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            iconPath, // Path ke file PNG
            width: 24, // Ukuran lebar ikon
            height: 24, // Ukuran tinggi ikon
          ),
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
