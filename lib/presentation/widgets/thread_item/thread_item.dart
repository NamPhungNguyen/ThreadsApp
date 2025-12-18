import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/domain/entities/media/media_entity.dart';
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
  final List<MediaEntity>? images;
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
                      const SizedBox(height: 2),
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
            ThreadMediaContent(mediaUrls: images!),
          ],
          // Action Buttons
          if ((content != null && content!.isNotEmpty) ||
              images != null && images!.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 8),
              child: ThreadActionButtons(
                likeCount: likeCount,
                commentCount: commentCount,
                repostCount: repostCount,
                shareCount: shareCount,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
