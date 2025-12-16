import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/core/utils/number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    required this.count,
  });

  final String icon;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: GestureDetector(
        onTap: () => print("Action: $icon"),
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: const ColorFilter.mode(
                AppColors.hintText,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              NumberFormatter.formatNumber(count),
              style: const TextStyle(color: AppColors.hintText),
            ),
          ],
        ),
      ),
    );
  }
}
