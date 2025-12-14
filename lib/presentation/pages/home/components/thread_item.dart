part of '../home_page.dart';

extension ThreadItem on HomePage {
  Widget _buildThreadItem(
    BuildContext context, {
    bool isLinkTopic = false,
    bool isVerified = false,
  }) {
    final images = [
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2W50GGieLi2T_e9XHOxA22QI3uTWqmmyg1g&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2W50GGieLi2T_e9XHOxA22QI3uTWqmmyg1g&s",
      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2W50GGieLi2T_e9XHOxA22QI3uTWqmmyg1g&s",
    ];
    final content =
        "Flutter is Google's UI toolkit for building beautiful, natively compiled applications for mobile, web, and desktop from a single codebase.";
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.borderDark, width: 0.5),
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar + User Info & Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAvatarUser(context),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoUser(
                      context,
                      isLinkTopic: isLinkTopic,
                      isVerified: isVerified,
                    ),
                    const SizedBox(height: 4),
                    if (content.isNotEmpty)
                      Text(
                        content,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ],
          ),

          // Media Content
          if (images.isNotEmpty) ...[
            const SizedBox(height: 8),
            _buildMediaContent(context, images),
          ],

          // Action Buttons
          Padding(
            padding: const EdgeInsets.only(left: 50, top: 12),
            child: _buildActionButtons(),
          ),
        ],
      ),
    );
  }
}
