import 'package:flutter/material.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';

class AiAdvisorSection extends StatelessWidget {
  const AiAdvisorSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(30),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "Please fill in your financial profile data here first to get Financial AI Advice",
                    style: whiteTextStyle.copyWith(fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: backgroundWhiteColor,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child:
                      Icon(Icons.error_outline, color: primaryColor, size: 30),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
