import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/color_extension.dart';

class RoundIconButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final String icon;
  final Color color;
  final double fontsize;
  final FontWeight fontWeight;

  const RoundIconButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.icon,
      required this.color,
      this.fontsize = 12,
      this.fontWeight = FontWeight.w500});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: color, borderRadius: BorderRadius.circular(28)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              icon,
              width: 16,
              height: 16,
              fit: BoxFit.contain,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              title,
              style: TextStyle(
                  color: TColor.white,
                  fontSize: fontsize,
                  fontWeight: fontWeight),
            ),
          ],
        ),
      ),
    );
  }
}
