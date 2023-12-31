import 'package:flutter/material.dart';
import 'package:food_delivery_app/common/color_extension.dart';

enum RoundButtonType { bgPrimary, textPrimary }

class RoundButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final RoundButtonType type;
  final bool isLoading;

  final double fontSize;

  const RoundButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.type = RoundButtonType.bgPrimary,
    this.fontSize = 16,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 56,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            border: type == RoundButtonType.bgPrimary
                ? null
                : Border.all(color: TColor.primary, width: 1),
            color: type == RoundButtonType.bgPrimary
                ? TColor.primary
                : TColor.white,
            borderRadius: BorderRadius.circular(28)),
        child: isLoading
            ? const SizedBox(
                height: 26,
                width: 26,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  color: Colors.white,
                  backgroundColor: Colors.orangeAccent,
                ),
              )
            : Text(
                title,
                style: TextStyle(
                    color: type == RoundButtonType.bgPrimary
                        ? TColor.white
                        : TColor.primary,
                    fontSize: fontSize,
                    fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}
