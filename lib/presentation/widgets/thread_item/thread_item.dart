import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/presentation/widgets/action_button/action_button.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/thread_avatar.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/thread_media_content.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/thread_user_info.dart';
import 'package:flutter/material.dart';

class ThreadItem extends StatelessWidget {
  const ThreadItem({
    super.key,
    this.avatarUrl,
    this.isLinkTopic = false,
    this.isVerified = false,
    this.images,
    this.content,
    this.likeCount = 0,
    this.commentCount = 0,
    this.repostCount = 0,
    this.shareCount = 0,
  });

  final String? avatarUrl;
  final bool isLinkTopic;
  final bool isVerified;
  final List<String>? images;
  final String? content;
  final int likeCount;
  final int commentCount;
  final int repostCount;
  final int shareCount;

  @override
  Widget build(BuildContext context) {
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
          // Header: Avatar + User Info & Text Content
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThreadAvatar(avatarUrl: avatarUrl),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ThreadUserInfo(
                      isLinkTopic: isLinkTopic,
                      isVerified: isVerified,
                    ),
                    if (content != null && content!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        content!,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),

          // Media Content
          if (images != null && images!.isNotEmpty) ...[
            const SizedBox(height: 8),
            ThreadMediaContent(images: images!),
          ],

          // Action Buttons
          Padding(
            padding: const EdgeInsets.only(left: 50, top: 12),
            child: ThreadActionButtons(
              likeCount: likeCount,
              commentCount: commentCount,
              repostCount: repostCount,
              shareCount: shareCount,
            ),
          ),
        ],
      ),
    );
  }
}

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
        ActionButton(icon: 'assets/icons/heart_post.svg', count: likeCount),
        ActionButton(icon: 'assets/icons/message.svg', count: commentCount),
        ActionButton(icon: 'assets/icons/repost.svg', count: repostCount),
        ActionButton(icon: 'assets/icons/send.svg', count: shareCount),
      ],
    );
  }
}
