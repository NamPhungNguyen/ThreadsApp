import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final double borderRadius;
  final Color backgroundColor;
  final Color foregroundColor;
  final double height;
  final VoidCallback onPressed;
  final double fontSizeText;
  final bool isLoading;
  const CommonButton({
    super.key,
    required this.text,
    this.borderRadius = 50,
    this.backgroundColor = AppColors.buttonBlue,
    this.foregroundColor = AppColors.textWhite,
    this.height = 51,
    required this.onPressed,
    this.fontSizeText = 16,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: foregroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                ),
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: fontSizeText,
                  fontWeight: FontWeight.w500,
                ),
              ),
      ),
    );
  }
}
