import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/core/utils/number_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThreadActionButtons extends StatelessWidget {
  const ThreadActionButtons({
    super.key,
    required this.likeCount,
    required this.commentCount,
    required this.repostCount,
    required this.shareCount,
  });

  final int likeCount;
  final int commentCount;
  final int repostCount;
  final int shareCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ActionButton(icon: AppIcons.heartPost, count: likeCount),
        ActionButton(icon: AppIcons.message, count: commentCount),
        ActionButton(icon: AppIcons.repost, count: repostCount),
        ActionButton(icon: AppIcons.send, count: shareCount),
      ],
    );
  }
}

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
