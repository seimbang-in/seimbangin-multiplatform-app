import 'package:flutter/material.dart';
import 'package:seimbangin_app/models/advice_model.dart';
import 'package:seimbangin_app/routes/routes.dart';
import 'package:seimbangin_app/shared/theme/theme.dart';
import 'package:seimbangin_app/ui/widgets/buttons_widget.dart';

class AiAdvisorSection extends StatelessWidget {
  final Advice advice;
  final bool isAdviceExist;
  const AiAdvisorSection(
      {super.key, required this.advice, required this.isAdviceExist});

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
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      isAdviceExist
                          ? advice.data
                          : "Please fill in your financial profile data here first to get Financial AI Advice",
                      style:
                          whiteTextStyle.copyWith(fontWeight: FontWeight.bold),
                      softWrap: true,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    AdvisorButton(onPressedEvent: () {
                      routes.pushNamed(RouteNames.chatAdvisor);
                    })
                  ],
                )),
                SizedBox(
                  width: 10,
                ),
                if (!isAdviceExist)
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: backgroundWhiteColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Icon(Icons.error_outline,
                        color: primaryColor, size: 30),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
