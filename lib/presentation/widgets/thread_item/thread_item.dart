import 'package:bus_booking/core/constants/app_colors.dart';
import 'package:bus_booking/domain/entities/thread/thread_entity.dart';
import 'package:bus_booking/presentation/widgets/action_button/action_button.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/thread_avatar.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/thread_media_content.dart';
import 'package:bus_booking/presentation/widgets/thread_item/components/thread_user_info.dart';
import 'package:flutter/material.dart';

class ThreadItem extends StatelessWidget {
  const ThreadItem({
    super.key,
    required this.thread,
  });

  final ThreadEntity thread;

  @override
  Widget build(BuildContext context) {
    final hasContent = thread.content != null && thread.content!.isNotEmpty;
    final hasMedia = thread.media.isNotEmpty;

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
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ThreadAvatar(avatarUrl: thread.avatarUrl),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ThreadUserInfo(
                      isLinkTopic: thread.isLinkTopic,
                      isVerified: thread.isVerified,
                    ),
                    if (hasContent) ...[
                      const SizedBox(height: 2),
                      Text(
                        thread.content!,
                        maxLines: 10,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          if (hasMedia) ...[
            const SizedBox(height: 8),
            ThreadMediaContent(media: thread.media),
          ],
          if (hasContent || hasMedia) ...[
            Padding(
              padding: const EdgeInsets.only(left: 50, top: 8),
              child: ThreadActionButtons(
                likeCount: thread.likeCount,
                commentCount: thread.commentCount,
                repostCount: thread.repostCount,
                shareCount: thread.shareCount,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
