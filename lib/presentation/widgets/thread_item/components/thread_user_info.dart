import 'package:bus_booking/core/constants/app_base_path.dart';
import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThreadUserInfo extends StatelessWidget {
  const ThreadUserInfo({
    super.key,
    this.username = 'chillWithMe',
    this.topicName = 'Flutter Dev',
    this.timeAgo = '21h',
    this.isLinkTopic = false,
    this.isVerified = false,
    this.onMenuTap,
  });

  final String username;
  final String topicName;
  final String timeAgo;
  final bool isLinkTopic;
  final bool isVerified;
  final VoidCallback? onMenuTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              // Username + Verified + Topic
              Flexible(
                child: RichText(
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.w500,
                    ),
                    children: [
                      TextSpan(text: username),
                      // Verified badge
                      if (isVerified)
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: SvgPicture.asset(
                              AppIcons.verified,
                              height: 14,
                              width: 14,
                            ),
                          ),
                        ),
                      // Topic link
                      if (isLinkTopic) ...[
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: SvgPicture.asset(
                              AppIcons.arrowRight,
                              height: 14,
                              width: 14,
                              colorFilter: const ColorFilter.mode(
                                AppColors.hintText,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                        TextSpan(text: topicName),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // Time
              Text(
                timeAgo,
                style: const TextStyle(color: AppColors.hintText),
              ),
            ],
          ),
        ),
        // Menu dots
        GestureDetector(
          onTap: onMenuTap ?? () => print("Menu"),
          child: Padding(
            padding: const EdgeInsets.only(left: 8),
            child: SvgPicture.asset(
              AppIcons.dots,
              colorFilter: const ColorFilter.mode(
                AppColors.hintText,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
