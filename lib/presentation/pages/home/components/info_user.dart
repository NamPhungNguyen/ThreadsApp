part of '../home_page.dart';

extension InfoUser on HomePage {
  Widget _buildInfoUser(
    BuildContext context, {
    bool isLinkTopic = false,
    bool isVerified = false,
  }) {
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
                      const TextSpan(text: "chillWithMe"),
                      // Verified ngay sau username
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
                      // Topic sau verified
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
                        const TextSpan(text: "Flutter Dev"),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 6),
              // Time
              const Text(
                "21h",
                style: TextStyle(color: AppColors.hintText),
              ),
            ],
          ),
        ),
        // Menu dots
        GestureDetector(
          onTap: () => print("Menu"),
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
