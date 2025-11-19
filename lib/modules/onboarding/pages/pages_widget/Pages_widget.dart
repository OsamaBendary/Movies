import 'package:flutter/material.dart';
import 'package:movies/core/widgets/custom_button/custom_button.dart';
import 'package:movies/modules/onboarding/pages/intro_screen.dart';

import '../../../../core/theme/app colors/app_colors.dart';
import 'pages.dart';

class PagesWidget extends StatelessWidget {
  final Pages pageData;
  final VoidCallback onNextPressed;
  final VoidCallback? onBackPressed;
  PagesWidget({super.key, required this.pageData, required this.onNextPressed, required this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    final List<Pages> pages = Pages.pages;
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(pageData.image), fit: BoxFit.cover),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.black,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40), topRight:  Radius.circular(40)),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Text(pageData.text1, style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold, fontSize: 36,), textAlign: TextAlign.center,),
                  SizedBox(height: 16,),
                  Text(pageData.text2, style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 20,), textAlign: TextAlign.center,),
                  SizedBox(height: 24,),
                  CustomButton(color: AppColors.yellow, text: "Next", textColor: AppColors.black, onPressed: (){onNextPressed();}),
                  if(onBackPressed != null)
                    SizedBox(height: 24,),
                  if(onBackPressed != null)
                  CustomButton(color: AppColors.black, text: "Back", textColor: AppColors.yellow, onPressed: (){onBackPressed!();}),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}
