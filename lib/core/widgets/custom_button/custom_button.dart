import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../theme/app colors/app_colors.dart';

class CustomButton extends StatelessWidget {
  Color color;
  String text;
  Color textColor;
  final VoidCallback onPressed;
CustomButton({super.key, required this.color, required this.text, required this.textColor, required this.onPressed,});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CupertinoButton(
              borderRadius: BorderRadius.circular(16),
              color: color,
              padding: const EdgeInsets.all(16),
              child: Text(text, style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.w500),),
              onPressed: onPressed,
          ),
        ),
      ],
    );;
  }
}
